#!/bin/sh
# Запускаем Xray на внутреннем порту 8080 в фоновом режиме (&)
xray run -c /etc/xray/config.json &

# Запускаем Caddy, который примет внешний трафик на порту Railway ($PORT)
# exec делает его главным процессом контейнера, чтобы Railway видел, что он жив
exec caddy run --config /etc/caddy/Caddyfile
