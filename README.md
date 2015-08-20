# uzyexe/newrelic

Run the New Relic server monitor daemon.

## Dockerfile

[**Trusted Build**](https://index.docker.io/u/uzyexe/newrelic)

This Docker image is based on the official [debian:squeeze](https://index.docker.io/_/debian/) base image.

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

[Getting started](https://docs.newrelic.com/docs/server/new-relic-servers)

[Release Notes](https://docs.newrelic.com/docs/releases/linux_server/)
