#!/bin/bash
set -e

echo "Starting PocketBase..."

# Verify persistent disk
if [ -d "/pb_data" ]; then
  echo "Persistent disk mounted at /pb_data"
else
  echo "ERROR: /pb_data not mounted"
  exit 1
fi

# Verify database
if [ -f "/pb_data/data.db" ]; then
  echo "Database found: $(du -h /pb_data/data.db | cut -f1)"
else
  echo "No database found yet. PocketBase will create one."
fi

# Use Render's PORT
PORT=${PORT:-8080}
echo "Starting on port: $PORT"

# Start PocketBase using persistent disk
exec ./pocketbase serve \
  --http=0.0.0.0:$PORT \
  --dir=/pb_data
