DO $$
BEGIN
IF NOT EXISTS (SELECT usename FROM pg_catalog.pg_user WHERE  usename = 'sb_crm_user') THEN
CREATE USER sb_crm_user WITH ENCRYPTED PASSWORD 'anypass';
END IF;
END $$;

CREATE TABLESPACE sb_crm_tablespace OWNER sb_crm_user LOCATION '/sb_crm/data';

SELECT 'CREATE DATABASE sb_crm WITH OWNER sb_crm_user;' 
	WHERE NOT EXISTS (SELECT datname FROM pg_catalog.pg_database WHERE datname='sb_crm')\gexec
GRANT ALL PRIVILEGES ON DATABASE sb_crm TO sb_crm_user;

\c sb_crm
CREATE SCHEMA IF NOT EXISTS sb_crm_schema AUTHORIZATION sb_crm_user;
GRANT ALL PRIVILEGES ON SCHEMA sb_crm_schema TO sb_crm_user;