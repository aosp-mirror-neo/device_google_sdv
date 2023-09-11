// Copyright 2023 Google LLC

#define LOG_TAG "SdvEmulatedVehicleService"

#include <DefaultVehicleHal.h>
#include <android-base/logging.h>
#include <android/binder_manager.h>
#include <android/binder_process.h>
#include <sdv_emulated_vehicle_hardware.h>

#include <vector>

namespace android::hardware::automotive::vehicle::fake {

using ::aidl::android::hardware::automotive::vehicle::IVehicle;

constexpr char kDefaultConfigDir[] = "/vendor/etc/automotive/vhalconfig/";
constexpr char kOverrideConfigDir[] =
    "/vendor/etc/automotive/vhal_sdv_proxy_config/";
constexpr int kThreadCount = 4;

extern "C" int main() {
  ALOGI("Starting thread pool...");
  if (!ABinderProcess_setThreadPoolMaxThreadCount(kThreadCount)) {
    ALOGE("%s", "failed to set thread pool max thread count");
    return 1;
  }
  ABinderProcess_startThreadPool();

  auto hardware = std::make_unique<SdvEmulatedVehicleHardware>(
      kDefaultConfigDir, kOverrideConfigDir, /*force_override=*/true);
  auto vhal =
      ::ndk::SharedRefBase::make<DefaultVehicleHal>(std::move(hardware));

  ALOGI("Emulator Vehicle Service: Registering as service...");
  std::string service_name = IVehicle::descriptor;
  service_name.append("/default");
  binder_exception_t err =
      AServiceManager_addService(vhal->asBinder().get(), service_name.c_str());
  if (err != EX_NONE) {
    ALOGE(
        "failed to register android.hardware.automotive.vehicle service, "
        "exception: %d",
        err);
    return 1;
  }

  ALOGI("Emulator Vehicle Service Ready");

  ABinderProcess_joinThreadPool();

  ALOGI("Emulator Vehicle Service Exiting");

  return 0;
}

}  // namespace android::hardware::automotive::vehicle::fake
