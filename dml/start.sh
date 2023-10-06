docker exec -it -u root postgres-otus mkdir sb_crm_dml
docker cp ./insert/ postgres-otus:/sb_crm_dml
docker cp ./actions/ postgres-otus:/sb_crm_dml
docker cp ./copy/ postgres-otus:/sb_crm_dml
docker exec -it -u root postgres-otus chown -R postgres:postgres sb_crm_dml
docker exec -it -u postgres postgres-otus psql -U sb_crm_user -d sb_crm -f sb_crm_dml/insert/products.sql
docker exec -it -u postgres postgres-otus psql -U sb_crm_user -d sb_crm -f sb_crm_dml/copy/copy.sql
docker exec -it -u postgres postgres-otus psql -U sb_crm_user -d sb_crm -f sb_crm_dml/insert/shop_point_shop_point_product.sql
docker exec -it -u postgres postgres-otus psql -U sb_crm_user -d sb_crm -f sb_crm_dml/actions/products.sql
