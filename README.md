# zestyhq-base

This Dockerfile builds the base image for CircleCI 2.0 builds used at Zesty. It's based on heroku/heroku:16.

## What's included?

- heroku-16 base image
- rbenv
- Ruby 2.3.5
- Build essentials

## Update Ruby

In order to update Ruby to a newer version you need to rebuild the image. You can run `docker build --build-arg ruby_version=2.4.1 .` (this builds the image with Ruby 2.4.1 being installed via rbenv).

## Deploy new image

Before you deploy a new base image you need to create a tag:

```
docker tag <build hash> halfdan/zestyhq-base:2.4.1
```

This will create a tag for this image named `2.4.1`.  You can now push this image to docker hub using:

```
docker push halfdan/zestyhq-base:2.4.1
```
