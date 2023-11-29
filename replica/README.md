### HOMEWORK-18

Для создания мастера используем скрпиты из ./install

- Создадим контейнер с PostgreSQL
    - ../install/up_postgres.sh
    - ../install/create_infra.sh

- Заполним мастер временными данными выполнив скрипт
    - ./load_master_data.sh

- Создадим реплику в том же контейнере
 - ./create_replica.sh

#### Физическая реплика создается по крону раз в 5 минут




