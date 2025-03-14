# Copyright 2024 Google LLC

sdv_binary_pdk_dir := $(PRODUCT_OUT)/sdv-binary-pdk
sdv_binary_pdk_collector := $(HOST_OUT)/bin/binary_pdk_collector
sdv-binary-pdk-zip := $(sdv_binary_pdk_dir)/sdv-binary-pdk.zip
sdv_binary_pdk_file_report := $(sdv_binary_pdk_dir)/file_report.txt
sdv_binary_pdk_packages_dir := $(sdv_binary_pdk_dir)/packages
sdv_binary_pdk_archive_dir := $(sdv_binary_pdk_dir)/archive
sdv_binary_pdk_cpu_variant_suffix := $(if $(filter generic,$(TARGET_CPU_VARIANT)),,$(addprefix _,$(TARGET_CPU_VARIANT)))
sdv_binary_pdk_architecture := $(TARGET_ARCH)_$(TARGET_ARCH_VARIANT)$(sdv_binary_pdk_cpu_variant_suffix)

# Set SDV_BINARY_PDK_OVERRIDE_MODULES_FILE to the module override file
# to override which modules are collected; or to add modules which are
# collected for other targets

# These variables contain Soong modules that are not required by targets on the
# device, but we need them to compile a code (e.g., samples) on the binary PDK.
SDV_BINARY_PDK_HOST_PACKAGES :=
SDV_BINARY_PDK_HOST_SAMPLES_PACKAGES :=
# com.sdv.google.gateway.client and libsdvgatewayclient
# are already automatically included on ivi targets.
SDV_BINARY_PDK_PACKAGES := \
  com.sdv.google.gateway.client \
  libsdvgatewayclient

SDV_BINARY_PDK_SAMPLES_PACKAGES :=

SDV_BINARY_PDK_OEM_VARS ?=
SDV_BINARY_PDK_OEM_HOST_VARS ?=

sdv_binary_pdk_vars := \
  $(SDV_BINARY_PDK_OEM_VARS) \
  $(SDV_BINARY_PDK_OEM_HOST_VARS) \
  SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES \
  SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES \
  SDV_AUTOMOTIVE_SERVICES_PACKAGES \
  SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES \
  SDV_BASE_SERVICES_HOST_PACKAGES \
  SDV_BASE_SERVICES_HOST_SAMPLES_PACKAGES \
  SDV_BASE_SERVICES_PACKAGES \
  SDV_BASE_SERVICES_SAMPLES_PACKAGES \
  SDV_BINARY_PDK_HOST_PACKAGES \
  SDV_BINARY_PDK_HOST_SAMPLES_PACKAGES \
  SDV_BINARY_PDK_PACKAGES \
  SDV_BINARY_PDK_SAMPLES_PACKAGES \
  SDV_CORE_SERVICES_HOST_PACKAGES \
  SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES \
  SDV_CORE_SERVICES_PACKAGES \
  SDV_CORE_SERVICES_SAMPLES_PACKAGES \
  SDV_CORE_TELEMETRY_HOST_PACKAGES \
  SDV_CORE_TELEMETRY_HOST_SAMPLES_PACKAGES \
  SDV_CORE_TELEMETRY_PACKAGES \
  SDV_CORE_TELEMETRY_SAMPLES_PACKAGES \
  SDV_IVI_SERVICES_HOST_PACKAGES \
  SDV_IVI_SERVICES_HOST_SAMPLES_PACKAGES \
  SDV_IVI_SERVICES_PACKAGES \
  SDV_IVI_SERVICES_SAMPLES_PACKAGES \
  SDV_IVI_TELEMETRY_HOST_PACKAGES \
  SDV_IVI_TELEMETRY_HOST_SAMPLES_PACKAGES \
  SDV_IVI_TELEMETRY_PACKAGES \
  SDV_IVI_TELEMETRY_SAMPLES_PACKAGES \
  SDV_PLATFORM_HOST_PACKAGES \
  SDV_PLATFORM_HOST_SAMPLES_PACKAGES \
  SDV_PLATFORM_PACKAGES \
  SDV_PLATFORM_SAMPLES_PACKAGES

sdv-all-targets := $(foreach var,$(sdv_binary_pdk_vars), $(strip $($(var))) )
sdv-all-targets-files := $(foreach m, $(sdv-all-targets), $(sort $(ALL_MODULES.$(m).INSTALLED)))

sdv-binary-pdk: module-info $(sdv_binary_pdk_collector) $(sdv-all-targets) $(sdv-binary-pdk-zip)
sdv-binary-pdk: $(sdv-binary-pdk-zip)

$(sdv-binary-pdk-zip): .KATI_IMPLICIT_OUTPUTS := $(sdv_binary_pdk_file_report)

$(sdv-binary-pdk-zip): $(sdv_binary_pdk_collector) $(sdv-all-targets-files) $(BUILT_SYSTEMIMAGE) $(BUILT_VENDORIMAGE_TARGET) $(BUILT_PRODUCTIMAGE_TARGET) $(BUILT_SYSTEM_EXTIMAGE_TARGET) $(MODULE_INFO_JSON) $(SOONG_ZIP)
	$(hide) rm -rf $(sdv_binary_pdk_packages_dir)
	$(hide) mkdir -p $(sdv_binary_pdk_packages_dir)

  # TODO(b/400341311): remove the .txt variant once the generator is migrated
	$(foreach var,$(sdv_binary_pdk_vars), \
		$(call dump-words-to-file,$($(var)),$(sdv_binary_pdk_packages_dir)/$(var).txt) \
		$(call dump-words-to-file,$($(var)),$(sdv_binary_pdk_packages_dir)/$(var)) \
	)

	$(hide) $(sdv_binary_pdk_collector) \
		--target-name $(TARGET_DEVICE) \
		--target-architecture $(sdv_binary_pdk_architecture) \
		$(if $(SDV_BINARY_PDK_OVERRIDE_MODULES_FILE),--target-overrides $(SDV_BINARY_PDK_OVERRIDE_MODULES_FILE),) \
		--src-dir . \
		--out-dir $(OUT_DIR) \
		--binary-dir $(sdv_binary_pdk_archive_dir)

	$(hide) $(SOONG_ZIP) \
		-C $(sdv_binary_pdk_archive_dir) \
		-D $(sdv_binary_pdk_archive_dir) \
		-d \
		-o $(sdv-binary-pdk-zip)

$(call add-clean-step, rm -rf $(sdv_binary_pdk_dir))

$(call dist-for-goals, sdv-binary-pdk, \
	$(sdv-binary-pdk-zip):sdv-binary-pdk/sdv-binary-pdk.zip \
)
$(call dist-for-goals, sdv-binary-pdk, \
	$(sdv_binary_pdk_file_report):sdv-binary-pdk/file_report.txt \
)

$(call declare-1p-container,$(sdv-binary-pdk-zip),)
