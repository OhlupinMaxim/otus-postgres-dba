CREATE USER otus_user WITH ENCRYPTED PASSWORD 'pass';
CREATE DATABASE otus_lessons;
GRANT ALL PRIVILEGES ON DATABASE otus_lessons TO otus_user;
\c otus_lessons;
CREATE SCHEMA otus;

