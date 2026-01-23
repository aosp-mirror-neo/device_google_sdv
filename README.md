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

# SDV lunch targets

This directory contains Makefiles used to define SDV lunch targets.

## Hierarchy

![SDV makefiles diagram](./doc/sdv-makefiles.svg)

## Inheritable lunch targets

OEM-defined targets are intended to derive from those base targets as needed.
OEM targets are intended to directly inherit from one SDV "base" target, and a
"vendor" target.

### SDV "base" targets

*   `sdv_base` is the base for lunch targets that need to communicate with the
    SDV system using SDV communications stack.

*   `sdv_core_base` is the base for lunch targets that need the full set of SDV
    Core services.

*   `sdv_media_base` is the base for lunch targets that, aside from SDV Core
    services, also require media API support.

*   `sdv_ivi_base` is the base for AAOS IVI lunch targets capable of
    communicating with SDV services on other VMs.

### Vendor targets

*   `sdv_cf` contains Cuttlefish-specific functionality specific to SDV
    Core-derived targets. Note that it's *not* used by `sdv_ivi_cf`.

## Sample targets

`sdv_core_cf`, `sdv_media_cf` and `sdv_ivi_cf` are examples of the complete SDV
targets derived from the ones above.

## Configuration overrides

Downstream lunch targets can provide their own configuration for some SDV
components defined by SDV "base" targets.

See `sdv_core_cf/sdv_core_cf.mk` for an example of injecting custom
target-specific configuration.

## Custom OEM partitions

To build a sample OEM partition and run SDV with it mounted on `/oem_ab`:

```
source build/envsetup.sh
lunch sdv_core_cf-trunk_staging-userdebug
m
cvd create --custom_partition_path=$OUT/oem_ab.img
```

### Configuration

To create a custom partition image:

*   See `sdv_core_base/oem/oem_ab.mk` and `sdv_core_base/oem/Android.bp` for
    defining a custom partition.
*   The custom disk image is automatically built when running `m`.

To mount the custom partition with Cuttlefish:

*   In `BoardConfig.mk`, add the partition mount point to
    `BOARD_ROOT_EXTRA_FOLDERS` to ensure it exists in the root filesystem.

    See `sdv_core_cf/BoardConfig.mk` for an example of setting up the `/oem_ab`
    directory.

*   Add an `fstab` entry for the partition. The custom partition will be visible
    to the VM as `/dev/block/by-name/custom`.

    See `sdv_core_cf/fstab.sdv` for an example of mounting the oem_metadata
    partition to the `/oem_metadata` path on the device.

*   Set up SELinux policy rules for the new partition contents, and allow init
    to mount it. See `sdv_core_base/oem/sepolicy/oem_ab/private/oem_ab.te` and
    `sdv_core_base/oem/sepolicy/oem_ab/private/file_contexts`.

*   Build `sdv_core_cf` target with `lunch sdv_core_cf-trunk_staging-userdebug
    && m`.

*   Run Cuttlefish and pass the custom partition image when starting.

    ```
    cvd create --custom_partition_path=$OUT/oem_ab.img
    ```

The VM will boot and expose the OEM partition contents under `/oem_ab` path.
