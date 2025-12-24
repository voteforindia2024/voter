FROM alpine:latest

# Install dependencies
RUN apk add --no-cache bash wget unzip

WORKDIR /app

# PocketBase version
ARG PB_VERSION=0.30.1
ARG CACHE_BUST=1

RUN echo "Cache bust: $CACHE_BUST" \
 && wget -q https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip \
 && unzip pocketbase_${PB_VERSION}_linux_amd64.zip \
 && chmod +x pocketbase \
 && rm pocketbase_${PB_VERSION}_linux_amd64.zip

COPY start.sh .
RUN chmod +x start.sh

EXPOSE 8080

CMD ["./start.sh"]
