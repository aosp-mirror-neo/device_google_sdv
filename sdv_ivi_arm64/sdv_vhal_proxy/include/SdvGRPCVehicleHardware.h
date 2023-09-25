// Copyright 2023 Google LLC

#pragma once

#include <GRPCVehicleHardware.h>
#include <vhal_proxy.h>

#include <memory>
#include <string>
#include <thread>

namespace android::hardware::automotive::vehicle::virtualization {

class SdvGRPCVehicleHardware : public GRPCVehicleHardware {
 public:
  explicit SdvGRPCVehicleHardware(std::string service_addr);
  ~SdvGRPCVehicleHardware();

 private:
  std::unique_ptr<::android::sdv::vhal_proxy::VhalProxy> vhal_proxy;
  std::thread sdv_services_polling_thread;
  void SdvServicesPollingLoop();
};

}  // namespace android::hardware::automotive::vehicle::virtualization
