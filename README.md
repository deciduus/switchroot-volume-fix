# Switchroot Volume Normalization Fix

A properties-only Magisk workaround for volume normalization conflicts on
Switchroot Android 15 with Viper4Android. It requests six audio property values;
whether Android honors them depends on the ROM and audio stack.

## Current release and installation

The published asset is **v1.1-safe**, marked as a **prerelease**:
[SwitchrootVolumeNormalizationFix-v1.1-safe.zip](https://github.com/deciduus/switchroot-volume-fix/releases/download/v1.1/SwitchrootVolumeNormalizationFix-v1.1-safe.zip).
Read the [release notes](https://github.com/deciduus/switchroot-volume-fix/releases/tag/v1.1)
and [installation guide](install_guide.md) before installing.

1. Have a rooted Switchroot device, Magisk v20.4+ (the installer's minimum), a
   backup, and a working way to disable modules if Android cannot boot.
2. Download the named ZIP asset above, not GitHub's **Source code** archives.
3. In Magisk, choose **Modules → Install from storage**, then select the ZIP.
4. Reboot and check the module status and properties before testing playback at
   a low volume.

The existing v1.0, v1.1, and v1.2 Git tags all reference the old v1.0 source,
including its boot-time audio restart. They do **not** reproduce the v1.1-safe
asset. This source reconciliation does not change those tags or publish a new
release. The asset also contains older documentation and a verifier; use the
current instructions and verifier here instead.

## Why the boot script was removed

The v1.1 release notes report boot loops, Magisk disabling modules, and Hekate
boot failures with v1.0. The published safe asset removes `service.sh` and uses
only `system.prop`. This source follows that approach: no timed boot hook,
`resetprop` loop, audio service restart, or service log is expected.

The six values are:

```properties
audio.safemedia.bypass=true
ro.audio.safe_media_volume.disabled=true
ro.config.safe_media_volume.disabled=true
ro.audio.loudness_control.enabled=false
media.aac.loudness_control=false
ro.audio.cta2075.enabled=false
```

## Verification and limitations

After reboot, a read-only spot check is:

```sh
su -c 'getprop audio.safemedia.bypass'
```

Expected: `true`. To check all six properties and the module status, copy the
current repository's `verify_fix.sh` to your device and run it explicitly:

```sh
su -c 'sh /sdcard/Download/verify_fix.sh'
```

The verifier returns a failure status for missing, disabled, removal-pending,
or mismatched installations. It does not change properties or restart audio.
Matching values do **not** prove that normalization is disabled or that playback
is fixed. The release notes acknowledge that volume fluctuations may remain
without immediate property application. Automatic audio restarts are deliberately
not restored here; if playback is worse, disable the module and reboot.

- The name “safe” describes the published variant, not a guarantee of boot safety.
- These properties can bypass safe-media-volume limits. Start quietly and protect
  your hearing, especially with headphones.
- Compatibility with every Switch model, ROM, Magisk release, V4A variant, or
  other audio module has not been established.
- Systemless installation does not eliminate boot risk or guarantee compatibility
  with future ROM updates. Uninstalling may require recovery if Android will not boot.
- This source change has static/host tests only; no physical-device testing was
  performed for it.

## Troubleshooting and removal

Check that Magisk lists the module as enabled, reboot once after installation,
and inspect all six property values. Other audio modules or the ROM may override
or ignore them. A missing old service log is normal for the properties-only
variant. Do not interpret a leftover v1.0 log as evidence of current behavior.

To remove it, choose **Remove** in Magisk's Modules screen and reboot. If Android
cannot boot, use your established Magisk/module recovery procedure. Report issues
with your Switch model, ROM, Magisk version, module version, and property results
at [GitHub Issues](https://github.com/deciduus/switchroot-volume-fix/issues).

## Contributor checks

Run `python3 -m unittest discover -s tests -v`. These offline checks validate the
release metadata/property contract, absence of boot hooks, shell syntax, and
verifier behavior with mocked commands. They do not install the module or validate
Android audio behavior. See [CHANGELOG.md](CHANGELOG.md) for release provenance.
