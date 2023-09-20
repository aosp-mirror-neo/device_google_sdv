// Copyright 2023 Google LLC

#include "SdvGRPCVehicleHardware.h"

namespace android::hardware::automotive::vehicle::virtualization {

using ::android::sdv::vhal_proxy::VhalProxy;

// The directory that contains the HAL proxy configuration file.
constexpr char kDefaultConfigDir[] =
    "/vendor/etc/automotive/vhal_sdv_proxy_config/";

SdvGRPCVehicleHardware::SdvGRPCVehicleHardware(std::string service_addr)
    : GRPCVehicleHardware(service_addr),
      vhal_proxy(std::make_unique<VhalProxy>(
          std::vector<std::string>{kDefaultConfigDir})),
      sdv_services_polling_thread([this] { SdvServicesPollingLoop(); }) {}

SdvGRPCVehicleHardware::~SdvGRPCVehicleHardware() {
  sdv_services_polling_thread.join();
}

void SdvGRPCVehicleHardware::SdvServicesPollingLoop() {
  // Event Loop
  while (true) {
    const auto events = vhal_proxy->ReadMessages();
    if (!events.empty()) {
      std::shared_lock lck(mCallbackMutex);
      if (mOnPropChange) {
        (*mOnPropChange)(events);
      }
    }
  }
}

}  // namespace android::hardware::automotive::vehicle::virtualization
