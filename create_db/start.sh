# docker exec -u root postgres-otus rm -rf sb_*
docker cp ./sb_crm postgres-otus:/sb_crm
docker exec -it -u root postgres-otus chown -R postgres:postgres sb_crm
# docker exec -it -u postgres postgres-otus psql  -f sb_crm/drop_all.sql
docker exec -it -u postgres postgres-otus psql  -f sb_crm/create_db_sm_crm.sql
docker exec -it -u postgres postgres-otus psql  -f sb_crm/create_table.sql -U sb_crm_user -d sb_crm

