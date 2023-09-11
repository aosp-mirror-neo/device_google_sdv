// Copyright 2023 Google LLC

#pragma once

#include <EmulatedVehicleHardware.h>
#include <vhal_proxy.h>

#include <memory>
#include <string>
#include <thread>

namespace android::hardware::automotive::vehicle::fake {

class SdvEmulatedVehicleHardware : public EmulatedVehicleHardware {
 public:
  SdvEmulatedVehicleHardware();
  SdvEmulatedVehicleHardware(std::string_view default_config_dir,
                             std::string_view override_config_dir,
                             bool force_override);
  ~SdvEmulatedVehicleHardware();

 private:
  std::unique_ptr<::android::sdv::vhal_proxy::VhalProxy> vhal_proxy;
  std::thread sdv_services_polling_thread;
  void Init();
  void SdvServicesPollingLoop();
};

}  // namespace android::hardware::automotive::vehicle::fake
