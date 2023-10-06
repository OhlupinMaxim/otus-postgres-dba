set search_path = sb_crm_schema;

COPY product (name, article, manufacturer) FROM '/sb_crm_dml/copy/product.csv' DELIMITERS ',' CSV QUOTE '''';