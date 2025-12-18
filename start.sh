#!/bin/bash
set -e

echo "Starting PocketBase with existing data..."

# Verify database exists
if [ -f "/app/pb_data/data.db" ]; then
    echo "Database found: $(du -h /app/pb_data/data.db | cut -f1)"
else
    echo "Warning: Database file not found!"
fi

# Use Render's PORT
PORT=${PORT:-8080}

echo "Starting on port: $PORT"

# Start PocketBase with existing data directory
exec ./pocketbase serve \
  --http=0.0.0.0:$PORT \
  --dir=/app/pb_data