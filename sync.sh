#!/bin/ash

set -e

echo "$(date) - S3 Sync Start"
aws s3 sync $LOCAL_PATH s3://$BUCKET$BUCKET_PATH $PARAMS
echo "$(date) - S3 Sync End"
