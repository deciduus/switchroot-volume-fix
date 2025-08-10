# 📦 Quick Installation Guide

## For Users Who Want the Simplest Solution

### 🚀 **1-Click Install (Recommended)**

1. **Download**: Get `SwitchrootVolumeNormalizationFix-v1.0.zip` from the [Releases page](https://github.com/deciduus/switchroot-volume-fix/releases)

2. **Install**: 
   - Open **Magisk Manager** 
   - Tap **Modules** → **Install from storage**
   - Select the downloaded ZIP
   - Tap **Install**

3. **Reboot**: Restart your Switch

4. **Verify**: Open any audio app - volume should now be stable! 🎵

---

### 🔍 **Did It Work?**

**✅ Signs the fix is working:**
- No more sudden volume jumps during playback
- Viper4Android effects stay consistent  
- Audio levels remain stable across apps
- No random volume changes

**❓ Want to double-check?**
Run the verification script:
```bash
# Download and run the verification script
su -c "sh /sdcard/Download/verify_fix.sh"
```

---

### 🛠️ **Troubleshooting**

**Module not showing in Magisk?**
- Make sure you downloaded the correct ZIP file
- Check that Magisk is v20.4 or newer
- Try rebooting and checking again

**Still having volume issues?**
- Ensure the module is **enabled** in Magisk Manager
- Reboot your device completely
- Check if you have other audio modules that might conflict

**Want to uninstall?**
- Magisk Manager → Modules → Tap the module → Remove → Reboot

---

### 🎯 **What This Replaces**

This Magisk module replaces the need for:
- ❌ Manual Termux commands
- ❌ Creating files by hand  
- ❌ Remembering complex property names
- ❌ Re-applying fixes after updates

**Just install once and forget about it!** 

---

### 📞 **Need Help?**

- 📖 Full documentation: `README.md`
- 🐛 Report issues: [GitHub Issues](https://github.com/deciduus/switchroot-volume-fix/issues)  
- 💬 Community support: [Switchroot Discord](https://discord.gg/switchroot)

**Happy gaming with perfect audio! 🎮🔊**
