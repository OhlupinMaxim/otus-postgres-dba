set search_path = sb_crm_schema;

DROP INDEX idx_product_name;
DROP INDEX idx_shop_point_products_count_products;
DROP INDEX idx_work_shift_fk_staff_fk_shop_point;
DROP INDEX idx_amount_products_fk_work_shift_fk_product_fk_product_unit;

ANALYZE product, shop_point_product, shop_point;

-- EXPLAIN запроса без индексов

-- EXPLAIN ANALYZE select name from product where name ilike '%v.11.0.%';

-- EXPLAIN ANALYZE select p.name, sp.name 
-- from shop_point_product as spp
-- INNER JOIN shop_point AS sp
--     ON spp.fk_shop_point=sp.id
-- INNER JOIN product AS p
--     ON spp.fk_product=p.id
-- WHERE spp.count_products < 18;

EXPLAIN ANALYZE select st.username, ws.date_shift, sp.name
FROM work_shift as ws
INNER JOIN staff as st
	ON ws.fk_staff=st.id
INNER JOIN shop_point as sp
	ON sp.id=ws.fk_shop_point;

CREATE INDEX idx_amount_products_fk_work_shift_fk_product_fk_product_unit ON sb_crm_schema.Amount_Product (
	fk_work_shift, fk_product, fk_product_unit
);

CREATE INDEX idx_work_shift_fk_staff_fk_shop_point ON sb_crm_schema.Work_Shift (
	fk_staff, fk_shop_point
);

CREATE INDEX idx_product_name ON product USING gist (name gist_trgm_ops);
CREATE INDEX idx_shop_point_products_count_products ON shop_point_product USING btree (count_products) WHERE count_products < 20;


-- EXPLAIN запросов с индексами

-- EXPLAIN ANALYZE select name from product where name ilike '%v.11.0.%';

-- EXPLAIN ANALYZE select p.name, sp.name 
-- from shop_point_product as spp
-- INNER JOIN shop_point AS sp
--     ON spp.fk_shop_point=sp.id
-- INNER JOIN product AS p
--     ON spp.fk_product=p.id
-- WHERE spp.count_products < 18;

EXPLAIN ANALYZE select st.username, ws.date_shift, sp.name
FROM work_shift as ws
INNER JOIN staff as st
	ON ws.fk_staff=st.id
INNER JOIN shop_point as sp
	ON sp.id=ws.fk_shop_point;