@echo off
echo 🚀 Setting up GitHub repository for Switchroot Volume Normalization Fix
echo ================================================================

echo.
echo 📋 Make sure you've created the repository on GitHub first:
echo    https://github.com/new
echo    Repository name: switchroot-volume-fix
echo    Description: A fix for the Android 15 aggressive volume normalization affecting Switchroot + Viper4Android
echo    Public repository (unchecked initialize with README)
echo.
pause

echo 🔧 Initializing Git repository...
git init

echo 📁 Adding all files...
git add .

echo 📝 Creating initial commit...
git commit -m "Initial release: Switchroot Volume Normalization Fix v1.0

- Complete Magisk module for Android 15 volume normalization fix
- Fixes volume bursting/jumping with Viper4Android on Switchroot
- Easy installation via Magisk Manager (no Termux required)
- Includes verification script and comprehensive documentation
- Disables aggressive audio processing and CTA-2075 loudness standard"

echo 🌐 Adding GitHub remote...
git branch -M main
git remote add origin https://github.com/deciduus/switchroot-volume-fix.git

echo 📤 Pushing to GitHub...
git push -u origin main

echo.
echo 🎉 Repository setup complete!
echo.
echo 📋 Next steps:
echo 1. Go to https://github.com/deciduus/switchroot-volume-fix
echo 2. Check that all files uploaded correctly
echo 3. Create a release by running: build_release.bat
echo 4. Upload the generated ZIP to GitHub Releases
echo.
echo 🔍 Your repository will be live at:
echo    https://github.com/deciduus/switchroot-volume-fix

pause
