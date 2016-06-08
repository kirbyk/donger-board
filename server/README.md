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
#### /v1/trending

**Example Request:**

```
GET /v1/trending HTTP/1.1
Content-Type: application/json
```

**Example Response:**

##### Success

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "status": "success",
  "message": "Successfully fetched trending dongers.",
  "data": [
    {
      "dongerId": "938",
      "index": 1
    },
    {
      "dongerId": "837",
      "index": 2
    },
    ...
  ]
}
```

##### Error(s)

```
HTTP/1.1 500 Internal Server Error
Content-Type: application/json

{
  "status": "error",
  "message": "Encountered an error while fetching the dongers.",
  "errors": [
    {
      "status": "500",
      "source": { "service": "mongodb" },
      "title": "MongoDB encountered an error.",
      "detail": "No response from MongoDB after three requests (3 second timeouts)."
    }
  ]
}
```

#### /v1/trending/poll

**Example Request:**

```
POST /v1/trending/poll HTTP/1.1
Content-Type: application/json

{
  "userId": "1234567890ABCDEF",
  "messageId": "507f1f77bcf86cd799439011",
  "dongerId" "938"
}
```

**Example Response:**

##### Success

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "status": "success",
  "message": "Successfully submitted trending poll.",
  "data": null
}
```

##### Error(s)

```
HTTP/1.1 400 Bad Request
Content-Type: application/json

{
  "status": "error",
  "message": "Encountered an error while submitting the trending poll.",
  "errors": [
    {
      "status": "422",
      "source": { "attribute": "dongerId" },
      "title":  "Invalid dongerId",
      "detail": "The dongerId submitted doesn't exist."
    },
    {
      "status": "500",
      "source": { "service": "mongodb" },
      "title": "MongoDB encountered an error.",
      "detail": "No response from MongoDB after three requests (3 second timeouts)."
    }
  ]
}
```
