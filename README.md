[![Build Status](https://travis-ci.org/The-Vikings/phoenix-and-elm.svg?branch=master)](https://travis-ci.org/The-Vikings/phoenix-and-elm)

# Phoenix And Elm: a real use case

For now this is strongly based on the work done by Paul Fioravanti. 
We hope to disconnect us from his code soon, so to make this our own independent work.

## Installation

```sh
git clone --recursive https://github.com/the-vikings/phoenix-and-elm
cd phoenix-and-elm
docker-compose up
```

Open <http://localhost> in a browser.

## Changes from the original application

- We've added a Dockerfile, docker-compose configurations, changed some configuration files for brunch and phoenix, added a travis yaml file and added an entrypoint script.


## Deployment Notes

[Docker Hub][] is used to serve the docker images, currently only odgaard has access to this docker hub, so please contact him directly if you wish to make changes.


