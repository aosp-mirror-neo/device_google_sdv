# Copyright 2024 Google LLC

sdv_binary_pdk_dir := $(PRODUCT_OUT)/sdv-binary-pdk
sdv_binary_pdk_collector := $(HOST_OUT)/bin/binary_pdk_collector
sdv-binary-pdk-zip := $(sdv_binary_pdk_dir)/sdv-binary-pdk.zip
sdv_binary_pdk_packages_dir := $(sdv_binary_pdk_dir)/packages
sdv_binary_pdk_archive_dir := $(sdv_binary_pdk_dir)/archive

sdv_binary_pdk_vars := \
  SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES \
  SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES \
  SDV_AUTOMOTIVE_SERVICES_PACKAGES \
  SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES \
  SDV_BASE_SERVICES_PACKAGES \
  SDV_BASE_SERVICES_SAMPLES_PACKAGES \
  SDV_BASE_SERVICES_HOST_PACKAGES \
  SDV_BASE_SERVICES_HOST_SAMPLES_PACKAGES \
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

sdv-binary-pdk: $(sdv_binary_pdk_collector) $(sdv-all-targets) $(sdv-binary-pdk-zip)
sdv-binary-pdk: $(sdv-binary-pdk-zip)

$(sdv-binary-pdk-zip): $(sdv_binary_pdk_collector) $(sdv-all-targets-files) $(BUILT_SYSTEMIMAGE) $(BUILT_VENDORIMAGE_TARGET) $(BUILT_PRODUCTIMAGE_TARGET) $(BUILT_SYSTEM_EXTIMAGE_TARGET) $(MODULE_INFO_JSON) $(SOONG_ZIP)
	$(hide) rm -rf $(sdv_binary_pdk_packages_dir)
	$(hide) mkdir -p $(sdv_binary_pdk_packages_dir)
	$(foreach var,$(sdv_binary_pdk_vars), \
		$(call dump-words-to-file,$($(var)),$(sdv_binary_pdk_packages_dir)/$(var).txt) \
	)
	$(hide) $(sdv_binary_pdk_collector) \
		--target-name $(TARGET_DEVICE) \
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

$(call declare-1p-container,$(sdv-binary-pdk-zip),)
