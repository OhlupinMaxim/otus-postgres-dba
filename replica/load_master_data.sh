docker exec -it -u postgres postgres-otus bash -c "psql -c 'CREATE DATABASE otus_master_replica_db;'"
docker exec -it -u postgres postgres-otus bash -c "psql -d otus_master_replica_db -c 'CREATE TABLE misc (data int);'"
docker exec -it -u postgres postgres-otus bash -c "psql -d otus_master_replica_db -c 'insert into misc values(0);'"

# по умолчанию в pg_hba создана запись вида
# host    replication     all             127.0.0.1/32            trust