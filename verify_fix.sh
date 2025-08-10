#!/system/bin/sh

# Switchroot Volume Normalization Fix - Verification Script
# Run this script to check if the fix is working properly

echo "🔍 Switchroot Volume Normalization Fix - Verification"
echo "=================================================="
echo ""

# Check if running as root
if [ "$(id -u)" != "0" ]; then
    echo "❌ This script must be run as root (use 'su' first)"
    exit 1
fi

echo "✅ Running as root - OK"
echo ""

# Check Magisk module status
if [ -d "/data/adb/modules/switchroot_volume_normalization_fix" ]; then
    echo "✅ Magisk module installed - OK"
    
    # Check if module is enabled
    if [ ! -f "/data/adb/modules/switchroot_volume_normalization_fix/disable" ]; then
        echo "✅ Module is enabled - OK"
    else
        echo "⚠️  Module is DISABLED - Enable it in Magisk Manager"
    fi
else
    echo "❌ Magisk module NOT found"
    echo "   Install the module first!"
    exit 1
fi

echo ""
echo "🔧 Checking Audio Properties:"
echo "-----------------------------"

# Check each property
check_prop() {
    local prop="$1"
    local expected="$2"
    local actual="$(getprop "$prop")"
    
    if [ "$actual" = "$expected" ]; then
        echo "✅ $prop = $actual (correct)"
    else
        echo "❌ $prop = $actual (expected: $expected)"
    fi
}

check_prop "audio.safemedia.bypass" "true"
check_prop "ro.audio.safe_media_volume.disabled" "true"
check_prop "ro.audio.loudness_control.enabled" "false"
check_prop "media.aac.loudness_control" "false"
check_prop "ro.audio.cta2075.enabled" "false"

echo ""
echo "📋 Service Log Check:"
echo "--------------------"

if [ -f "/data/local/tmp/switchroot_volume_fix.log" ]; then
    echo "✅ Service log found:"
    tail -5 /data/local/tmp/switchroot_volume_fix.log
else
    echo "⚠️  Service log not found (module may not have run yet)"
    echo "   Try rebooting your device"
fi

echo ""
echo "🎵 Audio Server Status:"
echo "----------------------"

if pgrep audioserver > /dev/null; then
    echo "✅ Audio server is running"
else
    echo "❌ Audio server is not running"
    echo "   Try: stop audioserver && start audioserver"
fi

echo ""
echo "📊 Summary:"
echo "----------"

# Count successful properties
success_count=0
total_props=5

for prop in "audio.safemedia.bypass:true" "ro.audio.safe_media_volume.disabled:true" "ro.audio.loudness_control.enabled:false" "media.aac.loudness_control:false" "ro.audio.cta2075.enabled:false"; do
    prop_name="${prop%:*}"
    expected_val="${prop#*:}"
    actual_val="$(getprop "$prop_name")"
    
    if [ "$actual_val" = "$expected_val" ]; then
        success_count=$((success_count + 1))
    fi
done

if [ $success_count -eq $total_props ]; then
    echo "🎉 ALL CHECKS PASSED! Volume normalization fix is working correctly."
    echo ""
    echo "You should now experience:"
    echo "- No volume jumping during playback"
    echo "- Consistent Viper4Android effects"
    echo "- Stable audio levels across apps"
else
    echo "⚠️  $success_count/$total_props properties are correct"
    echo ""
    echo "🔧 Troubleshooting:"
    echo "- Make sure the module is enabled in Magisk Manager"
    echo "- Try rebooting your device"
    echo "- Check if you have any conflicting audio modules"
    echo "- Restart audio services: stop audioserver && start audioserver"
fi

echo ""
echo "📱 Need help? Check the README.md or visit:"
echo "   https://github.com/deciduus/switchroot-volume-fix"
