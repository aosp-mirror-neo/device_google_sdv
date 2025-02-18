// Copyright 2024 Google LLC

//! Test KeyMint functionalities and integration to SDV. Uses `rdroidtest` ignore_if macro.

use android_hardware_security_rkp::aidl::android::hardware::security::keymint::{
    IRemotelyProvisionedComponent::{
        BpRemotelyProvisionedComponent, IRemotelyProvisionedComponent,
    },
    MacedPublicKey::MacedPublicKey,
};

use anyhow::{anyhow, bail, Context};
use binder::Status;
use log::{info, warn};
use sdv_log::init_logger;

use android_hardware_security_keymint::aidl::android::hardware::security::keymint::{
    Algorithm::Algorithm, AttestationKey::AttestationKey, BeginResult::BeginResult, Digest::Digest,
    EcCurve::EcCurve, ErrorCode::ErrorCode, IKeyMintDevice::BpKeyMintDevice,
    IKeyMintDevice::IKeyMintDevice, KeyCreationResult::KeyCreationResult,
    KeyParameter::KeyParameter, KeyParameterValue::KeyParameterValue, KeyPurpose::KeyPurpose,
    PaddingMode::PaddingMode, Tag::Tag,
};

fn get_default_remotely_provisioned_component_service(
) -> anyhow::Result<binder::Strong<dyn IRemotelyProvisionedComponent>> {
    let remotely_provisioned_component_descriptor: &str =
        <BpRemotelyProvisionedComponent as IRemotelyProvisionedComponent>::get_descriptor();
    let default_remotely_provisioned_component_service_name =
        format!("{remotely_provisioned_component_descriptor}/default");

    binder::get_interface(&default_remotely_provisioned_component_service_name)
        .context("Failed to get IRemotelyProvisionedComponent service")
}

fn get_default_keymint_device_service() -> anyhow::Result<binder::Strong<dyn IKeyMintDevice>> {
    let keymint_descriptor: &str = <BpKeyMintDevice as IKeyMintDevice>::get_descriptor();
    let default_keymint_service_name = format!("{keymint_descriptor}/default");
    binder::get_interface(&default_keymint_service_name)
        .context("Failed to get IKeyMintDevice service")
}

// Parameter for generateEcdsaP256KeyPair(), deprecated since version 3 of the HAL, must always be
// false.
const TEST_MODE: bool = false;

fn generate_certificate_request_v2() -> anyhow::Result<(Vec<u8>, Vec<u8>)> {
    let remotely_provisioned_component = get_default_remotely_provisioned_component_service()?;

    let mut maced_public_key = MacedPublicKey { macedKey: vec![] };
    let irpc_key_blob = remotely_provisioned_component
        .generateEcdsaP256KeyPair(TEST_MODE, &mut maced_public_key)
        .context("generateEcdsaP256KeyPair() failed")?;
    assert!(!irpc_key_blob.is_empty());
    assert!(!maced_public_key.macedKey.is_empty());
    // The macedKey doesn't only contain zeros.
    assert_ne!(maced_public_key.macedKey, vec![0; maced_public_key.macedKey.len()]);

    // Sign the attestation key by the KeyMint (SecureWorld) DICE Chain using the IRPC.
    const CHALLENGE: [u8; 3] = [1, 2, 3];
    let certificate_request = remotely_provisioned_component
        .generateCertificateRequestV2(&[maced_public_key], &CHALLENGE)
        .context("generateCertificateRequestV2() failed")?;
    Ok((certificate_request, irpc_key_blob))
}

fn create_attestation_key(attestation_key_blob: Vec<u8>) -> AttestationKey {
    // Hardcode a DER encoded test cert name, because it requires openssl::x509::X509NameBuilder
    // and openssl has a limited visibility.
    // let cert_subject = "test cert subject";
    // let mut x509_name = X509NameBuilder::new().unwrap();
    // x509_name.append_entry_by_text("CN", cert_subject).unwrap();
    // let x509_name = x509_name.build().to_der().unwrap();
    // assert_eq!(
    //     std::str::from_utf8(&x509_name).unwrap(),
    //     "0\u{1c}1\u{1a}0\u{18}\u{6}\u{3}U\u{4}\u{3}\u{c}\u{11}test cert subject"
    // );
    let x509_name = "0\u{1c}1\u{1a}0\u{18}\u{6}\u{3}U\u{4}\u{3}\u{c}\u{11}test cert subject"
        .as_bytes()
        .to_vec();

    AttestationKey {
        keyBlob: attestation_key_blob,
        attestKeyParams: vec![],
        issuerSubjectName: x509_name,
    }
}

fn validity_key_parameters() -> Vec<KeyParameter> {
    // Per RFC 5280 4.1.2.5, an undefined expiration (not-after) field should be set to
    // GeneralizedTime 999912312359559, which is 253402300799000 ms from Jan 1, 1970.
    const UNDEFINED_NOT_AFTER: i64 = 253402300799000i64;
    vec![
        KeyParameter { tag: Tag::CERTIFICATE_NOT_BEFORE, value: KeyParameterValue::DateTime(0) },
        KeyParameter {
            tag: Tag::CERTIFICATE_NOT_AFTER,
            value: KeyParameterValue::DateTime(UNDEFINED_NOT_AFTER),
        },
    ]
}

fn attestation_key_parameters() -> Vec<KeyParameter> {
    vec![
        KeyParameter {
            tag: Tag::ATTESTATION_CHALLENGE,
            value: KeyParameterValue::Blob(b"Some Challenge".to_vec()),
        },
        KeyParameter {
            tag: Tag::ATTESTATION_APPLICATION_ID,
            value: KeyParameterValue::Blob(b"Some attestation application ID".to_vec()),
        },
    ]
}

fn generate_keymint_rsa_key(
    ikeymint_device: &binder::Strong<dyn IKeyMintDevice>,
    extra_key_parameters: Vec<KeyParameter>,
    attestation_key_blob: Option<Vec<u8>>,
) -> binder::Result<KeyCreationResult> {
    let mut key_parameters = extra_key_parameters;
    // A minimum set of key parameters that makes generateKey() succeed.
    key_parameters.extend([
        KeyParameter { tag: Tag::PURPOSE, value: KeyParameterValue::KeyPurpose(KeyPurpose::SIGN) },
        KeyParameter { tag: Tag::ALGORITHM, value: KeyParameterValue::Algorithm(Algorithm::RSA) },
        KeyParameter { tag: Tag::DIGEST, value: KeyParameterValue::Digest(Digest::NONE) },
        KeyParameter {
            tag: Tag::PADDING,
            value: KeyParameterValue::PaddingMode(PaddingMode::NONE),
        },
        KeyParameter { tag: Tag::KEY_SIZE, value: KeyParameterValue::Integer(2048) },
        KeyParameter {
            tag: Tag::RSA_PUBLIC_EXPONENT,
            value: KeyParameterValue::LongInteger(65537),
        },
    ]);
    key_parameters.append(&mut validity_key_parameters());
    let attestation_key = match attestation_key_blob {
        None => None,
        Some(attestation_key_blob) => {
            key_parameters.append(&mut attestation_key_parameters());
            Some(create_attestation_key(attestation_key_blob))
        }
    };
    ikeymint_device.generateKey(&key_parameters, attestation_key.as_ref())
}

fn generate_keymint_ecdsa_key(
    ikeymint_device: &binder::Strong<dyn IKeyMintDevice>,
    extra_key_parameters: Vec<KeyParameter>,
    attestation_key_blob: Option<Vec<u8>>,
) -> binder::Result<KeyCreationResult> {
    let mut key_parameters = extra_key_parameters;
    // A minimum set of key parameters that makes generateKey() succeed.
    key_parameters.extend([
        KeyParameter { tag: Tag::PURPOSE, value: KeyParameterValue::KeyPurpose(KeyPurpose::SIGN) },
        KeyParameter { tag: Tag::ALGORITHM, value: KeyParameterValue::Algorithm(Algorithm::EC) },
        KeyParameter { tag: Tag::EC_CURVE, value: KeyParameterValue::EcCurve(EcCurve::P_256) },
        KeyParameter { tag: Tag::DIGEST, value: KeyParameterValue::Digest(Digest::NONE) },
    ]);
    key_parameters.append(&mut validity_key_parameters());
    let attestation_key = match attestation_key_blob {
        None => None,
        Some(attestation_key_blob) => {
            key_parameters.append(&mut attestation_key_parameters());
            Some(create_attestation_key(attestation_key_blob))
        }
    };
    ikeymint_device.generateKey(&key_parameters, attestation_key.as_ref())
}

fn begin_keymint_sign_operation(
    ikeymint_device: &binder::Strong<dyn IKeyMintDevice>,
    key_blob: &[u8],
    digest: Digest,
) -> binder::Result<BeginResult> {
    // These are the minimum required key parameters for the sign operation not to return with an
    // error.
    let key_parameters = [
        KeyParameter { tag: Tag::DIGEST, value: KeyParameterValue::Digest(digest) },
        KeyParameter {
            tag: Tag::PADDING,
            value: KeyParameterValue::PaddingMode(PaddingMode::NONE),
        },
    ];
    ikeymint_device.begin(KeyPurpose::SIGN, key_blob, &key_parameters, None)
}

#[test]
fn default_remotely_provisioned_component_get_hardware_info_test() -> anyhow::Result<()> {
    let remotely_provisioned_component = get_default_remotely_provisioned_component_service()?;

    let hardware_info =
        remotely_provisioned_component.getHardwareInfo().context("Failed to get HardwareInfo")?;
    assert_eq!(hardware_info.rpcAuthorName, "Google");
    Ok(())
}

fn android15_hwtrust_session() -> hwtrust::session::Session {
    use hwtrust::dice::ProfileVersion;
    use hwtrust::session::DiceProfileRange;
    use hwtrust::session::Options;
    use hwtrust::session::Session;

    // Session contains the options for the DICE verification.
    let mut session = Session {
        options: Options {
            // Accepting the profile versions from android.15 until the latest, WIP, android.16.
            dice_profile_range: DiceProfileRange::new(
                ProfileVersion::Android15,
                ProfileVersion::Android16,
            ),
            ..Default::default()
        },
    };
    // SDV profile for DICE allows any Open Profile for DICE Mode Value, not just Normal.
    session.set_allow_any_mode(true);
    session
}

#[test]
fn generate_certificate_request_v2_returns_android15_dice_chain() -> anyhow::Result<()> {
    let (certificate_request, _) = generate_certificate_request_v2()?;

    // from_cbor parses and verifies the DICE chain according to the options specified in the
    // Session object
    hwtrust::rkp::Csr::from_cbor(&android15_hwtrust_session(), certificate_request.as_slice())
        .context("Failed to parse the CSR from KeyMint")?;
    Ok(())
}

// Creates a PEM file containing the KeyMint UDS public key that can be used, for example,
// to issue a test UDS certificate for. To obtain the PEM file, after running the test, execute:
// adb pull /data/local/tmp/keymint_uds_pub.pem
#[test]
fn save_keymint_uds_pub_to_file() -> anyhow::Result<()> {
    use hwtrust::dice::ChainForm;
    use hwtrust::rkp::Csr;
    use std::io::Write;

    let (certificate_request, _) = generate_certificate_request_v2()?;

    // from_cbor parses and verifies the DICE chain according to the options specified in the
    // Session object
    let csr = Csr::from_cbor(&android15_hwtrust_session(), certificate_request.as_slice())
        .context("Failed to parse the CSR from KeyMint")?;
    let pem = match csr {
        Csr::V3 { dice_chain, .. } => match dice_chain {
            ChainForm::Proper(chain) => chain.root_public_key().to_pem(),
            ChainForm::Degenerate(deg_chain) => deg_chain.public_key().to_pem(),
        },
        _ => bail!("CSR V2 is not supported!"),
    };

    let mut cbor_file = std::fs::File::create("/data/local/tmp/keymint_uds_pub.pem")
        .context("Failed to save UDS pub file")?;

    cbor_file.write_all(pem.as_bytes()).context("Failed to write CBOR file")?;

    Ok(())
}

#[test]
fn sdv_attestation_keymint_primitives_with_rsa_test() -> anyhow::Result<()> {
    init_logger("sdv_keymint_test").context("init_logger() failed")?;
    let remotely_provisioned_component = get_default_remotely_provisioned_component_service()?;

    // Generate an attestation key using the IRemotelyProvisionedComponent (shortened to IRPC from
    // now on in this test).
    let mut maced_public_key = MacedPublicKey { macedKey: vec![] };
    // Deprecated field since version 3 of the HAL, must always be false
    let test_mode = false;
    let irpc_key_blob = remotely_provisioned_component
        .generateEcdsaP256KeyPair(test_mode, &mut maced_public_key)
        .context("generateEcdsaP256KeyPair() failed")?;
    assert!(!irpc_key_blob.is_empty());
    assert!(!maced_public_key.macedKey.is_empty());
    // The macedKey doesn't only contain zeros.
    assert_ne!(maced_public_key.macedKey, vec![0; maced_public_key.macedKey.len()]);

    let keymint_device = get_default_keymint_device_service()?;

    // Generate a new key that can be used for regular KeyMint operations, such as signing
    // arbitrary data. The irpc_key_blob will be set as the attestation key, this way, the
    // key is bound to the KeyMint DICE Chain.
    let attested_key_creation_result =
        generate_keymint_rsa_key(&keymint_device, vec![], Some(irpc_key_blob))
            .context("generate_keymint_rsa_key() failed")?;

    info!(
        "KeyMint key - keyCharacteristics: {:?}",
        attested_key_creation_result.keyCharacteristics
    );
    info!("KeyMint key - certificateChain: {:?}", attested_key_creation_result.certificateChain);

    // Test a simple begin sign operation
    let begin_result = begin_keymint_sign_operation(
        &keymint_device,
        &attested_key_creation_result.keyBlob,
        Digest::NONE,
    )
    .context("Failed to begin sign operation")?;
    let signature = begin_result
        .operation
        .ok_or_else(|| anyhow!("Operation is missing"))?
        .finish(Some(b"Some arbitrary input to be signed."), None, None, None, None)
        .context("Failed to finish sign operation")?;
    assert!(!signature.is_empty());
    info!("Signature is: {:x?}", signature);
    Ok(())
}

#[test]
fn sdv_attestation_keymint_primitives_with_ecdsa_test() -> anyhow::Result<()> {
    init_logger("sdv_keymint_test").context("init_logger() failed")?;
    let remotely_provisioned_component = get_default_remotely_provisioned_component_service()?;

    // Generate an attestation key using the IRemotelyProvisionedComponent (shortened to IRPC from
    // now on in this test).
    let mut maced_public_key = MacedPublicKey { macedKey: vec![] };
    let irpc_key_blob = remotely_provisioned_component
        .generateEcdsaP256KeyPair(TEST_MODE, &mut maced_public_key)
        .context("generateEcdsaP256KeyPair() failed")?;
    assert!(!irpc_key_blob.is_empty());
    assert!(!maced_public_key.macedKey.is_empty());
    // The macedKey doesn't only contain zeros.
    assert_ne!(maced_public_key.macedKey, vec![0; maced_public_key.macedKey.len()]);

    let keymint_device = get_default_keymint_device_service()?;

    // Generate a new key that can be used for regular KeyMint operations, such as signing
    // arbitrary data. The irpc_key_blob will be set as the attestation key, this way, the
    // key is bound to the KeyMint DICE Chain.
    let attested_key_creation_result =
        generate_keymint_ecdsa_key(&keymint_device, vec![], Some(irpc_key_blob))
            .context("generate_keymint_ecdsa_key() failed")?;

    info!(
        "KeyMint key - keyCharacteristics: {:?}",
        attested_key_creation_result.keyCharacteristics
    );
    info!("KeyMint key - certificateChain: {:?}", attested_key_creation_result.certificateChain);

    // Test a simple begin sign operation
    let begin_result = begin_keymint_sign_operation(
        &keymint_device,
        &attested_key_creation_result.keyBlob,
        Digest::NONE,
    )
    .context("Failed to begin sign operation")?;
    let signature = begin_result
        .operation
        .ok_or_else(|| anyhow!("Operation is missing"))?
        .finish(Some(b"Some arbitrary input to be signed."), None, None, None, None)
        .context("Failed to finish sign operation")?;
    assert!(!signature.is_empty());
    info!("Signature is: {:x?}", signature);
    Ok(())
}

#[test]
fn iremotely_provisioned_key_is_only_an_attest_key_test() -> anyhow::Result<()> {
    let (certificate_request, irpc_key_blob) = generate_certificate_request_v2()?;
    assert!(!certificate_request.is_empty());

    let keymint_device = get_default_keymint_device_service()?;

    // Cannot use the irpc_key_blob, the key generated by generateEcdsaP256KeyPair(),
    // directly for sign operations, because it only has KeyPurpose::ATTEST_KEY. See:
    // https://source.corp.google.com/h/googleplex-android/platform/superproject/main/+/main:hardware/interfaces/security/keymint/aidl/android/hardware/security/keymint/KeyPurpose.aidl;l=52;drc=8d925aee2d07535cad2e0276fd4ac1d6c4e18095
    // https://source.corp.google.com/h/googleplex-android/platform/superproject/main/+/main:system/keymaster/android_keymaster/android_keymaster.cpp;l=384;drc=b7822b0ee6d0f8081cc6d733ce15ec8df7f90a2f
    // (The attestation key could only be used with Digest::SHA_2_256, if could have been used at
    // all for signing. Providing an incorrect digest makes the operation fail with a different
    // error.)
    let result = begin_keymint_sign_operation(&keymint_device, &irpc_key_blob, Digest::SHA_2_256);
    assert!(result.is_err());
    // This fails, because irpc_key_blob only has KeyPurpose::ATTEST_KEY.
    assert_eq!(
        result.unwrap_err(),
        Status::new_service_specific_error(ErrorCode::INCOMPATIBLE_PURPOSE.0, None)
    );
    Ok(())
}

#[test]
fn sdv_keymint_delete_key_test() -> anyhow::Result<()> {
    init_logger("sdv_keymint_test").context("init_logger() failed")?;

    let keymint_device = get_default_keymint_device_service()?;

    let key_creation_result = generate_keymint_rsa_key(
        &keymint_device,
        vec![KeyParameter {
            tag: Tag::ROLLBACK_RESISTANCE,
            value: KeyParameterValue::BoolValue(true),
        }],
        None,
    );

    if key_creation_result.is_err() {
        assert_eq!(
            key_creation_result.unwrap_err(),
            Status::new_service_specific_error(ErrorCode::ROLLBACK_RESISTANCE_UNAVAILABLE.0, None)
        );
        // The pure soft KeyMint doesn't support rollback resistance
        warn!("deleteKey() is not supported: rollback resistance unavailable: ");
        return Ok(());
    }

    let key_creation_result = key_creation_result.unwrap();

    keymint_device.deleteKey(&key_creation_result.keyBlob).context("deleteKey() failed")?;

    let result =
        begin_keymint_sign_operation(&keymint_device, &key_creation_result.keyBlob, Digest::NONE);
    assert!(result.is_err());
    assert_eq!(
        result.unwrap_err(),
        Status::new_service_specific_error(ErrorCode::INVALID_KEY_BLOB.0, None)
    );
    Ok(())
}

#[test]
fn iremotely_provisioned_key_cannot_be_deleted_test() -> anyhow::Result<()> {
    let remotely_provisioned_component = get_default_remotely_provisioned_component_service()?;

    let mut maced_public_key = MacedPublicKey { macedKey: vec![] };
    let irpc_key_blob = remotely_provisioned_component
        .generateEcdsaP256KeyPair(TEST_MODE, &mut maced_public_key)
        .context("generateEcdsaP256KeyPair() failed")?;
    assert!(!irpc_key_blob.is_empty());
    assert!(!maced_public_key.macedKey.is_empty());
    // The macedKey doesn't only contain zeros.
    assert_ne!(maced_public_key.macedKey, vec![0; maced_public_key.macedKey.len()]);

    let keymint_device = get_default_keymint_device_service()?;

    // Trying to delete the key generated using the IRemotelyProvisionedComponent, but it will
    // actually be a no-op: deleteKey() is only supported if the KeyMint implementation supports
    // rollback resistance, and only for keys that have Tag::ROLLBACK_RESISTANCE, which is not
    // necesseraly true for the key returned by generateEcdsaP256KeyPair()
    // TODO: maybe this can be checked using the getKeyCharacteristics()?
    keymint_device.deleteKey(&irpc_key_blob).context("deleteKey() failed")?;

    // The deleteKey() call was a no-op: the IRPC key can still be used as an attest key
    generate_keymint_rsa_key(&keymint_device, vec![], Some(irpc_key_blob))
        .context("generate_keymint_rsa_key() failed")?;
    Ok(())
}
