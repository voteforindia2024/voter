FROM alpine:latest

# Install dependencies
RUN apk add --no-cache bash wget unzip

WORKDIR /app

# PocketBase version
ARG PB_VERSION=0.30.1
ARG CACHE_BUST=1

# Download and extract PocketBase
RUN echo "Cache bust: $CACHE_BUST" \
 && wget -q https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip \
 && unzip pocketbase_${PB_VERSION}_linux_amd64.zip \
 && chmod +x pocketbase \
 && rm pocketbase_${PB_VERSION}_linux_amd64.zip

# Copy startup script
COPY start.sh .
RUN chmod +x start.sh

# Expose the port Render expects
EXPOSE 8080

# Start PocketBase
CMD ["./start.sh"]
