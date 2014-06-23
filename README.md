# uzyexe/newrelic

Run the New Relic server monitor daemon for docker and coreos server.

## Dockerfile

[**Trusted Build**](https://index.docker.io/u/uzyexe/newrelic)

This Docker image is based on the official [debian:squeeze](https://index.docker.io/_/debian/) base image.

## Using

### case 1: docker run

* Execute `docker run` command.

**Please note: Replaced by your newrelic license key is `YOUR_NEW_RELIC_LICENSE_KEY` and `YOUR_HOSTNAME`**

    docker run -d -e NEW_RELIC_LICENSE_KEY=YOUR_NEW_RELIC_LICENSE_KEY -h YOUR_HOSTNAME uzyexe/newrelic

--

### case 2: Auto-Running configure for cloud-config.yml (for Disk Booting coreos)

* Add valid values `units` and `write_files` in `cloud-config.yml`

**Please note: Replaced by your newrelic license key is `YOUR_NEW_RELIC_LICENSE_KEY`**

    coreos:
      units:
        - name: coreos-setup-environment.service
          command: restart
          content: |
              [Unit]
              Description=Modifies /etc/environment for CoreOS
              RequiresMountsFor=/usr/share/oem
              ConditionPathIsMountPoint=/usr
               
              [Service]
              Type=oneshot
              RemainAfterExit=yes
              ExecStart=/usr/bin/coreos-setup-environment /etc/environment
              
              [Install]
              WantedBy=multi-user.target
        - name: coreos-setup-hostname.service
          command: start
          content: |
              [Unit]
              Description=Add HOSTNAME /etc/environment for CoreOS

              [Service]
              Type=oneshot
              RemainAfterExit=yes
              ExecStart=/bin/sh /tmp/coreos-setup-hostname /etc/environment

              [Install]
              WantedBy=multi-user.target
        - name: docker.service
          command: start
        - name: newrelic-client.service
          command: start
          content: |
              [Unit]
              Description=newrelic-client

              [Service]
              EnvironmentFile=/etc/environment
              TimeoutStartSec=20m
              ExecStartPre=-/usr/bin/docker rm -f newrelic-client
              ExecStart=/usr/bin/docker run --name newrelic-client --rm --env="NEW_RELIC_LICENSE_KEY=YOUR_NEW_RELIC_LICENSE_KEY" -h ${HOSTNAME} uzyexe/newrelic
              ExecStop=/usr/bin/docker kill newrelic-client

              [Install]
              WantedBy=multi-user.target

    write_files:
      - path: /tmp/coreos-setup-hostname
        content: |
            #!/bin/bash +x
            ENV=$1

            if [ -z "$ENV" ]; then
              echo usage: $0 /etc/environment
              exit 1
            fi

            grep -c HOSTNAME $ENV || echo HOSTNAME=$HOSTNAME >> $ENV

[https://gist.github.com/uzyexe/bc943d6099a8fbaa9cd7](https://gist.github.com/uzyexe/bc943d6099a8fbaa9cd7)

--

### case 3: Auto-Running configure for cloud-config.yml (for PXE Booting coreos)

* Add valid values `units` and `write_files` in `cloud-config.yml`

**Please note: Replaced by your newrelic license key is `YOUR_NEW_RELIC_LICENSE_KEY`**

    coreos:
      units:
        - name: coreos-setup-environment.service
          command: restart
          content: |
              [Unit]
              Description=Modifies /etc/environment for CoreOS
              RequiresMountsFor=/usr/share/oem
              ConditionPathIsMountPoint=/usr
               
              [Service]
              Type=oneshot
              RemainAfterExit=yes
              ExecStart=/usr/bin/coreos-setup-environment /etc/environment
              
              [Install]
              WantedBy=multi-user.target
        - name: coreos-setup-hostname.service
          command: start
          content: |
              [Unit]
              Description=Add HOSTNAME /etc/environment for CoreOS

              [Service]
              Type=oneshot
              RemainAfterExit=yes
              ExecStart=/bin/sh /tmp/coreos-setup-hostname /etc/environment

              [Install]
              WantedBy=multi-user.target
        - name: docker.service
          command: restart
          content: |
              [Unit]
              Description=Docker Application Container Engine
              Documentation=http://docs.docker.io

              [Service]
              Environment="TMPDIR=/var/tmp/"
              ExecStartPre=/bin/mount --make-rprivate /
              ExecStart=/usr/bin/docker -d -r=false -H fd://

              [Install]
              WantedBy=multi-user.target
        - name: newrelic-sysmond.service
          command: start
          content: |
              [Unit]
              Description=newrelic-sysmond

              [Service]
              EnvironmentFile=/etc/environment
              TimeoutStartSec=20m
              ExecStart=/usr/bin/docker run --name newrelic-sysmond --rm --env="NEW_RELIC_LICENSE_KEY=YOUR_NEW_RELIC_LICENSE_KEY" -h ${HOSTNAME} uzyexe/newrelic
              ExecStop=/usr/bin/docker kill newrelic-sysmond

              [Install]
              WantedBy=multi-user.target

    write_files:
      - path: /tmp/coreos-setup-hostname
        content: |
            #!/bin/bash +x
            ENV=$1

            if [ -z "$ENV" ]; then
              echo usage: $0 /etc/environment
              exit 1
            fi

            grep -c HOSTNAME $ENV || echo HOSTNAME=$HOSTNAME >> $ENV

[https://gist.github.com/uzyexe/5646eef7a4ca42d79f04](https://gist.github.com/uzyexe/5646eef7a4ca42d79f04)

## New Relic

[Getting started](https://docs.newrelic.com/docs/server/new-relic-servers)

[Release Notes](https://docs.newrelic.com/docs/releases/linux_server/)
