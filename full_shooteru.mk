#
# Copyright 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, device/htc/shooteru/device.mk)

ifneq ($(TARGET_BUILD_VARIANT),codefirex)
# Get the long list of APNs
PRODUCT_COPY_FILES := device/sample/etc/apns-full-conf.xml:system/etc/apns-conf.xml

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)
else

## Specify phone tech before including full_phone
$(call inherit-product, vendor/cfx/config/gsm.mk)

# Boot animation
PRODUCT_COPY_FILES += \
    vendor/cfx/prebuilt/common/bootanimation/480.zip:system/media/bootanimation.zip

# Inherit some common CFX stuff.
$(call inherit-product, vendor/cfx/config/common_full_phone.mk)
endif

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := shooteru
PRODUCT_NAME := full_shooteru
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP on shooteru
PRODUCT_MANUFACTURER := HTC

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=occam BUILD_FINGERPRINT=google/occam/shooteru:4.3/JB_MR2/573038:user/release-keys
PRIVATE_BUILD_DESC="occam-user 4.3 JB_MR2 573038 release-keys"

# Include shooteru's BoardConfig.mk
include device/htc/shooteru/BoardConfig.mk
$(call inherit-product-if-exists, vendor/htc/shooteru/device-vendor.mk)
