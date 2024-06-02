import requests

keycloak_url = "http://keycloak-service.keycloak.svc/realms/nebhis/protocol/openid-connect/token"
client_id = "your-client-id"
client_secret = "your-client-secret"

def get_keycloak_token():
    payload = {
        'client_id': client_id,
        'client_secret': client_secret,
        'grant_type': 'client_credentials'
    }
    response = requests.post(keycloak_url, data=payload)
    token = response.json().get('access_token')
    return token

def call_application(token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    response = requests.get("http://jupiter.jupiter.svc", headers=headers)
    return response.json()

if __name__ == "__main__":
    token = get_keycloak_token()
    response = call_application(token)
    print(response)