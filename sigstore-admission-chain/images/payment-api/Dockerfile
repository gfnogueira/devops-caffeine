FROM alpine:3.20
RUN apk add --no-cache python3 && \
    echo 'print("payment-api up")' > /app.py
CMD ["python3", "/app.py"]
LABEL org.opencontainers.image.title="payment-api" \
      org.opencontainers.image.source="https://github.com/example/payment-api"
