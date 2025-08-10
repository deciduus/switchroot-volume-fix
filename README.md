# Switchroot Volume Normalization Fix - Magisk Module

## 🎯 **What This Module Does**

Fixes Android 15 volume normalization conflicts with Viper4Android on Switchroot devices by disabling aggressive audio processing that causes:
- Volume bursting/jumping during playbook
- Audio levels changing automatically 
- V4A effects getting overridden
- Inconsistent audio experience across apps

## 📦 **Easy Installation**

### **Method 1: Magisk Manager (Recommended)**
1. Download the latest `SwitchrootVolumeNormalizationFix-v1.0.zip` from the [Releases page](https://github.com/deciduus/switchroot-volume-fix/releases)
2. Open **Magisk Manager**
3. Tap **Modules** → **Install from storage**
4. Select the downloaded ZIP file
5. **Reboot** your device
6. ✅ **Done!** Volume normalization is now disabled

### **Method 2: Recovery Installation**
1. Download the ZIP file
2. Boot into **TWRP** or your custom recovery
3. Select **Install** → choose the ZIP file
4. **Swipe to confirm** installation
5. **Reboot system**

## 🔍 **Verify Installation**

After rebooting, you can verify the fix is working:

1. Open **Termux** (or any terminal app)
2. Run: `su -c "getprop audio.safemedia.bypass"`
3. Should return: `true`

Or check the log file:
```bash
su -c "cat /data/local/tmp/switchroot_volume_fix.log"
```

## ✅ **What You Should Notice**

After installation and reboot:
- **No more volume jumping** during audio playback
- **Viper4Android effects work consistently** 
- **Stable audio levels** across all apps
- **No interference** from Android's volume normalization

## 🛠️ **Troubleshooting**

**Module not appearing in Magisk Manager?**
- Make sure you downloaded the correct ZIP file
- Try rebooting and checking again

**Properties not sticking?**
- Check if the module is enabled in Magisk Manager
- Reboot your device
- Check log: `cat /data/local/tmp/switchroot_volume_fix.log`

**Audio issues after installation?**
- Restart audio services: `su -c "stop audioserver && start audioserver"`
- Or simply reboot your device

**Want to uninstall?**
- Open Magisk Manager → Modules
- Tap the module → Remove
- Reboot

## 📱 **Compatibility**

**✅ Tested Working With:**
- Switchroot Android 15 (V1 Switch)
- Viper4Android FX (all versions)
- ViperFX-RE by WSTxda
- AudioFX, JamesDSP, and other audio processors

**📋 Requirements:**
- Rooted Switchroot Android device
- Magisk v20.4+ installed
- Any Android audio processor (V4A, etc.)

## 🔧 **Technical Details**

This module:
- Sets system properties via `system.prop` (persistent)
- Applies properties immediately via `service.sh` (on boot)
- Disables CTA-2075 loudness standard (Android 15 feature)
- Bypasses safe media volume enforcement
- **Safe & reversible** - uses Magisk's overlay system

**Properties Modified:**
```
audio.safemedia.bypass=true
ro.audio.safe_media_volume.disabled=true
ro.config.safe_media_volume.disabled=true
ro.audio.loudness_control.enabled=false
media.aac.loudness_control=false
ro.audio.cta2075.enabled=false
```

## 🚨 **Important Notes**

- **Safe to use** - doesn't modify system files directly
- **Easily reversible** - uninstall module to revert
- **Boot persistent** - properties survive reboots
- **Update friendly** - won't interfere with Switchroot updates

## 📞 **Support**

Having issues? 
- Check the [Issues page](https://github.com/deciduus/switchroot-volume-fix/issues)
- Join the [Switchroot Discord](https://discord.gg/switchroot)
- Post in the [XDA Switchroot thread](https://forum.xda-developers.com/t/switchroot-android.3971835/)

---

**Made with ❤️ for the Switchroot community by [@deciduus](https://github.com/deciduus)**

*This module uses the same fix from the original Termux solution but packages it as an easy-to-install Magisk module.*
