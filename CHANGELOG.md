# Changelog

## Unreleased — source reconciliation

- Remove the v1.0 boot hook that reapplied properties and restarted audioserver.
- Match the published v1.1-safe asset's six-property set and version metadata.
- Point update metadata and installation links to the existing v1.1-safe asset.
- Replace stale service-log expectations and universal safety/compatibility claims.
- Make verification read-only, check all six properties, and report failures via
  exit status. Add offline regression checks.
- No release asset or Git tag changed; no physical-device testing performed.

## v1.1-safe (2025-08-10)

[Published release](https://github.com/deciduus/switchroot-volume-fix/releases/tag/v1.1)
(tag `v1.1`, marked prerelease). Its notes report removal of `service.sh` to
address boot loops, Magisk disabling modules, and Hekate boot failures. The ZIP
contains only the six core properties. Volume fluctuations may still occur.

Verified asset: `SwitchrootVolumeNormalizationFix-v1.1-safe.zip`

SHA-256: `f61448619f11963d3a0801f4b07d2458d4b9520a1fbae5522d5b6fb163fa6f59`

The v1.0, v1.1, and v1.2 Git tags all resolve to
`c87d88c06f3d732fbafb6ff01794ef7868459dbc`, which still contains the old boot hook.
The tagged source and source archives therefore differ from the published asset.
The asset's bundled docs and verifier also retain v1.0 instructions.

## v1.0 — historical

Original source used `system.prop` plus a timed `service.sh` that called
`resetprop` and restarted audioserver during boot. Do not use that behavior as
a safety or compatibility baseline. The original changelog labeled v1.0
2024-12-19; repository commits are dated 2025-08-10, so the original release date
is not established here.
