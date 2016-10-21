# Copyright (C) 2014 The Android Open Source Project
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

# inherit from common
$(call inherit-product, device/sony/common/cm-common.mk)

# Platform
BOARD_VENDOR_PLATFORM := shinano
TARGET_BOOTLOADER_BOARD_NAME := MSM8974

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml

# ANT+ Permissions
PRODUCT_COPY_FILES += \
    external/ant-wireless/antradio-library/com.dsi.ant.antradio_library.xml:system/etc/permissions/com.dsi.ant.antradio_library.xml

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "vfs-prerelease"

# ANT+ Packages
PRODUCT_PACKAGES += \
    AntHalService \
    com.dsi.ant.antradio_library \
    libantradio

# NFC
BOARD_NFC_CHIPSET := pn547
BOARD_NFC_DEVICE := /dev/pn54x

# NFC Packages
PRODUCT_PACKAGES += \
    nfc_nci.pn54x.default

# NFC props (less logs)
PRODUCT_PROPERTY_OVERRIDES += \
    nfc.app_log_level=1

# Off mode charger
PRODUCT_PACKAGES += \
    charger_res_images

# Audio offload
PRODUCT_PROPERTY_OVERRIDES += \
    audio.offload.buffer.size.kb=32 \
    audio.offload.gapless.enabled=false \
    audio.offload.multiple.enabled=false \
    audio.offload.pcm.enable=enable \
    av.offload.enable=enable \
    av.streaming.offload.enable=enable

# Voice Call
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qc.sdk.audio.fluencetype=none \
    persist.audio.dualmic.config=endfire \

# aDSP
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qualcomm.sensors.qmd=false \
    debug.qualcomm.sns.hal=w \
    ro.qc.sdk.sensors.gestures=false \
    ro.qc.sensors.max_accel_rate=false \
    ro.qc.sensors.max_gyro_rate=false \
    ro.qc.sensors.max_mag_rate=false \
    ro.qc.sensors.smgr_mag_cal_en=true \
    ro.qualcomm.sensors.pedometer=false \
    ro.qualcomm.sensors.pam=false \
    ro.qualcomm.sensors.scrn_ortn=false \
    ro.qualcomm.sensors.smd=sony \
    ro.qc.sensors.step_detector=true \
    ro.qc.sensors.step_counter=true \
    ro.qualcomm.sensors.georv=true \
    ro.qc.sensors.max_geomag_rotvec=50

# HDMI
PRODUCT_PROPERTY_OVERRIDES += \
    persist.demo.hdmirotationlock=false

# Touchscreen
PRODUCT_PROPERTY_OVERRIDES += \
    ro.input.noresample=1

# HWUI memory limits
$(call inherit-product, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)
