docker exec -it -u root postgres-otus mkdir sb_crm_cte
docker cp ./cte.sql postgres-otus:/sb_crm_cte
docker cp ./drop.sql postgres-otus:/sb_crm_cte
docker cp ./create.sql postgres-otus:/sb_crm_cte
docker exec -it -u root postgres-otus chown -R postgres:postgres sb_crm_cte
docker exec -it -u postgres postgres-otus psql -U sb_crm_user -d sb_crm -f sb_crm_cte/create.sql
docker exec -it -u postgres postgres-otus psql -U sb_crm_user -d sb_crm -f sb_crm_cte/cte.sql
docker exec -it -u postgres postgres-otus psql -U sb_crm_user -d sb_crm -f sb_crm_cte/drop.sql
