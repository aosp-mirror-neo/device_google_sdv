# According to system/core/libcutils/include/private/android_filesystem_config.
# The range 7500-7999 is reserved for the system_ext partition.

# User for Vehicle and Power mode agent.
[AID_SYSTEM_EXT_SDV_VPM]
value: 7500

# User for Orchestration agent.
[AID_SYSTEM_EXT_SDV_ORCH]
value: 7501

# User for Health management agent.
[AID_SYSTEM_EXT_SDV_HM]
value: 7502

# User for SOME/IP agent.
[AID_SYSTEM_EXT_SDV_SOMEIP]
value: 7503

# User for Telemetry agent.
[AID_SYSTEM_EXT_SDV_TELEMETRY]
value: 7504

# User for Service Bundle registry agent.
[AID_SYSTEM_EXT_SDV_SBR]
value: 7505

# User for Life Cycle Management agent.
[AID_SYSTEM_EXT_SDV_LCM]
value: 7506

# User for RPC agent.
[AID_SYSTEM_EXT_SDV_RPC]
value: 7507

# User for Service Discovery agent.
[AID_SYSTEM_EXT_SDV_SD]
value: 7508

# User for Data tunnel agent.
[AID_SYSTEM_EXT_SDV_DT]
value: 7509

# User for Lifecycle service bundle runner.
[AID_SYSTEM_EXT_SDV_LCM_RUNNER]
value: 7510

# User for init_open_dice.
[AID_SYSTEM_EXT_INIT_OPEN_DICE]
value: 7511

[system_ext/bin/sdv_lifecycle_agent]
mode: 0555
user: AID_SYSTEM_EXT_SDV_LCM
group: AID_SYSTEM
caps: SYS_ADMIN SYS_NICE KILL

[system_ext/bin/lifecycle_service_bundle_runner]
mode: 0555
user: AID_SYSTEM_EXT_SDV_LCM_RUNNER
group: AID_SYSTEM
caps: SYS_NICE
