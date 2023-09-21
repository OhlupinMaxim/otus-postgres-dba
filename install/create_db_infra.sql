CREATE USER otus_user WITH ENCRYPTED PASSWORD 'pass';
GRANT ALL PRIVILEGES ON DATABASE otus_lessons TO otus_user;
CREATE DATABASE otus_lessons;
\c otus_lessons;
CREATE SCHEMA otus;

