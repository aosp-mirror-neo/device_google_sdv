// Copyright 2023 Google LLC

use android_hardware_security_rkp::aidl::android::hardware::security::keymint::
    IRemotelyProvisionedComponent::{
        BpRemotelyProvisionedComponent, IRemotelyProvisionedComponent,
    };

fn get_default_remotely_provisioned_component_service(
) -> binder::Strong<dyn IRemotelyProvisionedComponent> {
    let remotely_provisioned_component_descriptor: &str =
        <BpRemotelyProvisionedComponent as IRemotelyProvisionedComponent>::get_descriptor();
    let default_remotely_provisioned_component_service_name =
        format!("{}/default", remotely_provisioned_component_descriptor);
    binder::get_interface(&default_remotely_provisioned_component_service_name).unwrap()
}

#[test]
fn default_remotely_provisioned_component_get_hardware_info_test() {
    let remotely_provisioned_component = get_default_remotely_provisioned_component_service();

    let result = remotely_provisioned_component.getHardwareInfo();
    assert!(result.is_ok());
    let hardware_info = result.unwrap();
    assert_eq!(hardware_info.rpcAuthorName, "Google");
}
