set search_path = sb_crm_schema;

delete from sb_crm_schema.product;

INSERT INTO
    sb_crm_schema.product (id, name, article, manufacturer)
VALUES
    (1, 'Пшено', 1, 'any'),
    (2, 'Овес', 12, 'any'),
    (3, 'Сено', 13, 'any'),
    (4, 'Греча', 14, 'any'),
    (5, 'Полба', 15, 'any'),
    (6, 'Корм для птиц', 16, 'any'),
    (7, 'Корм для мелокго скота', 17, 'any'),
    (8, 'Корм для крупного скота', 18, 'any'),
    (9, 'Биотопливо v.15.35.16', 19, 'any'),
    (10, 'Дрова (Сосна)', 21, 'any'),
    (11, 'Дрова (Береза)', 22, 'any'),
    (12, 'Дрова (Дуб)', 23, 'any');