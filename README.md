# Gunbroker API Client

A custom Rails API that wraps the [Gunbroker.com](https://www.gunbroker.com) API, providing simplified endpoints for fetching and deleting product listings.

## Base URL

```
https://stormy-wildwood-73487-ffd42f228dca.herokuapp.com/api/v1
```

## Authentication

All requests require an API key passed via the `X-API-Key` header:

```
X-API-Key: your_api_key_here
```

Additionally, most endpoints require Gunbroker credentials passed via headers:

```
X-Username: your_gunbroker_username
X-Password: your_gunbroker_password
```

## Endpoints

| Method   | Path                | Description                              | Auth |
|----------|---------------------|------------------------------------------|------|
| POST     | `/auth/token`       | Generate a Gunbroker access token        | API Key + Credentials |
| GET      | `/items/search`     | Search for an item by UPC                | API Key + Credentials |
| GET      | `/items/:id`        | Fetch details for a specific item        | API Key + Credentials |
| GET      | `/inventory`        | List all items in the user's inventory   | API Key + Credentials |
| DELETE   | `/items/:id`        | End/delete a listing by item ID          | API Key + Credentials |

### Examples

Generate a token:

```bash
curl -X POST https://stormy-wildwood-73487-ffd42f228dca.herokuapp.com/api/v1/auth/token \
  -H "X-API-Key: your_api_key_here" \
  -H "X-Username: gunbroker_user" \
  -H "X-Password: gunbroker_pass"
```

Search for an item by UPC:

```bash
curl https://stormy-wildwood-73487-ffd42f228dca.herokuapp.com/api/v1/items/search?upc=012345678905 \
  -H "X-API-Key: your_api_key_here" \
  -H "X-Username: gunbroker_user" \
  -H "X-Password: gunbroker_pass"
```

End a listing:

```bash
curl -X DELETE https://stormy-wildwood-73487-ffd42f228dca.herokuapp.com/api/v1/items/12345678 \
  -H "X-API-Key: your_api_key_here" \
  -H "X-Username: gunbroker_user" \
  -H "X-Password: gunbroker_pass"
```
