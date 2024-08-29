<!-- Copyright 2024 Google LLC -->

# SDV lunch targets

This directory contains Makefiles used to define SDV lunch targets.

## Hierarchy

![SDV makefiles diagram](./doc/sdv-makefiles.svg)

## Inheritable lunch targets

OEM-defined targets are intended to derive from those base targets as needed.
OEM targets are intended to directly inherit from one SDV "base" target, and a
"vendor" target.

### SDV "base" targets

* `sdv_base` is the base for lunch targets that need to communicate with the SDV
  system using SDV communications stack.

* `sdv_core_base` is the base for lunch targets that need the full set of SDV
  Core services.

* `sdv_media_base` is the base for lunch targets that, aside from SDV Core
  services, also require media API support.

* `sdv_ivi_base` is the base for AAOS IVI lunch targets capable of communicating
  with SDV services on other VMs.

### Vendor targets

* `sdv_cf` contains Cuttlefish-specific functionality specific to SDV
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

To build a sample OEM partition and run SDV with it mounted on `/oem`:

```
source build/envsetup.sh
lunch sdv_core_cf-trunk_staging-userdebug
m custom_images
m
cvd start --custom_partition_path=$OUT/oem.img
```

### Configuration

To create a custom partition image:

* Create a Makefile that defines the custom partition properties and contents.
  For an example, see `sdv_core_cf/oem/oem.mk`.

  A complete list of supported custom image properties is documented in
  [`build/make/core/tasks/build_custom_images.mk`](https://cs.android.com/android/platform/superproject/main/+/main:build/make/core/tasks/build_custom_images.mk).

* In `BoardConfig.mk`, assign the custom partition Makefile path to
  `PRODUCT_CUSTOM_IMAGE_MAKEFILES`.

  See `sdv_core_cf/BoardConfig.mk` for an example.

* Build custom disk images with `m custom_images`. Note that this is *not*
  included in the default `m` build.

To mount the custom partition with Cuttlefish:

* In `BoardConfig.mk`, add the partition mount point to
  `BOARD_ROOT_EXTRA_FOLDERS` to ensure it exists in the root filesystem.

  See `sdv_core_cf/BoardConfig.mk` for an example of setting up the `/oem`
  directory.

* Add an `fstab` entry for the partition. The custom partition will be visible
  to the VM as `/dev/block/by-name/custom`.

  See `sdv_core_cf/fstab.sdv` for an example of mounting the partition to
  `/oem` path on the device.

* Set up SELinux policy rules for the new partition contents, and allow `init`
  to mount it.

  When using `/oem` as the mount point, the `file_contexts` for all
  its files are already configured in
  [`system/sepolicy/private/file_contexts`](https://cs.android.com/android/platform/superproject/main/+/main:system/sepolicy/private/file_contexts;l=472;drc=dda7487085ab94b5c46edae5a6633a3440eeed19),
  and the only thing missing is allowing `init` process to mount on the `/oem`
  path.

  See `sdv_core_cf/sepolicy/system_ext/private/init.te` for an example of
  required rules.

* Build `sdv_core_cf` target with `lunch sdv_core_cf-trunk_staging-userdebug && m`.

* Run Cuttlefish and pass the custom partition image when starting.

  ```
  cvd start --custom_partition_path=$OUT/oem.img
  ```

The VM will boot and expose the OEM partition contents under `/oem` path.
