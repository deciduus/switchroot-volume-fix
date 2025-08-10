# Changelog

## v1.0 (2024-12-19)

### 🎉 Initial Release

**Features:**
- ✅ Complete Magisk module for fixing Android 15 volume normalization conflicts
- ✅ Automatic property setting via `system.prop` (persistent across reboots)
- ✅ Runtime property application via `service.sh` (immediate effect on boot)
- ✅ Comprehensive verification script (`verify_fix.sh`)
- ✅ Detailed installation and troubleshooting guide

**What's Fixed:**
- 🔧 Volume bursting/jumping during audio playback
- 🔧 Automatic audio level changes overriding user settings
- 🔧 Viper4Android effects being overridden by system normalization
- 🔧 Inconsistent audio experience across different apps
- 🔧 Android 15 CTA-2075 loudness standard interference

**Properties Disabled:**
- `audio.safemedia.bypass=true`
- `ro.audio.safe_media_volume.disabled=true`
- `ro.config.safe_media_volume.disabled=true`
- `ro.audio.loudness_control.enabled=false`
- `media.aac.loudness_control=false`
- `ro.audio.cta2075.enabled=false`

**Compatibility:**
- ✅ Switchroot Android 15 (V1 Switch tested)
- ✅ All Viper4Android variants (V4A FX, ViperFX-RE, etc.)
- ✅ Other audio processors (AudioFX, JamesDSP)
- ✅ Magisk v20.4+

**Safety:**
- 🛡️ Non-destructive (uses Magisk overlay system)
- 🛡️ Easily reversible (uninstall module to revert)
- 🛡️ No system file modifications
- 🛡️ Update-friendly (won't interfere with ROM updates)
