# TWRP Device Tree for Nubia Red Magic 6S Pro (NX669J-S)

## Device Specifications

| Feature                 | Specification                                   |
| :---------------------- | :-----------------------------------------------|
| Chipset                 | Qualcomm SM8350 Snapdragon 888+ 5G (5 nm)      |
| CPU                     | Octa-core (1x3.0 GHz + 3x2.42 GHz + 4x1.80 GHz)|
| GPU                     | Adreno 660                                      |
| Memory                  | 12/16/18 GB RAM                                 |
| Shipped Android Version | Android 11 (Redmagic 4.5)                       |
| Storage                 | 128/256/512 GB (UFS 3.1)                        |
| Battery                 | Li-Po 5050 mAh (Global) / 4500 mAh (China)     |
| Dimensions              | 169.9 x 77.2 x 9.5 mm                           |
| Display                 | 6.8" AMOLED, 1080 x 2400, 165Hz                 |
| Camera                  | 64 MP (main), 8 MP (ultrawide), 2 MP (macro)    |
| Release Date            | September 2021                                  |

## Device Picture

![Nubia Red Magic 6S Pro](https://fdn2.gsmarena.com/vv/bigpic/zte-nubia-red-magic-6s-pro-.jpg)

## Features

- [x] Boot into TWRP
- [x] Display
- [x] Touch
- [x] ADB
- [x] MTP
- [x] USB OTG
- [x] Vibration
- [x] Brightness control
- [x] A/B partition support
- [x] Dynamic partition support
- [x] Super partition support
- [x] Fastbootd
- [x] Flash GSI images
- [x] Backup/Restore
- [ ] Decryption (Work in progress)
- [ ] Format data
- [ ] Additional features coming soon

## Compile

First, clone the TWRP source:

```bash
mkdir ~/twrp
cd ~/twrp
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync -j$(nproc --all)
```

Then, clone this device tree:

```bash
git clone https://github.com/piashgit/android_device_nubia_NX669J-S.git device/nubia/NX669J-S
```

Finally, build TWRP:

```bash
. build/envsetup.sh
lunch twrp_NX669J-S-eng
mka recoveryimage
```

## Installation

Flash the recovery image using fastboot:

```bash
fastboot flash boot twrp.img
fastboot reboot recovery
```

Or if you have a separate recovery partition:

```bash
fastboot flash recovery twrp.img
fastboot reboot recovery
```

## Notes

- This device uses A/B partitioning with dynamic partitions
- Super partition contains: system, system_ext, product, vendor, odm
- Boot image contains both kernel and recovery
- For proper decryption support, vendor blobs may be required

## Device Information Collected

- Display: 1080x2400 @ 480dpi
- Backlight: `/sys/class/backlight/panel0-backlight/brightness`
- Current Active Slot: `_b`
- Platform: `lahaina` (SM8350)
- Android Version: 12
- A/B Device: Yes
- Dynamic Partitions: Yes
- Super Partition: `/dev/block/sda7`

## Credits

- **Maintainer:** Piash ([piashgit](https://github.com/piashgit))
- **Device Tree:** Based on collected device information
- **Kernel:** NetHunter kernel (5.4.242-ModByPiash-nethunter)
- **Thanks to:** TeamWin Recovery Project

## License

```
Copyright (C) 2024 The Android Open Source Project
Copyright (C) 2024 TeamWin Recovery Project

SPDX-License-Identifier: Apache-2.0
```
