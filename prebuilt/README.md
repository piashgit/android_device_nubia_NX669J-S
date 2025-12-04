# Prebuilt Kernel and Device Trees

## Kernel
- **Source**: Stock boot.img from NX669J-S
- **Version**: 5.4.242
- **Size**: ~42 MB
- **Format**: RAW Image
- **Architecture**: ARM64

## Device Tree Blobs (DTBs)
Device tree blobs should be placed in the `dtb/` directory.

If DTBs are not available, TWRP will use the DTB embedded in the kernel or boot image.

## Note
For custom kernel builds, replace the `Image` file with your compiled kernel.
