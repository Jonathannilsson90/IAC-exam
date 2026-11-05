import requests
res = requests.get("http://localhost:8080", timeout=3)

def test_server_response_h1():
    assert "<h1>Terraform made this possible</h1>" in res.text

def test_server_response_p():
    assert not "<p> This should not exist on the page!</p>" in res.text
     
