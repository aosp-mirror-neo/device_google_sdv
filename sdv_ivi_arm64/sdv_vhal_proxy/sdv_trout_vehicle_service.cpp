// Copyright 2023 Google LLC

#include <DefaultVehicleHal.h>
#include <SdvGRPCVehicleHardware.h>
#include <android-base/logging.h>
#include <android/binder_manager.h>
#include <android/binder_process.h>
#include <cutils/properties.h>
#include <linux/vm_sockets.h>
#include <sys/socket.h>
#include <vsockinfo.h>

#include <chrono>
#include <memory>
#include <utility>

namespace android::hardware::automotive::vehicle::virtualization {

using ::aidl::android::hardware::automotive::vehicle::IVehicle;

constexpr int kThreadCount = 4;

extern "C" int main() {
  LOG(INFO) << "Starting thread pool...";
  if (!ABinderProcess_setThreadPoolMaxThreadCount(kThreadCount)) {
    LOG(ERROR) << "Failed to set thread pool max thread count.";
    return 1;
  }
  ABinderProcess_startThreadPool();

  auto vsock = utils::VsockConnectionInfo::fromRoPropertyStore(
      {
          "ro.boot.vendor.vehiclehal.server.cid",
          "ro.vendor.vehiclehal.server.cid",
      },
      {
          "ro.boot.vendor.vehiclehal.server.port",
          "ro.vendor.vehiclehal.server.port",
      });
  CHECK(vsock.has_value()) << "Cannot read VHAL server address.";

  if (property_get_bool("ro.vendor.vehiclehal.server.use_local_fake_server",
                        /* default_value = */ false)) {
    // When using the local fake server in the same VM, the CID read from the
    // system properties will be ignored. We use the loopback CID instead.
    LOG(INFO) << "Using the local GRPC vehicle server that running on the same "
                 "VM as the client.";
    vsock->cid = VMADDR_CID_LOCAL;
  }

  LOG(INFO) << "Connecting to vsock server at " << vsock->str();

  constexpr auto maxConnectWaitTime = std::chrono::seconds(5);
  auto hardware = std::make_unique<SdvGRPCVehicleHardware>(vsock->str());
  if (const auto connected = hardware->waitForConnected(maxConnectWaitTime)) {
    LOG(INFO) << "Connected to vsock server at " << vsock->str();
  } else {
    LOG(INFO)
        << "Failed to connect to vsock server at " << vsock->str()
        << ", check if it is working, or maybe the server is coming up late.";
    return 1;
  }

  auto vhal =
      ::ndk::SharedRefBase::make<DefaultVehicleHal>(std::move(hardware));
  LOG(INFO) << "Registering as service...";
  std::string service_name = IVehicle::descriptor;
  service_name.append("/default");
  binder_exception_t err =
      AServiceManager_addService(vhal->asBinder().get(), service_name.c_str());
  if (err != EX_NONE) {
    LOG(ERROR) << "Failed to register android.hardware.automotive.vehicle "
                  "service, exception: "
               << err << ".";
    return 1;
  }

  LOG(INFO) << "Vehicle Service Ready.";

  ABinderProcess_joinThreadPool();

  LOG(INFO) << "Vehicle Service Exiting.";

  return 0;
}

}  // namespace android::hardware::automotive::vehicle::virtualization
