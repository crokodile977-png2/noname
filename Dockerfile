FROM alpine:latest

# Устанавливаем Nginx, curl и unzip
RUN apk add --no-cache nginx curl unzip

# Скачиваем и устанавливаем Xray
RUN curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip -d /usr/local/bin/ /tmp/xray.zip && \
    rm /tmp/xray.zip && \
    chmod +x /usr/local/bin/xray

# Копируем наши файлы
COPY config.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]
