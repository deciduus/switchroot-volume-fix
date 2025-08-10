@echo off
REM Build script to create Magisk module ZIP for GitHub releases
REM Run this script to package the module for distribution

set VERSION=v1.0
set MODULE_NAME=SwitchrootVolumeNormalizationFix
set OUTPUT_DIR=release
set ZIP_NAME=%MODULE_NAME%-%VERSION%.zip

echo 🔨 Building Switchroot Volume Normalization Fix %VERSION%
echo ============================================================

REM Create release directory
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Create temporary build directory
set BUILD_DIR=%TEMP%\magisk_build_%RANDOM%
mkdir "%BUILD_DIR%"
echo 📁 Using temporary build directory: %BUILD_DIR%

REM Copy module files to build directory
echo 📋 Copying module files...

xcopy /E /I META-INF "%BUILD_DIR%\META-INF"
copy module.prop "%BUILD_DIR%\"
copy service.sh "%BUILD_DIR%\"
copy system.prop "%BUILD_DIR%\"

REM Documentation files (optional, but helpful)
copy README.md "%BUILD_DIR%\"
copy CHANGELOG.md "%BUILD_DIR%\"
copy install_guide.md "%BUILD_DIR%\"
copy verify_fix.sh "%BUILD_DIR%\"

echo ✅ Files copied successfully

REM Create ZIP archive using PowerShell
echo 📦 Creating ZIP archive...
powershell -Command "Compress-Archive -Path '%BUILD_DIR%\*' -DestinationPath '%~dp0%OUTPUT_DIR%\%ZIP_NAME%' -Force"

REM Cleanup
rmdir /s /q "%BUILD_DIR%"

echo 🎉 Module built successfully!
echo.
echo 📄 Output: %OUTPUT_DIR%\%ZIP_NAME%
for %%A in ("%OUTPUT_DIR%\%ZIP_NAME%") do echo 📊 File size: %%~zA bytes
echo.
echo 🚀 Ready for GitHub release!
echo.
echo 📋 Upload instructions:
echo 1. Go to https://github.com/deciduus/switchroot-volume-fix/releases
echo 2. Click 'Create a new release'
echo 3. Tag: %VERSION%
echo 4. Title: 'Switchroot Volume Normalization Fix %VERSION%'
echo 5. Upload: %OUTPUT_DIR%\%ZIP_NAME%
echo 6. Description: Copy from CHANGELOG.md
echo.
echo 🔍 To test locally:
echo    adb push %OUTPUT_DIR%\%ZIP_NAME% /sdcard/Download/
echo    # Then install via Magisk Manager

pause
