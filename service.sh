#!/system/bin/sh

# Switchroot Volume Normalization Fix - Service Script
# This script runs during boot to ensure properties are set correctly
# and restarts audio services for immediate effect

# Wait for system to be ready
sleep 10

# Log start
echo "$(date): Switchroot Volume Normalization Fix - Starting service" >> /data/local/tmp/switchroot_volume_fix.log

# Apply properties using resetprop for immediate effect
# These supplement the system.prop file for better compatibility
resetprop audio.safemedia.bypass true
resetprop ro.audio.safe_media_volume.disabled true
resetprop ro.audio.loudness_control.enabled false
resetprop media.aac.loudness_control false
resetprop ro.audio.cta2075.enabled false

# Restart audio services to apply changes immediately
stop audioserver
sleep 2
start audioserver

# Verify properties were set
if [ "$(getprop audio.safemedia.bypass)" = "true" ]; then
    echo "$(date): Volume normalization fix applied successfully" >> /data/local/tmp/switchroot_volume_fix.log
else
    echo "$(date): Warning: Volume normalization fix may not have applied correctly" >> /data/local/tmp/switchroot_volume_fix.log
fi
