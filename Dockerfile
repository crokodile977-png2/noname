FROM alpine:latest

# Устанавливаем curl и unzip для скачивания Xray
RUN apk add --no-cache curl unzip

# Скачиваем и распаковываем последнюю версию Xray-core (Linux 64-bit)
RUN curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip -d /usr/local/bin/ /tmp/xray.zip && \
    rm /tmp/xray.zip && \
    chmod +x /usr/local/bin/xray

# Копируем наши файлы конфигурации и запуска
COPY config.json /etc/xray/config.json
COPY start.sh /start.sh

# Делаем скрипт запускаемым
RUN chmod +x /start.sh

# Команда запуска
CMD ["/start.sh"]
