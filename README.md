# Url Shortener Code Test

Without using an external database, we'd like you to create a URL shortening
service. The URLs do not need to persist between restarts, but should be
shareable between different clients while the server is running.

- There should be an endpoint that responds to `POST` with a json body
  containing a URL, which responds with a JSON repsonse of the short url and
  the orignal URL, as in the following curl example:

```
curl localhost:4000 -XPOST -d '{ "url": "http://www.farmdrop.com" }'
{ "short_url": "/abc123", "url": "http://www.farmdrop.com" }
```


- When you send a GET request to a previously returned URL, it should redirect
  to the POSTed URL, as shown in the following curl example:

```
curl -v localhost:4000/abc123
...
< HTTP/1.1 301 Moved Permanently
...
< Location: http://www.farmdrop.com
...
{ "url": "http://www.farmdrop.com" }
```

Use whatever languages and frameworks you are comfortable with. Don't worry
about getting the whole thing working flawlessly, this is more to see how you
structure a program. Please don't spend more than a few hours on it.

Bonus points:

- I often forget to type "http://" at the start of a URL. It would be nice if
  this was handled by the application (frontend or backend is up to you).
- We like to see how you approach the problem, so a few git commits with a
  clear message about what you're doing are better than one git commit with
  everything in it.
- We like tests. We don't expect a full test suite, but some tests would be
  nice to see. Its up to you whether thats integration, unit or some other
  level of testing.
- We'd be very happy to see a Dockerfile to run the project. This by no means a
  requirement, so don't go reading the Docker docs if you've never worked with
  it.
- If you'd like to show off your frontend skills, you could create a simple
  frontend that can create and display shortened URLs without reloading the
  page.

## Submission

Please clone this repository, write some code and update this README with a
guide of how to run it.

Either send us a link to the repository on somewhere like github or bitbucket
(bitbucket has free private repositories) or send us a git bundle.

    git bundle create yournamehere-url-shortener-test.bundle master

And send us the resulting `yournamehere-url-shortener-test.bundle` file.

This `.bundle` file can be cloned using:

    git bundle clone bundle-filename.bundle -b master directory-name

# Url Shortener Code Test - Simon's answer

## Instalation

### Run

```
bundle
```

### Launch web server

```
bundle exec rails s
```

API is in subdomain so add something like

```
127.0.0.1       api.example.com 
```

to your `/etc/hosts` file

## Playing with cURL

### Check application status

```
curl http://api.example.com:3000/v1/status
```

```json
{ "status": "ok" }
```

### Create new entry

```
curl http://api.example.com:3000/v1 -XPOST -d '{ "url": "http://www.farmdrop.com" }'
```

```json
{
  "short_url": "eNrLKCkpsNLXLy8v10tLLMpNKcov0EvOzwUAZxcItA==",
  "url":"http://www.farmdrop.com"
}
```

### Read existing entry

```
curl -v http://api.example.com:3000/v1/eNrLKCkpsNLXLy8v10tLLMpNKcov0EvOzwUAZxcItA==
```

```
 TCP_NODELAY set
* Connected to api.example.com (127.0.0.1) port 3000 (#0)
> GET /v1/eNrLKCkpsNLXLy8v10tLLMpNKcov0EvOzwUAZxcItA== HTTP/1.1
> Host: api.example.com:3000
> User-Agent: curl/7.54.0
> Accept: */*
>
< HTTP/1.1 301 Moved Permanently
< X-Frame-Options: SAMEORIGIN
< X-Xss-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< Location: http://www.farmdrop.com
< Content-Type: text/html; charset=utf-8
< Cache-Control: no-cache
< X-Request-Id: 5e380582-0861-4157-950d-92466a2b5bfd
< X-Runtime: 0.004463
< Server: WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
< Date: Wed, 24 Oct 2018 18:55:37 GMT
< Content-Length: 89
< Connection: Keep-Alive
<
* Connection #0 to host api.example.com left intact
```

### Read not existing entry

```
curl -v http://api.example.com:3000/v1/hello
```

```
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to api.example.com (127.0.0.1) port 3000 (#0)
> GET /v1/hello HTTP/1.1
> Host: api.example.com:3000
> User-Agent: curl/7.54.0
> Accept: */*
>
< HTTP/1.1 404 Not Found
< X-Frame-Options: SAMEORIGIN
< X-Xss-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< Content-Type: application/json; charset=utf-8
< Cache-Control: no-cache
< X-Request-Id: 50b5258c-95cb-4a62-a1d9-7825f8399128
< X-Runtime: 0.002918
< Server: WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
< Date: Wed, 24 Oct 2018 18:57:30 GMT
< Content-Length: 21
< Connection: Keep-Alive
<
* Connection #0 to host api.example.com left intact
```

## Automatic testing (TDD/BDD)

I use Rspec for tests. API was developed facing TDD approach. Installed gem simplecov shows 100% coverage.

## Dockerize project

### Build

```
docker build --add-host=api.example.com:127.0.0.1 -t szymon/farmdrop:1.0 .
```

### Run

```
docker run -p 4000:4000 szymon/farmdrop:1.0
```

### Test

```
curl http://api.example.com:4000/v1/status
```

```json
{ "status": "ok" }
```
