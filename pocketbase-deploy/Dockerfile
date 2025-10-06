FROM alpine:latest

# Install dependencies
RUN apk add --no-cache ca-certificates unzip

# Create non-root user
RUN addgroup -S pocketbase && adduser -S pocketbase -G pocketbase

# Download and install PocketBase
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.22.9/pocketbase_0.22.9_linux_amd64.zip && \
    unzip pocketbase_0.22.9_linux_amd64.zip && \
    rm pocketbase_0.22.9_linux_amd64.zip && \
    chmod +x /pocketbase && \
    mv /pocketbase /usr/local/bin/pocketbase

# Copy database
COPY pb_data /pb_data
RUN chown -R pocketbase:pocketbase /pb_data

# Switch to non-root user
USER pocketbase

# Expose port
EXPOSE 8080

# Start command
CMD ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8080"]