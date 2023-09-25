// Copyright 2023 Google LLC

#define LOG_TAG "SdvEmulatedVehicleHardware"

#include "sdv_emulated_vehicle_hardware.h"

#include <VehicleHalTypes.h>
#include <android-base/logging.h>

#include <memory>

namespace android::hardware::automotive::vehicle::fake {

using ::android::sdv::vhal_proxy::VhalProxy;

SdvEmulatedVehicleHardware::SdvEmulatedVehicleHardware() { Init(); }

SdvEmulatedVehicleHardware::SdvEmulatedVehicleHardware(
    std::string_view default_config_dir, std::string_view override_config_dir,
    bool force_override)
    : EmulatedVehicleHardware(default_config_dir, override_config_dir,
                              force_override) {
  Init();
}

SdvEmulatedVehicleHardware::~SdvEmulatedVehicleHardware() {
  sdv_services_polling_thread.join();
}

void SdvEmulatedVehicleHardware::Init() {
  vhal_proxy = UseOverrideConfigDir()
                   ? std::make_unique<VhalProxy>(std::vector<std::string>{
                         mDefaultConfigDir, mOverrideConfigDir})
                   : std::make_unique<VhalProxy>(
                         std::vector<std::string>{mDefaultConfigDir}),
  sdv_services_polling_thread =
      std::thread([this] { SdvServicesPollingLoop(); });
}

void SdvEmulatedVehicleHardware::SdvServicesPollingLoop() {
  // Event Loop
  while (true) {
    const auto events = vhal_proxy->ReadMessages();
    for (const auto& event : events) {
      auto result = setValue(event);
      if (!result.ok()) {
        ALOGE("Failed to set value, error: %s", getErrorMsg(result).c_str());
      }
    }
  }
}

}  // namespace android::hardware::automotive::vehicle::fake
