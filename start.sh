#!/bin/sh
# Заменяем порт 8080 на тот, который выдаст Railway ($PORT)
sed -i "s/8080/${PORT}/g" /etc/xray/config.json

# Запускаем Xray (exec передает управление процессу, чтобы он корректно работал в контейнере)
exec xray run -c /etc/xray/config.json
