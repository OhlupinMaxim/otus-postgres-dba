set search_path = sb_crm_schema;

delete from shop_point_product;
delete from shop_point;

-- Добавляем товары во все точки с рандомным количеством и выводим иднтификатор товара и кол-во.
INSERT INTO
    shop_point (name, address)
VALUES
    ('На Павелецкой', 'г. Москва, ул. Павелецкая, д.23'),
    ('На Каланчевской',  'г. Москва, ул. Каланчевская, д.23'),
    ('Аннино',  'г. Москва, ул. Аннино, д.23'),
    ('Баумана',  'г. Москва, ул. Баумана, д.23'),
    ('Бульвар Донснкого',  'г. Москва, ул. Донского, д.23'),
    ('Ртутная',  'г. Москва, ул. Плюмбум, д.23');

INSERT INTO
    shop_point_product (fk_shop_point, fk_product, count_products)
SELECT 
    shop_point.id, product.id, floor(random()*(25-10)+10)::int
FROM shop_point, product
returning fk_product, count_products;
