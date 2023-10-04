### OTUS DB HW 6


### Установка БД

Предположим что мы находимся в ОС Windows 11 и имеем установленный Docker Desktop.
Нам необохдимо скачать образ Postgres из DockerHub.

- Скачиваем образ и запускаем его.
![скрипт up_postgres.sh](../images/OTUS_DB_HW_6_1.png)
![скрипт up_postgres.sh](../images/OTUS_DB_HW_6_2.png)
![скрипт up_postgres.sh](../images/OTUS_DB_HW_6_3.png)

- Создаем базу данных, схему и пользователя.
![скрипт create_infra.sh create_db_infra.sql](../images/OTUS_DB_HW_6_4.png)
![скрипт create_infra.sh create_db_infra.sql](../images/OTUS_DB_HW_6_5.png)

- Входим в БД под созданным пользователем в созданную БД
![скрипт psql.sh](../images/OTUS_DB_HW_6_6.png)
![скрипт psql.sh](../images/OTUS_DB_HW_6_7.png)
