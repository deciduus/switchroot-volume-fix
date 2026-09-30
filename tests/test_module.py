"""Offline contract tests. Never execute the installer or real Android commands."""
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
EXPECTED = {
    "audio.safemedia.bypass": "true",
    "ro.audio.safe_media_volume.disabled": "true",
    "ro.config.safe_media_volume.disabled": "true",
    "ro.audio.loudness_control.enabled": "false",
    "media.aac.loudness_control": "false",
    "ro.audio.cta2075.enabled": "false",
}


def properties(path):
    lines = [line.strip() for line in path.read_text().splitlines()
             if line.strip() and not line.lstrip().startswith("#")]
    pairs = [line.split("=", 1) for line in lines]
    if len(dict(pairs)) != len(pairs):
        raise AssertionError("Duplicate properties")
    return dict(pairs)


class ModuleContract(unittest.TestCase):
    def test_published_property_set(self):
        self.assertEqual(properties(ROOT / "system.prop"), EXPECTED)

    def test_no_boot_hooks(self):
        for name in ("service.sh", "post-fs-data.sh", "boot-completed.sh"):
            self.assertFalse((ROOT / name).exists(), name)

    def test_release_metadata(self):
        module = properties(ROOT / "module.prop")
        update = json.loads((ROOT / "update.json").read_text())
        self.assertEqual(module["id"], "switchroot_volume_normalization_fix")
        self.assertEqual(module["version"], "v1.1-safe")
        self.assertEqual(module["versionCode"], "2")
        self.assertEqual(update["version"], module["version"])
        self.assertEqual(update["versionCode"], int(module["versionCode"]))
        self.assertEqual(update["zipUrl"], "https://github.com/deciduus/"
                         "switchroot-volume-fix/releases/download/v1.1/"
                         "SwitchrootVolumeNormalizationFix-v1.1-safe.zip")
        for name in ("README.md", "install_guide.md"):
            self.assertIn(update["zipUrl"], (ROOT / name).read_text())

    def test_shell_syntax(self):
        for name in ("verify_fix.sh", "META-INF/com/google/android/update-binary"):
            subprocess.run(["sh", "-n", str(ROOT / name)], check=True)

    def test_verifier_is_read_only(self):
        script = (ROOT / "verify_fix.sh").read_text()
        self.assertNotRegex(script, r"(?m)^\s*(?:resetprop|setprop|stop|start|kill|reboot|rm|touch)\b")
        self.assertNotIn(">>", script)
        checked = dict(re.findall(r"^check_prop ([\w.]+) (true|false)$", script, re.M))
        self.assertEqual(checked, EXPECTED)

    def run_verifier(self, *, missing=False, marker=None, mismatch=None, uid="0"):
        with tempfile.TemporaryDirectory() as tmp:
            work = Path(tmp)
            module = work / "module"
            if not missing:
                module.mkdir()
                if marker:
                    (module / marker).touch()
            binary = work / "bin"
            binary.mkdir()
            (binary / "id").write_text(f"#!/bin/sh\necho {uid}\n")
            values = EXPECTED.copy()
            if mismatch:
                values[mismatch] = "unexpected"
            (binary / "getprop").write_text("#!/bin/sh\ncase \"$1\" in\n" + "".join(
                f"{key}) echo {value};;\n" for key, value in values.items()) + "esac\n")
            for path in binary.iterdir():
                path.chmod(0o755)
            # Rewrite only the fixed module path in a temporary copy. Production
            # verifier cannot be redirected to a fake module via environment.
            script = (ROOT / "verify_fix.sh").read_text().replace(
                "MODULE_DIR=/data/adb/modules/switchroot_volume_normalization_fix",
                f'MODULE_DIR="{module}"')
            env = dict(os.environ, PATH=str(binary) + ":" + os.defpath)
            return subprocess.run(["/bin/sh"], input=script, text=True, env=env,
                                  capture_output=True)

    def test_verifier_success_is_qualified(self):
        result = self.run_verifier()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("All 6 properties match", result.stdout)
        self.assertIn("does not prove", result.stdout)

    def test_verifier_rejects_each_property_mismatch(self):
        for prop in EXPECTED:
            with self.subTest(prop=prop):
                result = self.run_verifier(mismatch=prop)
                self.assertEqual(result.returncode, 1)
                self.assertIn(f"MISMATCH: {prop}", result.stdout)

    def test_verifier_rejects_inactive_or_missing_module(self):
        for args in ({"missing": True}, {"marker": "disable"}, {"marker": "remove"}):
            with self.subTest(args=args):
                self.assertEqual(self.run_verifier(**args).returncode, 1)

    def test_verifier_requires_root(self):
        result = self.run_verifier(uid="1000")
        self.assertEqual(result.returncode, 1)
        self.assertIn("Run as root", result.stdout)


if __name__ == "__main__":
    unittest.main()
