#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from NX669J-EEA device
$(call inherit-product, device/nubia/NX669J-EEA/device.mk)

PRODUCT_DEVICE := NX669J-EEA
PRODUCT_NAME := omni_NX669J-EEA
PRODUCT_BRAND := nubia
PRODUCT_MODEL := NX669J
PRODUCT_MANUFACTURER := nubia

PRODUCT_GMS_CLIENTID_BASE := android-zte

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="NX669J-EEA-user 11 RKQ1.210614.002 nubia.20220321.143005 release-keys"

BUILD_FINGERPRINT := nubia/NX669J-EEA/NX669J-EEA:11/RKQ1.210614.002/nubia.20220321.143005:user/release-keys
