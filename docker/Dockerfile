FROM python:3.12-alpine

RUN apk add --no-cache \
    pandoc \
    texlive \
    mutt \
    msmtp

RUN pip install --no-cache-dir \
    mkdocs \
    mkdocs-material

WORKDIR /app
