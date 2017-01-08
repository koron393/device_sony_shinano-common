# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Common path
COMMON_PATH := device/sony/common

# Platform path
PLATFORM_COMMON_PATH := device/sony/shinano-common

# Time Zone data for Recovery
PRODUCT_COPY_FILES += \
    bionic/libc/zoneinfo/tzdata:recovery/root/system/usr/share/zoneinfo/tzdata

# TWRP UI
BOARD_HAS_NO_SELECT_BUTTON := true
TW_NO_SCREEN_BLANK := true
TW_MAX_BRIGHTNESS := 255
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
RECOVERY_GRAPHICS_USE_LINELENGTH := true
#TW_USE_TOYBOX := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TWHAVE_SELINUX := true

# TWRP Storage
RECOVERY_SDCARD_ON_DATA := true
TW_INCLUDE_FUSE_EXFAT := true
TW_FLASH_FROM_STORAGE := true
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TARGET_NO_SEPARATE_RECOVERY := true

# TWRP Crypto
TW_INCLUDE_CRYPTO := true
TW_CRYPTO_FS_TYPE := "ext4"
TW_CRYPTO_MNT_POINT := "/data"
TW_CRYPTO_REAL_BLKDEV := "/dev/block/bootdevice/by-name/userdata"
TW_CRYPTO_FS_OPTIONS := "nosuid,nodev,barrier=1,noauto_da_alloc,discard"
TW_CRYPTO_FS_FLAGS := "0x00000406"
TW_CRYPTO_KEY_LOC := "footer"

# Recovery
#TARGET_RECOVERY_FSTAB := $(PLATFORM_COMMON_PATH)/multirom/twrp.fstab
TARGET_RECOVERY_PIXEL_FORMAT := "RGBA_8888"

#MultiROM config. MultiROM also uses parts of TWRP config
TARGET_RECOVERY_IS_MULTIROM := true
MR_INPUT_TYPE := type_b
MR_INIT_DEVICES := $(PLATFORM_COMMON_PATH)/multirom/mr_init_devices.c
MR_BINARY_SELECTOR := $(PLATFORM_COMMON_PATH)/multirom/mr_binary_selector.c
MR_DEVICE_HOOKS := $(PLATFORM_COMMON_PATH)/multirom/mr_hooks.c
MR_DEVICE_HOOKS_VER := 3
MR_USE_QCOM_OVERLAY := true
MR_QCOM_OVERLAY_HEADER := $(PLATFORM_COMMON_PATH)/multirom/mr_qcom_overlay.h
MR_QCOM_OVERLAY_CUSTOM_PIXEL_FORMAT := MDP_RGBX_8888
MR_KEXEC_DTB := true
MR_NO_KEXEC := enabled
MR_FSTAB := $(PLATFORM_COMMON_PATH)/multirom/twrp.fstab
MR_USE_MROM_FSTAB := true
MR_PIXEL_FORMAT := "RGBX_8888"

# Ensure gzip compression for recovery
BOARD_NEEDS_LZMA_MINIGZIP := false

# Brithtness
TW_MAX_BRIGHTNESS := 255

# Use busybox
TW_USE_TOOLBOX := false

# Extra languages
TW_EXTRA_LANGUAGES := true

# For KEXEC
#MR_KEXEC_MEM_MIN := 0x3e7e0000
MR_KEXEC_MEM_MIN := 0x0ff00000

# Versioning
BOARD_MKBOOTIMG_ARGS += --board mrom$(MR_REC_VERSION)
MR_REC_VERSION := $(shell date -u +%Y%m%d)-01
#MR_DEVICE_SPECIFIC_VERSION := c
