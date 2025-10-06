FROM alpine:latest

RUN apk add --no-cache ca-certificates

RUN addgroup -S pocketbase && adduser -S pocketbase -G pocketbase

COPY pocketbase /usr/local/bin/pocketbase
RUN chmod +x /usr/local/bin/pocketbase

COPY pb_data /pb_data
RUN chown -R pocketbase:pocketbase /pb_data

USER pocketbase

EXPOSE 8080

CMD ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8080"]