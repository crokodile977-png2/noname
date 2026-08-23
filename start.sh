#!/bin/sh
# 1. Заменяем PORT_PLACEHOLDER на реальный порт, который выдал Railway
sed -i "s/PORT_PLACEHOLDER/${PORT}/g" /etc/nginx/nginx.conf

# 2. Запускаем Xray в фоновом режиме на порту 8081
xray run -c /etc/xray/config.json &

# 3. Запускаем Nginx в главном потоке (daemon off; нужен для Docker, чтобы контейнер не падал)
exec nginx -g "daemon off;"
