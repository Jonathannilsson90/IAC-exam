import requests

# ==============================
# Pytest to ensure that a h1-tag
# exists on the webpage
# and a p-tag should not exist
# ==============================

try:
       res = requests.get("http://localhost:8080", timeout=3)
       assert res.status_code == 200
except:
        assert False, "Server is not running"
finally:
        print("Server tests ended successfully")


def test_server_response_h1():
    try:
        assert "<h1>Terraform made this possible</h1>" in res.text
    except:
        assert False, "<h1> - tag not found!"
    finally:
        print("test_server_response_h1 ended successfully")

def test_server_response_p():
    try:
        assert not "<p> This should not exist on the page!</p>" in res.text
    except:
        assert False, "Found <p> - tag or sever is not responding"
    finally:
        print("test_server_response_p ended successfully")

