set search_path = sb_crm_schema;

-- Например мы знаем что в базе все типы дров начинаются со слова дрова, а внутри скобок из чего сделаны
-- Ищем все дрова
SELECT * FROM product WHERE name ~ 'Дрова ([a-z]*)';



-- Пример использования LEFT JOIN и INNER JOIN. 
-- В контексте данной БД ответ будет одинаковый так как в таблице shop_point_product всегда есть совпадения по идентификаторам.
-- По задумке в каждой точке должнен быть обозначен каждый товар, даже если его кол-во равно нулю
SELECT 
    sp.name AS shop_point_name,
    p.name AS product_name,
    spp.count_products AS count_products
FROM 
    shop_point_product AS spp 
LEFT JOIN shop_point AS sp
    ON spp.fk_shop_point=sp.id
LEFT JOIN product AS p
    ON spp.fk_product=p.id;

SELECT 
    sp.name AS shop_point_name,
    p.name AS product_name,
    spp.count_products AS count_products
FROM 
    shop_point_product AS spp 
INNER JOIN shop_point AS sp
    ON spp.fk_shop_point=sp.id
INNER JOIN product AS p
    ON spp.fk_product=p.id;



-- Ищем все типы дров по всем точкам где их кол-во меньше 20 (Так мы узнаем в какие точки нам нужно завезти дрова)
SELECT 
    sp.name AS shop_point_name,
    p.name AS product_name,
    spp.count_products AS count_products
FROM 
    shop_point_product AS spp 
INNER JOIN shop_point AS sp
    ON spp.fk_shop_point=sp.id
INNER JOIN product AS p
    ON spp.fk_product=p.id
WHERE 
    spp.fk_product IN ( SELECT id FROM product WHERE NAME LIKE 'Дров%' ) AND
    sp.name LIKE ('На%') AND
    spp.count_products < 20;


-- Предположим мы сделали завоз товара на точку На павелецкой, обновим кол-во товаров котроых меньше 20
UPDATE shop_point_product
SET count_products = 40
FROM (
    SELECT
        spp.id, spp.count_products
    FROM 
        shop_point_product as spp
    INNER JOIN shop_point as sp
        ON spp.fk_shop_point=sp.id
    WHERE 
        sp.name='На Павелецкой' AND spp.count_products < 20
) as join_spp
WHERE join_spp.id=shop_point_product.id
returning shop_point_product.id, shop_point_product.count_products;


-- Предположим, мы разорвали сотрудничество с поставщиком, и с прилавков пропал товар. Уберем его на всех точках
DELETE FROM shop_point_product
USING product
WHERE product.id = shop_point_product.fk_product and product.manufacturer='Lucoil'
returning shop_point_product.*, product.*;