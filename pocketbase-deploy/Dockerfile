FROM alpine:latest

# Install dependencies
RUN apk add --no-cache ca-certificates

# Download PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v0.22.9/pocketbase_0.22.9_linux_amd64 /pocketbase
RUN chmod +x /pocketbase

# Copy database
COPY pb_data /pb_data

# Expose and run
EXPOSE 8080
CMD ["/pocketbase", "serve", "--dir", "/pb_data", "--http=0.0.0.0:8080"]