#!/bin/sh
# Запускаем Xray на внутреннем порту 8080 в фоновом режиме (&)
xray run -c /etc/xray/config.json &

# Запускаем Caddy как главный процесс контейнера (exec)
exec caddy run --config /etc/caddy/Caddyfile
