### Hexlet tests and linter status:
![hexlet-check](https://github.com/MaksimovYuriy/rails-project-64/actions/workflows/hexlet-check.yml/badge.svg)
![CI](https://github.com/MaksimovYuriy/rails-project-64/actions/workflows/hexlet-check.yml)

![ci](https://github.com/MaksimovYuriy/rails-project-64/actions/workflows/ci.yml/badge.svg)
![CI](https://github.com/MaksimovYuriy/rails-project-64/actions/workflows/hexlet-check.yml)

Приложение на Render.com
https://rails-project-64-f6s1.onrender.com

Коллективный блог на Ruby on Rails

Возможности приложения:
    - Регистрация/авторизация пользователя
    - Возможность публиковать посты
    - Комментирование постов и ответы на уже существующие комментарии
    - Оценка постов

Основные технологии:
    - Ruby (3.4.1)
    - Rails (7.2.2.1)
    - Devise
    - Bootstrap
    - Slim-Rails

Сборка приложения на локальной машине:
    Требуется запуск команды: 
    ```
    make setup
    ```
    Будут выполнены следующие команды:
    - bundle install
	- yarn install
	- yarn build
	- yarn build:css
	- bin/rails db:migrate
	- bin/rails db:seed

    Это позволит настроить все зависимости и базу данных для корректной работы приложения
    После чего запустить командой:
    ```
    rails server
    ```
