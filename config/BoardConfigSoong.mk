# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

# PA Variables

SOONG_CONFIG_NAMESPACES += aospaVarsPlugin

SOONG_CONFIG_aospaVarsPlugin :=

define addVar
  SOONG_CONFIG_aospaVarsPlugin += $(1)
  SOONG_CONFIG_aospaVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += aospaGlobalVars
SOONG_CONFIG_aospaGlobalVars += \
    board_fingerprint_vendor \
    no_mask_layer \
    target_init_vendor_lib \
    target_ld_shim_libs \
    target_process_sdk_version_override \
    target_surfaceflinger_fod_lib

SOONG_CONFIG_NAMESPACES += aospaQcomVars
SOONG_CONFIG_aospaQcomVars += \
    should_wait_for_qsee \
    supports_hw_fde \
    supports_hw_fde_perf 

ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_aospaQcomVars += \
    qcom_soong_namespace
endif

# Set default values
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_SURFACEFLINGER_FOD_LIB ?= surfaceflinger_fod_lib

# Soong value variables
SOONG_CONFIG_aospaGlobalVars_board_fingerprint_vendor := $(BOARD_FINGERPRINT_VENDOR)
SOONG_CONFIG_aospaGlobalVars_no_mask_layer := $(TARGET_DISPLAY_HAS_NO_MASK_LAYER)
SOONG_CONFIG_aospaGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_aospaGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_aospaGlobalVars_target_process_sdk_version_override := $(TARGET_PROCESS_SDK_VERSION_OVERRIDE)
SOONG_CONFIG_aospaGlobalVars_target_surfaceflinger_fod_lib := $(TARGET_SURFACEFLINGER_FOD_LIB)
SOONG_CONFIG_aospaQcomVars_should_wait_for_qsee := $(TARGET_KEYMASTER_WAIT_FOR_QSEE)
SOONG_CONFIG_aospaQcomVars_supports_hw_fde := $(TARGET_HW_DISK_ENCRYPTION)
SOONG_CONFIG_aospaQcomVars_supports_hw_fde_perf := $(TARGET_HW_DISK_ENCRYPTION_PERF)

ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_aospaQcomVars_qcom_soong_namespace := $(QCOM_SOONG_NAMESPACE)
endif

# Qualcomm variables
SOONG_CONFIG_NAMESPACES += aosp_vs_qva
SOONG_CONFIG_aosp_vs_qva += aosp_or_qva
SOONG_CONFIG_aosp_vs_qva_aosp_or_qva := qva
