import subprocess

def test_curl_installed_in_container():
        res = subprocess.run(
        ["docker", "exec", "nginx", "sh", "-c", "command -v curl"],        capture_output=True, text=True,
        )
        assert res.returncode == 0, "curl saknas"
