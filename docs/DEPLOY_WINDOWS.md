# Hermes на Windows — пилот

Это самый быстрый способ начать работу с агентами на компьютере директора.

## Клонирование и подготовка

Откройте PowerShell и выполните:

    git clone https://github.com/sergvolk17/avtosklad-agents.git "$HOME\avtosklad-agents"
    cd "$HOME\avtosklad-agents"
    powershell -ExecutionPolicy Bypass -File .\deploy\windows\install-hermes.ps1

Если Hermes ещё не установлен, скрипт покажет официальную команду установки. После установки закройте и заново откройте PowerShell, затем повторите скрипт.

## Настройка модели

Самый простой интерактивный путь:

    hermes setup --portal

Либо используйте `hermes setup` и своего провайдера. API-ключи вводятся локально в Hermes и не должны попадать в GitHub или чат.

## Проверка

    hermes doctor
    hermes

Проверьте, что Hermes видит навыки AutoSklad.

## Постоянная работа

Windows подходит для пилота. Для 24/7 рекомендуется отдельный VPS. Dashboard/API не открывать напрямую в интернет.