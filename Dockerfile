# Use a minimal base image
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache bash

# Create app directory
WORKDIR /app

# Copy PocketBase binary and make executable
COPY pocketbase /app/pocketbase
RUN chmod +x /app/pocketbase

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Copy your existing database (optional - use volume for persistence)
COPY pb_data/ /app/pb_data/

# Expose port
EXPOSE 8080

# Start the application
CMD ["/app/start.sh"]