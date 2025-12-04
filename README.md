# TWRP Device Tree for Nubia Red Magic 6S Pro (NX669S)

## Device Specifications

| Feature | Specification |
|---------|---------------|
| Device | Nubia Red Magic 6S Pro |
| Codename | NX669S / NX669J |
| SoC | Qualcomm SM8350 Snapdragon 888+ (5nm) |
| CPU | 1x3.0GHz Cortex-X1 + 3x2.42GHz Cortex-A78 + 4x1.8GHz Cortex-A55 |
| GPU | Adreno 660 |
| RAM | 12GB / 16GB / 18GB |
| Storage | 128GB / 256GB / 512GB UFS 3.1 |
| Display | 6.8" AMOLED, 1080x2400, 165Hz, 480dpi |
| Battery | 5050mAh Li-Po |
| Android | 12 (Stock) |
| Kernel | 5.4.86-qgki |

## Device Picture

![Red Magic 6S Pro](https://fdn2.gsmarena.com/vv/pics/zte/zte-nubia-red-magic-6s-pro-1.jpg)

---

## TWRP Features

### Working
- [x] Internal Storage
- [x] External SD Card
- [x] USB OTG
- [x] ADB & Terminal
- [x] Flashing ZIP files
- [x] Flashing IMG files
- [x] ADB Sideload
- [x] MTP (Media Transfer)
- [x] FastbootD
- [x] Vibration/Haptics
- [x] Brightness Control
- [x] A/B Slot Switching
- [x] Backup & Restore

### Partially Working
- [ ] Decryption (FBE) - Vendor blobs included, testing needed

### Not Tested
- [ ] OTA Firmware Flashing

---

## Partition Layout

Collected from device `/proc/partitions`:

| Partition | Block Device | Size | Type |
|-----------|--------------|------|------|
| boot_a | sde11 | 96MB | A/B |
| boot_b | sde36 | 96MB | A/B |
| vendor_boot_a | sde23 | 96MB | A/B |
| vendor_boot_b | sde48 | 96MB | A/B |
| dtbo_a | sde15 | 24MB | A/B |
| dtbo_b | sde40 | 24MB | A/B |
| super | sda7 | 7.5GB | Dynamic |
| userdata | sda12 | 217GB | F2FS |
| metadata | sda10 | 16MB | ext4 |
| persist | sda2 | 32MB | ext4 |
| modem_a/b | sde4/sde29 | 220MB | A/B |
| bluetooth_a/b | sde5/sde30 | 2MB | A/B |
| dsp_a/b | sde9/sde34 | 64MB | A/B |

### Dynamic Partitions (Super)
- system
- system_ext
- product
- vendor
- odm

---

## Vendor Blobs (for Decryption)

Extracted from device and included in `recovery/root/vendor/`:

```
vendor/
├── bin/
│   ├── qseecomd
│   └── hw/
│       ├── android.hardware.keymaster@4.0-service-qti
│       ├── android.hardware.keymaster@4.1-service-qti
│       └── android.hardware.gatekeeper@1.0-service-qti
├── etc/
│   └── fstab.default
└── lib64/
    ├── libQSEEComAPI.so
    ├── libkeymasterdeviceutils.so
    ├── libkeymasterprovision.so
    ├── libkeymasterutils.so
    ├── liboemcrypto.so
    ├── libqsap_sdk.so
    ├── libqtikeymaster4.so
    └── hw/
        ├── android.hardware.boot@1.0-impl-1.1-qti.so
        └── android.hardware.gatekeeper@1.0-impl-qti.so
```

---

## Build Instructions

### Prerequisites
- Ubuntu 20.04/22.04
- 100GB+ free disk space
- 16GB+ RAM recommended

### Build Steps

```bash
# 1. Initialize TWRP source
mkdir twrp && cd twrp
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync -c --no-clone-bundle --no-tags -j$(nproc)

# 2. Clone device tree
git clone https://github.com/piashgit/android_device_nubia_NX669J-S.git device/nubia/NX669S

# 3. Build
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch twrp_NX669S-eng
mka bootimage -j$(nproc)
```

### Output
- `out/target/product/NX669S/boot.img` - TWRP boot image

---

## Flash Instructions

### Temporary Boot (Test)
```bash
fastboot boot boot.img
```

### Permanent Install
```bash
# Boot to TWRP first, then flash from Advanced
fastboot boot boot.img
# In TWRP: Advanced -> Flash Current TWRP
```

### Important Notes
- This is an **A/B device** with **Virtual A/B**
- No dedicated recovery partition
- TWRP is embedded in boot.img
- Always keep stock boot backup!

---

## Device Information Sources

All device-specific information collected via ADB:

| File | Content |
|------|---------|
| `/proc/partitions` | Block device layout |
| `/dev/block/by-name/` | Partition mappings |
| `getprop` | Device properties |
| `/sys/class/backlight/` | Display brightness |
| `/proc/cpuinfo` | CPU information |
| `/proc/meminfo` | Memory information |

---

## Supported Device Variants

```makefile
TARGET_OTA_ASSERT_DEVICE := NX669J,NX669J-UN,NX669J-EEA,NX669S,NX669S-UN,NX669S-EEA
```

- NX669J - Red Magic 6 Pro (Global)
- NX669J-UN - Red Magic 6 Pro (US)
- NX669J-EEA - Red Magic 6 Pro (Europe)
- NX669S - Red Magic 6S Pro (Global)
- NX669S-UN - Red Magic 6S Pro (US)
- NX669S-EEA - Red Magic 6S Pro (Europe)

---

## Credits

- **Device Tree Author**: [Piash](https://github.com/piashgit)
- **Original TWRP Tree Reference**: [KissPisti87](https://github.com/KissPisti87/TWRP_NX669J_12.1)
- **TWRP**: [TeamWin Recovery Project](https://twrp.me)
- **Device Info Collection**: Automated via ADB

---

## Changelog

### v1.0 (2024-12-05)
- Initial release
- Complete partition mapping from device
- Vendor blobs for decryption
- A/B and Virtual A/B support
- FastbootD support
- Stock fstab included

---

## License

```
Copyright (C) 2024 The Android Open Source Project
Copyright (C) 2024 TeamWin Recovery Project

SPDX-License-Identifier: Apache-2.0
```

---

## Links

- **Device Tree**: https://github.com/piashgit/android_device_nubia_NX669J-S
- **TWRP Official**: https://twrp.me
- **XDA Thread**: (Coming Soon)
