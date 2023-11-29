docker exec -it -u root postgres-otus bash -c "apt update && apt update -y && apt -y install cron"
docker exec -it -u postgres postgres-otus bash -c "pg_createcluster 16 replica"
docker cp ./cron_pg_replica.sh postgres-otus:/cron_pg_replica.sh
docker exec -it -u root postgres-otus bash -c "chmod 777 cron_pg_replica.sh"  
docker exec -it -u postgres postgres-otus bash -c "crontab -l | { cat; echo '*/5 * * * * bash /cron_pg_replica.sh'; } | crontab -"
docker exec -it -u root postgres-otus cron
