docker exec -it -u postgres postgres-otus bash -c "pg_createcluster 16 logical_master -p 5434"
docker exec -it -u postgres postgres-otus bash -c "pg_createcluster 16 logical_replica -p 5435"

docker exec -it -u postgres postgres-otus bash -c "pg_ctlcluster 16 logical_master start"
docker exec -it -u postgres postgres-otus bash -c "pg_ctlcluster 16 logical_replica start"

docker exec -it -u postgres postgres-otus psql -p 5434 -c "ALTER SYSTEM SET wal_level = logical;"
docker exec -it -u postgres postgres-otus psql -p 5435 -c "ALTER SYSTEM SET wal_level = replica;"

docker exec -it -u postgres postgres-otus bash -c "pg_ctlcluster 16 logical_master restart"
docker exec -it -u postgres postgres-otus bash -c "pg_ctlcluster 16 logical_replica restart"

docker exec -it -u postgres postgres-otus psql -p 5434 -c "ALTER USER postgres WITH PASSWORD 'pass';"
docker exec -it -u postgres postgres-otus psql -p 5434 -c "CREATE DATABASE logical_misc_db;"
docker exec -it -u postgres postgres-otus psql -p 5434 -d logical_misc_db -c "CREATE TABLE logical_misc (data int);"
docker exec -it -u postgres postgres-otus psql -p 5434 -d logical_misc_db -c "INSERT INTO logical_misc VALUES(0);"
docker exec -it -u postgres postgres-otus psql -p 5434 -d logical_misc_db -c "CREATE PUBLICATION logical_misc_pub FOR TABLE logical_misc;"

docker exec -it -u postgres postgres-otus psql -p 5435 -c "CREATE DATABASE logical_misc_db;"
docker exec -it -u postgres postgres-otus psql -p 5435 -d logical_misc_db -c "CREATE TABLE logical_misc (data int);"


echo ""
echo ""
echo "BEFORE LOGIC REPLICA"
echo "CLUSTER --- 5434 ----"
docker exec -it -u postgres postgres-otus psql -p 5434 -d logical_misc_db -c "SELECT * FROM logical_misc;"
echo "CLUSTER --- ---- ----"

echo "CLUSTER --- 5435 ----"
docker exec -it -u postgres postgres-otus psql -p 5435 -d logical_misc_db -c "SELECT * FROM logical_misc;"
echo "CLUSTER --- ---- ----"
echo ""
echo ""

docker cp ./subscribe.sql postgres-otus:/subscribe.sql
docker exec -it -u root postgres-otus chmod 777 /subscribe.sql
docker exec -it -u postgres postgres-otus psql -p 5435 -d logical_misc_db -f /subscribe.sql

echo ""
echo ""
echo "AFTER LOGIC REPLICA"
echo "CLUSTER --- 5434 ----"
docker exec -it -u postgres postgres-otus psql -p 5434 -d logical_misc_db -c "SELECT * FROM logical_misc;"
echo "CLUSTER --- ---- ----"

echo "CLUSTER --- 5435 ----"
docker exec -it -u postgres postgres-otus psql -p 5435 -d logical_misc_db -c "SELECT * FROM logical_misc;"
echo "CLUSTER --- ---- ----"
echo ""
echo ""