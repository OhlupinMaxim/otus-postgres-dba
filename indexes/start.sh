docker exec -it -u root postgres-otus mkdir sb_crm_indexes
docker cp ./index.sql postgres-otus:/sb_crm_indexes
docker exec -it -u root postgres-otus chown -R postgres:postgres sb_crm_indexes
docker exec -it -u postgres postgres-otus psql -U sb_crm_user -d sb_crm -f sb_crm_indexes/index.sql
