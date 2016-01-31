# uzyexe/newrelic [![Circle CI](https://circleci.com/gh/uzyexe/dockerfile-newrelic.svg?style=svg)](https://circleci.com/gh/uzyexe/dockerfile-newrelic)

Run the New Relic server monitor daemon.

## Dockerfile

[**Trusted Build**](https://hub.docker.com/r/uzyexe/newrelic/)

This Docker image is based on the official [debian:squeeze](https://hub.docker.com/_/debian/) base image.

## Using

**Please note: Replaced by your newrelic license key is `YOUR_NEW_RELIC_LICENSE_KEY`**

### docker run

In order to give newrelic full access for monitoring there are a few unusual flags you'll need.

    docker run -d \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        -e NEW_RELIC_LICENSE_KEY=YOUR_NEW_RELIC_LICENSE_KEY \
        --privileged \
        --pid="host" \
        --net="host" \
        --ipc="host" \
        -v /sys:/sys \
        -v /dev:/dev \
        --restart=always \
        --name newrelic \
        uzyexe/newrelic

--


## New Relic

[Getting started](https://docs.newrelic.com/docs/servers/new-relic-servers-linux/getting-started/new-relic-servers-linux)

[Release Notes](https://docs.newrelic.com/docs/release-notes/server-release-notes/servers-linux-release-notes)
