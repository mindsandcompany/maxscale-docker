#!/bin/bash

function exitMaxScale {
    /usr/bin/monit unmonitor all
    /usr/bin/maxscale-stop
    /usr/bin/monit quit
}

rm -f /var/run/*.pid
rsyslogd

trap exitMaxScale SIGTERM

exec "$@" &

tail -n+1 -F /var/log/maxscale/maxscale.log &

wait
