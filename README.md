### OTUS DB HW 1
### __Проект базы данных для Индивидуальных предпринимателей__

### Пример использования БД
```
Данная база данных может быть использована
в проектах для решения задач малаго бизнеса (Индивидуальных Предпринимателей).
- Небольшие магазины (8-10 точек по городу).
- Для предпринимателей занимающихся торговлей узкоспециализированного товара (Например корма для рептилий).

То есть это бизнес который имеет малый сбыт в рамках одного города.
Есть сервисы CRM по типу "Мой склад", но не каждый предприниматель готов решиться на покупку подобного сервиса.
При том что большинство из них сами не представляют зачем им это нужно.

Такие предприниматели используют таблицы-Excell как базы данных для своих расчетов. Ведут реальный Гроссбух.

Чаще всего они либо самостоятельно, либо с помощью ответственного человека
ведут учет и редактируют данных.

Однако используя данную БД в сумме с небольшим веб-приложением,
расчитанным на внутренее использование (Только для сотрудников),
у препринимателя появляется ряд полезных навыков,
что в последствии может обеспечить рост прибыли.

Среди них:
- удобное ведение статистики
- автоматический расчет прибыли\расхода по точкам
- безопасное сохранение данных
- статус в совокупности (или по точкам), о необходимости проведения ревизии или внеплановой закупки

```

#### __Сущности__
- Пользователь (Staff)
- Товары (Product)
- Единицы измерения продажи продукта (Product_Unit)
- Точки торговли (Shop_Point)
- Склад на точке (Shop_Point_Product)
- Смены (Work_Shift)
- Кол-во проданного товара за смену (Amount_Product)


### __Индексы__
- составной индекс в сущности Amount_Products по полям (fk_work_shift, fk_product, fk_product_unit). idx_amount_products_fK_work_shift_fk_product_fk_product_unit
  Данный запрос имеет высокую кардинальность, так по каждой точке еждневно будут идти запросы в БД. (Как со стороны Предпринимателя так и со стороны сотрудника)
- составной индекс в сущности Work_Shift по полям (fk_user, fk_shop_point). idx_work_shift_fk_user_fk_shop_point
  Данный запрос в имеет высокую координальность, так как его выполнение неободимо составления статистики и последующего анализа.


### __Диаграмма__
![OTUS DB HW 1](./images/OTUS_DB_HW_1.drawio.png)

### __Описание сущностей__

##### Пользователь (Staff)
- id - тип integer - __первичный ключ__
  - PK
- username - тип varchar(64) - __имя пользователя (login сотрудника или владельца предприятия)__
  - Not Null
  - Check != ''
- password - тип varchar(64) - __пароль__
  - Not Null
  - Check != ''
- staff_full_name - тип varchar(64) - __ФИО__
- is_master_staff - тип boolean - __имеет ли данный пользователь привилегии__
  - Not Null

##### Товары (Product)
- id - тип integer - __первичный ключ__
  - PK
- name - тип varchar(256) - __Наименование товара__
  - Not Null
  - Check != ''
- article - тип integer - __Артикул__
  - Not Null
  - Unique
  - Check > 0
- manufacturer - тип varchar(256) - __Производитель__


##### Единицы измерения продажи продукта (Product_Unit)
- id - тип integer - __первичный ключ__
  - PK
- fk_product - тип real - __внешний ключ на товар__
  - Not Null
  - FK (Product)
- unit - тип varchar(8) - __единица измерения__
  - NOT Null
  - Check != ''
- price_per_unit - тип real - __цена за единицу товара__
  - NOT Null
  - Check > 0

##### Точки торговли (Shop_Point)
- id - тип integer - __первичный ключ__
  - PK
- name - тип varchar(128) - __Короткое наименование точки торговли__ (Например На Павелецкой)
  - Check != ''
  - Unique
  - Not Null
- address - тип varchar(256) - __Полный адрес точки торговли__
  - Check != ''
  - Unique
  - Not Null

#### Склад в точке (Shop_Point_Product)
- id - тип integer - __первичный ключ__
  - PK
- fk_shop_point - тип integer - __идентфикатор точки__
  - NOT NULL
  - FK
- fk_product - тип integer - __идентфикатор точки__
  - NOT NULL
  - FK
- count_products - тип integer - __кол-во единиц товара__

##### Смены (Work_Shift)
- id - тип integer - __первичный ключ__
  - PK
- fk_staff - тип integer - __Идентификатор сотрудника работающего в эту смену__
  - Not Null
  - FK (User)
- fk_shop_point - тип integer - __Идентификатор точки торговли__
  - Not Null
  - FK (Shop_Point)
- date_shift - тип date - __Дата открытия смены__
  - Not Null
- is_close - тип boolean - __Закрыта ли смена__
  - Not Null
- profit - тип real - __Прибыль__
  - Default (0.0)
  - Check >= 0
- expenses - тип real - __Расходы__
  - Default (0.0)
  - Check >= 0

##### Кол-во проданного товара за смену (Amount_Product)
- id - тип integer - __первичный ключ__
  - PK
- fk_work_shift - тип integer - __Идентификатор смены__
  - Not Null
  - FK (Work_Shift)
- fk_product_unit - тип integer - __Идентификатор единицы измерения проданного товара__
  - Not Null
  - FK (Product_Unit)
- number_of_sold - тип integer - __Кол-во товара проданного товара__
  - Not Null
  - Check > 0
