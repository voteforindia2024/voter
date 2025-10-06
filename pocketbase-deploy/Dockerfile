FROM alpine:latest

# Install dependencies
RUN apk add --no-cache ca-certificates

# Download latest PocketBase
RUN wget -O pocketbase.zip $(wget -q -O - https://api.github.com/repos/pocketbase/pocketbase/releases/latest | grep "browser_download_url.*linux_amd64.zip" | cut -d '"' -f 4) && \
    unzip pocketbase.zip && \
    chmod +x pocketbase && \
    mv pocketbase /usr/local/bin/ && \
    rm pocketbase.zip

# Copy your database
COPY pb_data /pb_data

EXPOSE 8080
CMD ["pocketbase", "serve", "--dir", "/pb_data", "--http=0.0.0.0:8080"]