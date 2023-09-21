docker cp ./create_db_infra.sql postgres-otus:/create_db_infra.sql
docker exec -it -u root postgres-otus chown postgres:postgres create_db_infra.sql
docker exec -it -u postgres postgres-otus psql  -f create_db_infra.sql
