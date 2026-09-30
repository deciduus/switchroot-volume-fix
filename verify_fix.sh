#!/system/bin/sh
# Read-only property/status verification; this cannot prove playback behavior.

MODULE_DIR=/data/adb/modules/switchroot_volume_normalization_fix

if [ "$(id -u)" != "0" ]; then
    echo "Run as root using su."
    exit 1
fi
if [ ! -d "$MODULE_DIR" ]; then
    echo "Module not installed."
    exit 1
fi
if [ -f "$MODULE_DIR/disable" ] || [ -f "$MODULE_DIR/remove" ]; then
    echo "Module disabled or pending removal."
    exit 1
fi
if ! command -v getprop >/dev/null 2>&1; then
    echo "getprop unavailable; run this verifier on Android."
    exit 1
fi

failed=0
check_prop() {
    actual=$(getprop "$1")
    if [ "$actual" = "$2" ]; then
        echo "OK: $1=$actual"
    else
        echo "MISMATCH: $1=$actual (expected $2)"
        failed=$((failed + 1))
    fi
}

check_prop audio.safemedia.bypass true
check_prop ro.audio.safe_media_volume.disabled true
check_prop ro.config.safe_media_volume.disabled true
check_prop ro.audio.loudness_control.enabled false
check_prop media.aac.loudness_control false
check_prop ro.audio.cta2075.enabled false

if [ "$failed" -ne 0 ]; then
    echo "$failed of 6 properties did not match. Check module status and conflicting modules."
    exit 1
fi

echo "All 6 properties match. This does not prove normalization or playback is fixed."
echo "No service log is expected for the properties-only variant. Test playback at low volume."
exit 0
