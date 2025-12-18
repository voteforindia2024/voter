FROM alpine:latest

# Install dependencies
RUN apk add --no-cache bash

WORKDIR /app

# 1. Download Linux binary for Render (NOT your Windows .exe)
RUN wget -q https://github.com/pocketbase/pocketbase/releases/download/v0.22.17/pocketbase_0.22.17_linux_amd64.zip \
    && unzip pocketbase_0.22.17_linux_amd64.zip \
    && chmod +x pocketbase \
    && rm pocketbase_0.22.17_linux_amd64.zip

# 2. Copy your ENTIRE database with records
COPY pocketbase/pb_data /app/pb_data

# 3. Set proper permissions for the database
RUN chmod -R 755 /app/pb_data

# 4. Copy startup script
COPY start.sh .
RUN chmod +x start.sh

EXPOSE 8080

CMD ["./start.sh"]