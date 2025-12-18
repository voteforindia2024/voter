FROM alpine:latest

# Install dependencies
RUN apk add --no-cache bash

WORKDIR /app

# Use SAME version as local: v0.30.1
ARG PB_VERSION=0.30.1
RUN wget -q https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip \
    && unzip pocketbase_${PB_VERSION}_linux_amd64.zip \
    && chmod +x pocketbase \
    && rm pocketbase_${PB_VERSION}_linux_amd64.zip

# Copy your existing database (from v0.30.1)
COPY pocketbase/pb_data /app/pb_data

# 3. Set proper permissions for the database
RUN chmod -R 755 /app/pb_data

# 4. Copy startup script
COPY start.sh .
RUN chmod +x start.sh

EXPOSE 8080

CMD ["./start.sh"]