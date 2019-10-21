#!/bin/ash

set -e

export AWS_ACCESS_KEY_ID=$KEY
export AWS_SECRET_ACCESS_KEY=$SECRET
export AWS_DEFAULT_REGION=$REGION

export LOCKFILE=/s3sync.lock

touch $LOCKFILE

if [[ "$1" == 'now' ]]; then
    exec /sync.sh
else
    if [[ -z "$HEALTHCHECK_URL" ]]; then
	    echo "$CRON_SCHEDULE flock -x $LOCKFILE -c /sync.sh" >> /var/spool/cron/crontabs/root
    else
        echo "$CRON_SCHEDULE flock -x $LOCKFILE -c /sync.sh && wget $HEALTHCHECK_URL -O /dev/null" >> /var/spool/cron/crontabs/root
    fi
    crond -l 2 -f
fi
