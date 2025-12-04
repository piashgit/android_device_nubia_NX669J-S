# TWRP Build Instructions for NX669J-S

## Automatic Build Configuration

This repository is configured for **automatic TWRP builds** via GitHub Actions.

### Build Configuration

| Setting | Value |
|---------|-------|
| **TWRP Branch** | twrp-12.1 (Android 12) |
| **Device Branch** | master |
| **Build Type** | eng (engineering build) |
| **Platform** | SM8350 (Lahaina) |
| **Android Version** | 12 |

## Build Triggers

The TWRP build workflow automatically runs when:
- ✅ Push to `master` branch
- ✅ Push to `main` branch
- ✅ Pull requests to master/main
- ✅ Manual trigger from Actions tab

## Build Steps

### Automatic Build (Recommended)

Any push to this repository will automatically trigger the build:

```bash
# Make any change
echo "# Build trigger" >> README.md
git add README.md
git commit -m "Trigger TWRP build"
git push origin master
```

### Manual Build via GitHub Actions

1. Go to: https://github.com/piashgit/android_device_nubia_NX669J-S/actions
2. Click "TWRP Build - NX669J-S"
3. Click "Run workflow"
4. Select:
   - Branch: `master`
   - TWRP Branch: `twrp-12.1`
   - Build Type: `eng`
5. Click "Run workflow"

## Build Time

- **First Build:** 3-4 hours
  - TWRP source download: 2-3 hours
  - Compilation: 45-60 minutes
  - Setup/Upload: 15 minutes

- **Subsequent Builds:** 40-50 minutes
  - Source cached
  - Only device tree changes compiled

## Download Recovery

After build completes:

1. Go to workflow run page
2. Scroll to "Artifacts" section
3. Download `TWRP-NX669J-S-twrp-12.1-{run-number}.zip`
4. Extract to get `recovery.img`

## Flash Instructions

### Prerequisites
- Unlocked bootloader
- USB debugging enabled
- ADB and fastboot installed

### Flash Commands

```bash
# Boot into fastboot
adb reboot bootloader

# Flash recovery to boot partition (A/B device)
fastboot flash boot recovery.img

# Reboot to recovery
fastboot reboot recovery
```

## Device Specifications

| Component | Details |
|-----------|---------|
| Device | NX669J-S (Red Magic 6S Pro) |
| SoC | Qualcomm SM8350 Snapdragon 888+ |
| Display | 1080x2400, 480dpi, AMOLED, 165Hz |
| RAM | 16 GB |
| Android | 12 |
| Partitions | A/B with dynamic partitions |

## TWRP Features

- ✅ Touch input
- ✅ Display brightness control
- ✅ A/B partition support
- ✅ Dynamic partition support
- ✅ Fastbootd for GSI flashing
- ✅ MTP (file transfer)
- ✅ ADB in recovery
- ✅ Backup/Restore
- ✅ USB OTG
- ⏳ Decryption (work in progress)

## Build Logs

Check build logs at:
https://github.com/piashgit/android_device_nubia_NX669J-S/actions

## Troubleshooting

### Build Failed
- Check Actions logs for errors
- Common issues:
  - Syntax error in device tree
  - Missing dependencies (auto-installed)
  - Out of space (auto-cleaned)

### Flash Failed
- Verify bootloader unlocked
- Try: `fastboot oem device-info`
- Flash to correct partition (boot, not recovery)

### TWRP Not Booting
- Check if correct slot is active
- Try: `fastboot --set-active=a` or `fastboot --set-active=b`
- Re-flash stock boot if needed

## Support

- Repository: https://github.com/piashgit/android_device_nubia_NX669J-S
- Issues: https://github.com/piashgit/android_device_nubia_NX669J-S/issues
- Maintainer: Piash (@piashgit)

## Credits

- TeamWin Recovery Project (TWRP)
- Android Open Source Project
- Device tree: Piash
- Hardware info collection: Automated via ADB

---

**Last Updated:** 2025-12-04
**TWRP Version:** 12.1
**Device Tree Version:** 1.0
