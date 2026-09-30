# Installation guide

Use the published **v1.1-safe prerelease** asset:
[SwitchrootVolumeNormalizationFix-v1.1-safe.zip](https://github.com/deciduus/switchroot-volume-fix/releases/download/v1.1/SwitchrootVolumeNormalizationFix-v1.1-safe.zip).
GitHub's source archives for the old tags contain the boot script and are not the
same package. No new release is published by this source update.

## Before installing

- Use a rooted Switchroot device with Magisk v20.4+ (installer minimum).
- Keep a backup and a known recovery route for disabling Magisk modules if Android
  does not boot. Do not install if you cannot recover the device.
- Read the [current README](README.md), including the compatibility limits.
- Start playback quietly: the properties may bypass safe-volume limits.

## Install and check

1. Download the named release asset, not “Source code (zip)”.
2. Open Magisk → Modules → Install from storage and select the ZIP.
3. Reboot, then verify the module is enabled in Magisk.
4. Copy the current repository's `verify_fix.sh` to `/sdcard/Download/` and run
   `su -c 'sh /sdcard/Download/verify_fix.sh'` from your terminal.
5. Test playback at low volume. Correct property values are not proof of an audio fix.

The ZIP's bundled guide/verifier predate the properties-only change. A service
log is not expected, and the module should not restart audio during boot.
Volume fluctuations may persist; the v1.1 release notes explicitly mention this
limitation. No universal device or audio-processor compatibility is claimed.

## Problems or removal

If values do not match, check the module status and reboot once. Other modules or
the ROM may override or ignore them. If audio worsens, disable the module and
reboot rather than adding an automatic audio restart.

Remove through Magisk → Modules → Remove, then reboot. If Android cannot boot,
use your established recovery procedure to disable the module. Report unresolved
issues at [GitHub Issues](https://github.com/deciduus/switchroot-volume-fix/issues).
