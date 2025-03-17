<!-- Copyright 2025 Google LLC -->

Files for pre-provisioned vvmtruststore images of the SDV VM instances of the
SDV dev mesh defined in [vvmconfig.example]. Meant for development and testing
purposes.

Directory structure:

*   VM instance name
    *   `vvmtruststore`

### Updating

#### Perform the factory provisioning flow

See the [sdv_provisioning_tool documentation].

Copy the output of the `sdv_provisioning_tool` to
`sdv_base/vvmtruststore_preprovisioned/vvmfactorytrust-vm_certs` for easy
reference. Note that it will be the same for all VM instances.

#### Copy the provisioned files

Execute from this directory:

```bash
rm -rf instance1/vvmtruststore
adb -s 0.0.0.0:6520 pull /vvmtruststore instance1/vvmtruststore

rm -rf instance2/vvmtruststore
adb -s 0.0.0.0:6521 pull /vvmtruststore instance2/vvmtruststore

rm -rf instance3/vvmtruststore
adb -s 0.0.0.0:6522 pull /vvmtruststore instance3/vvmtruststore
```

#### Update the Soong modules

Edit the `Android.bp`, if needed.

#### Update sdv-cf script

Update the vvmfactorytrust that is passed to cvd when the `--preprovisioned`
option in [sdv-cf.sh] is present.

[vvmconfig.example]: /system/software_defined_vehicle/core_services/samples/vvmconfig_generator/README.md
[sdv_provisioning_tool documentation]: /system/software_defined_vehicle/core_services/tools/sdv_provisioning_tool/README.md
[sdv-cf.sh]: /system/software_defined_vehicle/platform/tools/sdv-cf/sdv-cf.sh
