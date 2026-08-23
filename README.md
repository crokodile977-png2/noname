# VLESS + Reality VPN сервер для Railway

## Что внутри
- `config.json` — конфиг Xray-core (VLESS, Reality, порт 443)
- `Dockerfile` — образ на базе `teddysun/xray` (готовая сборка Xray-core)

Уже сгенерировано и прописано в конфиге:
- **UUID клиента**: `56cb5cc5-7154-4fcb-93be-b40580737e00`
- **Private key (Reality)**: `mK92seR4INeNYbYXXTWuDtgm6m-UnhMWOuTP6sw0l0I`
- **Public key (Reality, нужен клиенту)**: `ZXnBHNAPrlVsbr9Y6AA8lT96gsZqwhsd0ADbbWRZVjk`
- **Short ID**: `0c0432f0dba300a9`
- **Маскируемся под**: `www.microsoft.com`

## Шаг 1. Заливаем в GitHub
Создай новый репозиторий и запушь туда эти 3 файла (config.json, Dockerfile, README.md).

## Шаг 2. Деплой на Railway
1. Заходишь на railway.app → New Project → Deploy from GitHub repo → выбираешь репозиторий.
2. Railway сам увидит Dockerfile и соберёт образ. Дополнительные переменные окружения не нужны — всё уже в config.json.
3. Дожидаешься, пока билд и деплой завершатся (статус Active).

## Шаг 3. Включаем TCP Proxy (это важно!)
VLESS+Reality — это "сырой" TCP+TLS трафик, а не HTTP, поэтому обычный публичный домен Railway (который работает через HTTP-прокси) тут не подойдёт.

1. Открой сервис → вкладка **Settings** → раздел **Networking**.
2. В блоке **TCP Proxy** нажми **Add TCP Proxy**, укажи внутренний порт **443**.
3. Railway выдаст тебе внешний адрес вида:
   ```
   containers-us-west-123.railway.app:31415
   ```
   Это и есть твой сервер + порт для подключения (не путать с портом 443 внутри контейнера — снаружи будет другой порт).

## Шаг 4. Собираем ссылку для V2rayTun
Подставь в шаблон адрес и порт из шага 3:

```
vless://56cb5cc5-7154-4fcb-93be-b40580737e00@ТВОЙ_ХОСТ:ТВОЙ_ПОРТ?encryption=none&security=reality&sni=www.microsoft.com&fp=chrome&pbk=ZXnBHNAPrlVsbr9Y6AA8lT96gsZqwhsd0ADbbWRZVjk&sid=0c0432f0dba300a9&type=tcp&flow=xtls-rprx-vision#Railway-Reality
```

Эту ссылку можно:
- вставить в V2rayTun через "Добавить из буфера обмена / Import from clipboard";
- или сконвертировать в QR-код (например на qr-code-generator.com) и отсканировать в приложении на телефоне.

То же самое подключение будет работать и на ПК, и на смартфоне — просто добавь конфиг в оба приложения.

## Проверка
После добавления сервера в V2rayTun нажми "Тест соединения" (Test/Ping) — если Reality настроена верно, задержка покажется корректно, и можно включать VPN.

## Важные нюансы
- **Один UUID = один клиент.** Если хочешь дать доступ друзьям, добавь ещё объекты в массив `clients` в config.json (каждому свой UUID) и передеплой.
- **Смена "маскировочного" сайта**: если `www.microsoft.com` будет заблокирован/недоступен из твоей сети, можно заменить на другой популярный сайт с хорошим TLS 1.3 + HTTP/2 (например `www.swift.com`, `www.samsung.com`) — меняешь `dest` и `serverNames` в config.json.
- **Railway free tier**: имей в виду лимиты по трафику/часам на бесплатном плане — при активном использовании VPN траффик может быть значительным, стоит проверить текущие условия в тарифах Railway.
