// Copyright 2023 Google LLC

use android_hardware_security_keymint::aidl::android::hardware::security::keymint::{
    Digest::Digest, EcCurve::EcCurve, KeyPurpose::KeyPurpose, SecurityLevel::SecurityLevel,
};
use android_system_keystore2::aidl::android::system::keystore2::{
    Domain::Domain, IKeystoreOperation::IKeystoreOperation, IKeystoreService::IKeystoreService,
    KeyDescriptor::KeyDescriptor,
};

use keystore2_test_utils::{authorizations, get_keystore_service, key_generations};

/// Performs sample signing operation.
pub fn perform_sample_sign_operation(
    op: &binder::Strong<dyn IKeystoreOperation>,
) -> Result<(), binder::Status> {
    op.update(b"my message")?;
    let sig = op.finish(None, None)?;
    assert!(sig.is_some());
    Ok(())
}

/// Delete a key with domain APP.
pub fn delete_app_key(
    keystore2: &binder::Strong<dyn IKeystoreService>,
    alias: Option<String>,
) -> binder::Result<()> {
    keystore2.deleteKey(&KeyDescriptor { domain: Domain::APP, nspace: -1, alias, blob: None })
}

/// Based on the keystore2_find_key_with_key_id_as_domain from the keystore2_client_tests
#[test]
fn sdv_keystore2_find_key_with_key_id_as_domain() {
    let keystore2 = get_keystore_service();
    let sec_level = keystore2.getSecurityLevel(SecurityLevel::TRUSTED_ENVIRONMENT).unwrap();

    let alias = Some("sdv_keystore_test_alias".to_string());

    let key_metadata = key_generations::generate_ec_key(
        &sec_level,
        Domain::APP,
        -1,
        alias.clone(),
        EcCurve::P_256,
        Digest::SHA_2_256,
    )
    .expect("Failed to generate a EC key.");

    let key_entry_response = keystore2
        .getKeyEntry(&KeyDescriptor {
            domain: Domain::KEY_ID,
            nspace: key_metadata.key.nspace,
            alias: alias.clone(),
            blob: None,
        })
        .expect("Error in getKeyEntry to load a key with domain KEY_ID.");

    // Verify above found key is same the one generated.
    assert_eq!(key_metadata.key, key_entry_response.metadata.key);
    assert_eq!(key_metadata.certificate, key_entry_response.metadata.certificate);
    assert_eq!(key_metadata.certificateChain, key_entry_response.metadata.certificateChain);

    // Try to create an operation using above loaded key, operation should be created
    // successfully.
    let op_response = sec_level
        .createOperation(
            &key_entry_response.metadata.key,
            &authorizations::AuthSetBuilder::new()
                .purpose(KeyPurpose::SIGN)
                .digest(Digest::SHA_2_256),
            false,
        )
        .expect("Error in creation of operation.");

    assert!(op_response.iOperation.is_some());
    perform_sample_sign_operation(&op_response.iOperation.unwrap())
        .expect("Error in performing sample sign operation.");

    delete_app_key(&keystore2, alias.clone()).expect("Error in deleting generated key.");
}
