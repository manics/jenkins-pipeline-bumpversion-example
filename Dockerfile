FROM docker.io/python:3.7-alpine
RUN apk add --no-cache git &&
    python3 -m pip install bump2version
