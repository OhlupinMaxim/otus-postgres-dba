rm -rf /var/lib/postgresql/16/replica/*
pg_basebackup -h 127.0.0.1 -R -D /var/lib/postgresql/16/replica