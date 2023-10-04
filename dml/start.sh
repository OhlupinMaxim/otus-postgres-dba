docker cp ./insert postgres-otus:/sb_srm_dml
docker exec -it -u root postgres-otus chown -R postgres:postgres sb_srm_insert
docker exec -it -u postgres postgres-otus psql -U sb_crm_user -d sb_crm -f sb_srm_dml/insert/products.sql
