DongerBoard API
===============

The backend API that supports the DongerBoard iOS keyboard. Built with golang and [mux](https://github.com/gorilla/mux).

## Development

### Installation

```bash
make install
```

### Building & Running

```bash
export GOBIN=`pwd`/bin
make
```

## Endpoints
---------

#### /v1/trending/poll

**Example Request:**

```
POST /v1/trending/poll HTTP/1.1
Content-Type: application/json

{
  "userId": "1234567890ABCDEF",
  "ts": 1465351791910,
  "dongerId" "938"
}
```

**Example Response:**

```json
{
  "status": 200,
  "message": "Successfully submitted trending poll."
}
```
