set search_path = sb_crm_schema;

COPY product (name, article, manufacturer) FROM '/sb_crm_dml/copy/products.csv' DELIMITERS ',' CSV QUOTE '''';
COPY staff (username, password, staff_full_name, is_master_staff) FROM '/sb_crm_dml/copy/staff.csv' DELIMITERS ',' CSV QUOTE '''';
COPY work_shift (fk_staff, fk_shop_point, date_shift, is_close, profit, expenses) FROM '/sb_crm_dml/copy/shift.csv' DELIMITERS ',' CSV QUOTE '''';