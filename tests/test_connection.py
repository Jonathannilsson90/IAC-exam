import requests

# https://docs.pytest.org/en/stable/getting-started.html


def test_URL():
    try:
       res = requests.get("http://localhost:8080", timeout=3)
       assert res.status_code == 200
    except:
        assert False, "Server is not running"
    finally:
        print("Server tests ran successfully")

