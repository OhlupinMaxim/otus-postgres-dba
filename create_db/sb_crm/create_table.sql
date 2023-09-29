\c sb_crm
set search_path = sb_crm_schema;

CREATE TABLE sb_crm_schema.Staff (
	id INTEGER PRIMARY KEY,
	username varchar(64) NOT NULL CHECK (username != ''),
	password varchar(64) NOT NULL CHECK (password != ''),
	staff_full_name varchar(64) NOT NULL CHECK (staff_full_name != ''),
	is_master_staff boolean NOT NULL
);

CREATE TABLE sb_crm_schema.Product (
	id INTEGER PRIMARY KEY,
	name varchar(64) NOT NULL CHECK (name != ''),
	article INTEGER NOT NULL UNIQUE CHECK (article > 0),
	manufacturer varchar(256)
);

CREATE TABLE sb_crm_schema.Product_Unit (
	id INTEGER PRIMARY KEY,
	fk_product INTEGER NOT NULL,
	unit varchar(8) NOT NULL CHECK (unit != ''),
	price_per_unit REAL NOT NULL CHECK (price_per_unit > 0)
);

CREATE TABLE sb_crm_schema.Shop_Point (
	id INTEGER PRIMARY KEY,
	name varchar(64) NOT NULL UNIQUE CHECK (name != ''),
	address varchar(64) NOT NULL UNIQUE CHECK (address != '')
);

CREATE TABLE sb_crm_schema.Warehouse (
	id INTEGER PRIMARY KEY,
	oto_shop_point INTEGER UNIQUE NOT NULL,
	FOREIGN KEY (oto_shop_point) REFERENCES sb_crm_schema.Shop_Point(id)
);


CREATE TABLE sb_crm_schema.Product_Warehouse(
	id INTEGER PRIMARY KEY,
	fk_product INTEGER NOT NULL,
	fk_warehouse INTEGER NOT NULL,
	FOREIGN KEY (fk_product) REFERENCES sb_crm_schema.Product(id),
	FOREIGN KEY (fk_warehouse) REFERENCES sb_crm_schema.Warehouse(id)
);

CREATE TABLE sb_crm_schema.Work_Shift (
	id INTEGER PRIMARY KEY,
	fk_staff INTEGER NOT NULL,
	fk_shop_point INTEGER NOT NULL,
	date_shift DATE DEFAULT now(),
	is_close BOOLEAN DEFAULT False,
	profit REAL DEFAULT 0.0 CHECK (profit >= 0),
	expenses REAL DEFAULT 0.0 CHECK (expenses >= 0),
	FOREIGN KEY (fk_staff) REFERENCES sb_crm_schema.Staff(id),
	FOREIGN KEY (fk_shop_point) REFERENCES sb_crm_schema.Shop_Point(id)
);

CREATE TABLE sb_crm_schema.Amount_Product (
	id INTEGER PRIMARY KEY,
	fk_work_shift INTEGER NOT NULL,
	fk_product INTEGER NOT NULL,
	fk_product_unit INTEGER NOT NULL,
	number_of_sold INTEGER CHECK (number_of_sold > 0),
	FOREIGN KEY (fk_work_shift) REFERENCES sb_crm_schema.Work_Shift(id),
	FOREIGN KEY (fk_product) REFERENCES sb_crm_schema.Product(id),
	FOREIGN KEY (fk_product_unit) REFERENCES sb_crm_schema.Product_Unit(id)
);