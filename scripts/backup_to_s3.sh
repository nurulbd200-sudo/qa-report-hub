#!/usr/bin/env bash
# Usage: backup_to_s3.sh <bucket-name>
set -euo pipefail
BUCKET="$1"
STAMP=$(date +%Y%m%d-%H%M%S)
ARCHIVE="/tmp/reports-$STAMP.tar.gz"
tar -czf "$ARCHIVE" -C /data reports
aws s3 cp "$ARCHIVE" "s3://$BUCKET/backups/"
rm -f "$ARCHIVE"
echo "Backup uploaded: reports-$STAMP.tar.gz"
