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

#### /v1/trending

##### Params

| Param | Default  | Required  |
| ----- |:--------:|:---------:|
| limit | 50       | false     |

**Example Request:**

```
GET /v1/trending?limit=20 HTTP/1.1
Content-Type: application/json
```

**Example Response:**

##### Success

```
HTTP/1.1 200 OK
Content-Type: application/json
Request-Id: EB5iGydiUL0h4bRu1ZyRIi

{
  "status": "success",
  "message": "Successfully fetched trending dongers.",
  "data": [
    {
      "dongerid": "575a1fddf8651de92150aa5b",
      "text": "⊂(▀¯▀⊂)",
      "visits": 25
    },
    {
      "dongerid": "575a1fcbf8651de92150aa5a",
      "text": ᕙ(˵ ಠ ਊ ಠ ˵)ᕗ",
      "visits": 6
    },
    ...
  ]
}
```

##### Error(s)

```
HTTP/1.1 500 Internal Server Error
Content-Type: application/json
Request-Id: HV2ZKGVJJklN0eH35IgNaB

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
  "userid": "1234567890ABCDEF",
  "messageid": "507f1f77bcf86cd799439011",
  "dongerid" "575a1fddf8651de92150aa5b"
}
```

**Example Response:**

##### Success

```
HTTP/1.1 200 OK
Content-Type: application/json
Request-Id: XvAT8cSxvkskGSZLQU1l9d

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
Request-Id: unx1VLuvvbCWzPMjBtnMTD

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
