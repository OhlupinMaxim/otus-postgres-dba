set search_path = sb_crm_schema;

delete from shop_point_product;
delete from product;

INSERT INTO
    product (name, article, manufacturer)
VALUES
    ('Пшено', 1, 'any'),
    ('Овес', 12, 'any'),
    ('Сено', 13, 'any'),
    ('Греча', 14, 'any'),
    ('Полба', 15, 'any'),
    ('Корм для птиц', 16, 'any'),
    ('Корм для мелокго скота', 17, 'any'),
    ('Корм для крупного скота', 18, 'any'),
    ('Биотопливо v.15.35.16', 19, 'any'),
    ('Дрова (Сосна)', 21, 'any'),
    ('Дрова (Береза)', 22, 'any'),
    ('Дрова (Дуб)', 23, 'any');