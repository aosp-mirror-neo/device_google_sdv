<!--
  Copyright (C) 2026 The Android Open Source Project

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->

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
