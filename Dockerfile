FROM debian:jessie

ENV NEW_RELIC_LICENSE_KEY YOUR_LICENSE_KEY
ENV NEW_RELIC_SYSMOND_VERSION 2.3.0.129

# apt-get update, install newrelic server monitoring, and then clean
RUN apt-get update -q && apt-get install -yq ca-certificates wget procps && \
    echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list && \
    wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    apt-get update -q && \
    apt-get install -y -qq newrelic-sysmond=$NEW_RELIC_SYSMOND_VERSION && \
    apt-get clean

# supervisor
RUN apt-get install -y -qq supervisor && \
    mkdir -p /etc/supervisor/conf.d/ && \
    mkdir -p /var/log/supervisor/
ADD supervisord.conf /etc/supervisor/supervisord.conf

# supervisor-newrelic
ADD supervisord-newrelic.conf /etc/supervisor/conf.d/newrelic.conf

# enabled supervisord
CMD nrsysmond-config --set license_key=$NEW_RELIC_LICENSE_KEY && supervisord -n
