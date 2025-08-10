#!/bin/bash

# Build script to create Magisk module ZIP for GitHub releases
# Run this script to package the module for distribution

VERSION="v1.0"
MODULE_NAME="SwitchrootVolumeNormalizationFix"
OUTPUT_DIR="release"
ZIP_NAME="${MODULE_NAME}-${VERSION}.zip"

echo "🔨 Building Switchroot Volume Normalization Fix v${VERSION}"
echo "============================================================"

# Create release directory
mkdir -p "$OUTPUT_DIR"

# Create temporary build directory
BUILD_DIR="$(mktemp -d)"
echo "📁 Using temporary build directory: $BUILD_DIR"

# Copy module files to build directory
echo "📋 Copying module files..."

# Essential Magisk module files
cp -r META-INF "$BUILD_DIR/"
cp module.prop "$BUILD_DIR/"
cp service.sh "$BUILD_DIR/"
cp system.prop "$BUILD_DIR/"

# Make scripts executable
chmod 755 "$BUILD_DIR/META-INF/com/google/android/update-binary"
chmod 755 "$BUILD_DIR/service.sh"

# Documentation files (optional, but helpful)
cp README.md "$BUILD_DIR/"
cp CHANGELOG.md "$BUILD_DIR/"
cp install_guide.md "$BUILD_DIR/"
cp verify_fix.sh "$BUILD_DIR/"
chmod 755 "$BUILD_DIR/verify_fix.sh"

echo "✅ Files copied successfully"

# Create ZIP archive
echo "📦 Creating ZIP archive..."
cd "$BUILD_DIR"
zip -r "../${OUTPUT_DIR}/${ZIP_NAME}" . -x "*.DS_Store" "*.git*"
cd - > /dev/null

# Cleanup
rm -rf "$BUILD_DIR"

echo "🎉 Module built successfully!"
echo ""
echo "📄 Output: ${OUTPUT_DIR}/${ZIP_NAME}"
echo "📊 File size: $(du -h "${OUTPUT_DIR}/${ZIP_NAME}" | cut -f1)"
echo ""
echo "🚀 Ready for GitHub release!"
echo ""
echo "📋 Upload instructions:"
echo "1. Go to https://github.com/deciduus/switchroot-volume-fix/releases"  
echo "2. Click 'Create a new release'"
echo "3. Tag: ${VERSION}"
echo "4. Title: 'Switchroot Volume Normalization Fix ${VERSION}'"
echo "5. Upload: ${OUTPUT_DIR}/${ZIP_NAME}"
echo "6. Description: Copy from CHANGELOG.md"
echo ""
echo "🔍 To test locally:"
echo "   adb push ${OUTPUT_DIR}/${ZIP_NAME} /sdcard/Download/"
echo "   # Then install via Magisk Manager"
