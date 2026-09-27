# Hermes на VPS — режим 24/7

Рекомендуемый контур для АвтоСклада: отдельный Linux VPS и официальный стабильный Docker-образ Hermes.

## Требования

- Linux VPS;
- Git;
- Docker Engine;
- Docker Compose v2;
- SSH-доступ администратора только для первоначальной установки.

## Развёртывание

    git clone https://github.com/sergvolk17/avtosklad-agents.git ~/avtosklad-agents
    cd ~/avtosklad-agents
    bash deploy/vps/bootstrap-vps.sh

Далее интерактивно:

    docker compose -f deploy/vps/docker-compose.yml run --rm hermes setup --portal
    bash deploy/vps/apply-safety.sh
    docker compose -f deploy/vps/docker-compose.yml up -d
    bash deploy/vps/healthcheck.sh

## Изоляция

Hermes уже работает внутри контейнера. Мы намеренно не пробрасываем `/var/run/docker.sock` и не открываем публичные порты. Это снижает риск выхода агента на хост.

## Данные

Состояние Hermes хранится в Docker volume `hermes-data`. Код проекта хранится в GitHub. Секреты хранятся только в Hermes data/.env на VPS.

## Обновление

    cd ~/avtosklad-agents
    git pull --ff-only
    docker compose -f deploy/vps/docker-compose.yml pull
    docker compose -f deploy/vps/docker-compose.yml up -d
    bash deploy/vps/healthcheck.sh