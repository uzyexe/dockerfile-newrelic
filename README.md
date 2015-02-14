# uzyexe/newrelic

Run the New Relic server monitor daemon.

## Dockerfile

[**Trusted Build**](https://index.docker.io/u/uzyexe/newrelic)

This Docker image is based on the official [debian:squeeze](https://index.docker.io/_/debian/) base image.

## Using

**Please note: Replaced by your newrelic license key is `YOUR_NEW_RELIC_LICENSE_KEY`**

### docker run


    docker run -d -e NEW_RELIC_LICENSE_KEY=YOUR_NEW_RELIC_LICENSE_KEY -h `hostname` uzyexe/newrelic

--

### cloud-config.yml

      units: 
        - name: newrelic.service
          command: start
          content: |
            [Unit]
            Description=newrelic
            
            [Service]
            Restart=always
            RestartSec=300
            TimeoutStartSec=10m
            ExecStartPre=-/usr/bin/docker stop newrelic
            ExecStartPre=-/usr/bin/docker rm -f newrelic
            ExecStartPre=/usr/bin/docker pull uzyexe/newrelic
            ExecStart=/bin/bash -c '/usr/bin/docker run --rm --name newrelic --env="NEW_RELIC_LICENSE_KEY=YOUR_NEW_RELIC_LICENSE_KEY" -h `/usr/bin/hostname` uzyexe/newrelic'
            ExecStop=/usr/bin/docker stop newrelic


## New Relic

[Getting started](https://docs.newrelic.com/docs/server/new-relic-servers)

[Release Notes](https://docs.newrelic.com/docs/releases/linux_server/)
