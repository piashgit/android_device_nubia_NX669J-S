# GitHub Actions Workflows for TWRP Build

## Overview

This device tree includes automated GitHub Actions workflows for building TWRP recovery and validating the device tree configuration.

## Workflows

### 1. TWRP Build Workflow (twrp-build.yml)

**Purpose:** Automatically build TWRP recovery image

**Triggers:**
- Push to `master` or `main` branch
- Pull requests to `master` or `main` branch
- Manual dispatch (with custom options)

**Manual Options:**
- **TWRP Branch:** Choose between `twrp-12.1` or `twrp-11`
- **Build Type:** Choose `eng`, `userdebug`, or `user`

**Features:**
- ✓ Automatic cleanup to free space
- ✓ Swap space setup (12GB)
- ✓ ccache for faster subsequent builds
- ✓ TWRP source sync (~50GB)
- ✓ Device tree integration
- ✓ Parallel build using all CPU cores
- ✓ Artifact upload (recovery.img)
- ✓ Release creation on tags
- ✓ Build summary in Actions tab

**Build Steps:**
1. Checkout repository
2. Cleanup old packages/files
3. Setup swap space (12GB)
4. Install build dependencies
5. Setup ccache
6. Initialize TWRP source
7. Sync TWRP source (~50GB, 2-3 hours)
8. Clone device tree
9. Setup build environment
10. Build recovery image
11. Upload artifacts
12. Create release (if tagged)

**Output:**
- `recovery.img` - TWRP recovery image
- Build logs in Actions tab
- Artifacts downloadable for 90 days

### 2. Device Tree Validation (device-check.yml)

**Purpose:** Validate device tree structure and configuration

**Triggers:**
- Push to `master` or `main` branch
- Pull requests to `master` or `main` branch

**Checks:**
- ✓ Required files exist
  - AndroidProducts.mk
  - BoardConfig.mk
  - device.mk
  - recovery.fstab
  - twrp_NX669J-S.mk
  - vendorsetup.sh
  
- ✓ BoardConfig.mk variables
  - TARGET_BOARD_PLATFORM
  - TARGET_ARCH
  - BOARD_KERNEL_PAGESIZE
  - BOARD_BOOTIMAGE_PARTITION_SIZE
  - AB_OTA_UPDATER
  - TARGET_RECOVERY_FSTAB
  
- ✓ recovery.fstab partitions
  - /boot
  - /data
  - /super
  
- ✓ Prebuilt kernel exists

**Output:**
- Validation summary in Actions tab
- Pass/Fail status for each check

## How to Use

### Automatic Build (on push)

1. Make changes to device tree
2. Commit and push to GitHub
3. GitHub Actions will automatically start building
4. Check progress in "Actions" tab
5. Download recovery.img from "Artifacts" when complete

### Manual Build

1. Go to GitHub repository
2. Click "Actions" tab
3. Select "TWRP Build - NX669J-S" workflow
4. Click "Run workflow" button
5. Choose options:
   - TWRP Branch: `twrp-12.1` (recommended) or `twrp-11`
   - Build Type: `eng` (recommended for testing)
6. Click "Run workflow"
7. Wait for build to complete (~3-4 hours first time, ~1 hour with cache)
8. Download recovery.img from "Artifacts"

### Create Release

1. Create a git tag:
   ```bash
   git tag v1.0
   git push origin v1.0
   ```

2. GitHub Actions will automatically:
   - Build TWRP
   - Create a GitHub Release
   - Upload recovery.img to the release

## Build Time Estimates

| Stage | First Build | Cached Build |
|-------|-------------|--------------|
| Cleanup & Setup | 5 minutes | 5 minutes |
| TWRP Source Sync | 2-3 hours | Skip (cached) |
| Compilation | 45-60 minutes | 30-45 minutes |
| **Total** | **3-4 hours** | **40-50 minutes** |

## Resource Requirements

- **Storage:** ~60GB for TWRP source
- **RAM:** 8GB minimum (12GB swap added)
- **CPU:** More cores = faster build
- **Network:** ~50GB download for source

## Troubleshooting

### Build Failed

1. Check the build logs in Actions tab
2. Common issues:
   - Out of space (cleaned automatically)
   - Missing dependencies (installed automatically)
   - Syntax errors in device tree
   - Missing prebuilt kernel

### Validation Failed

1. Check which files are missing
2. Ensure all required files are present
3. Check BoardConfig.mk for required variables
4. Verify recovery.fstab has critical partitions

### Out of Space

- The workflow automatically cleans up unnecessary packages
- 12GB swap space is added
- If still failing, consider:
  - Using shallow sync (already enabled)
  - Reducing ccache size
  - Manual cleanup before build

## Examples

### Example 1: Test Build

```bash
# Make changes
git add .
git commit -m "Update display configuration"
git push

# GitHub Actions will automatically build
# Check Actions tab for progress
```

### Example 2: Manual Build for Testing

1. Go to Actions > TWRP Build
2. Run workflow
3. Choose: TWRP 12.1, eng build
4. Download and test on device

### Example 3: Release Build

```bash
# Create release
git tag v1.0-beta
git push origin v1.0-beta

# Check Releases page after build completes
```

## Configuration

### Modify Build Settings

Edit `.github/workflows/twrp-build.yml`:

```yaml
env:
  TWRP_BRANCH: 'twrp-12.1'  # Change default branch
  DEVICE: 'NX669J-S'         # Device codename
  BUILD_TYPE: 'eng'          # Default build type
```

### Add More TWRP Branches

Add to workflow inputs:

```yaml
options:
  - twrp-12.1
  - twrp-11
  - twrp-13   # Add new branch
```

## GitHub Actions Limits

- **Free tier:** 2000 minutes/month
- **Pro tier:** 3000 minutes/month
- **Storage:** Artifacts kept for 90 days

**Note:** Each TWRP build uses ~3-4 hours on first run, ~40-50 minutes cached.

## Best Practices

1. **Test locally first** if possible
2. **Use manual dispatch** for testing to save Actions minutes
3. **Create releases** for stable versions only
4. **Monitor Actions usage** in Settings > Billing
5. **Use ccache** (already enabled) for faster builds
6. **Clean up old artifacts** to save storage

## Support

If builds fail:
1. Check Actions logs
2. Verify device tree files
3. Run validation workflow
4. Check TWRP documentation
5. Ask in XDA forums or Telegram groups

## Credits

- **Device Tree:** Piash (piashgit)
- **Workflows:** Automated CI/CD setup
- **Platform:** GitHub Actions
- **TWRP:** TeamWin Recovery Project

## License

Same as device tree - Apache 2.0
