-- Input Files: https://drive.google.com/drive/folders/10s_vuLErQX79TX7s1j6ZEDBjJjHO7Ytz?usp=sharing

-- - Create a new database (Resource link: https://www.youtube.com/watch?v=IugEHi_5kMA)
create database ecommerce;



-- - Create a schema in it
create schema ecom_schema;

-- - Create tables for the provided csvs by understanding the data in the csvs. Use correct data type for each column

-- First, create a custom data type (enum) with multiple options
CREATE TYPE ecommerce.ecom_schema.status_options AS ENUM ('Active', 'Inactive', 'InActive', 'Blacklisted', 
'Out of Stock', 'Pending', 'Shipped', 'Delivered', 'Completed', 'Cancelled');


-- add more if needed
ALTER TYPE ecom_schema."status_options" ADD VALUE 'Out of Stock';

-- ecom_schema.categories definition
-- Drop table
-- DROP TABLE ecom_schema.categories;
CREATE TABLE ecom_schema.categories (
	category_id varchar(36) NOT NULL,
	"name" varchar(255) NOT NULL,
	status ecom_schema."status_options" NOT NULL,
	description text NOT NULL,
	CONSTRAINT categories_pkey PRIMARY KEY (category_id)
);

-- ecom_schema.customers definition
-- Drop table
-- DROP TABLE ecom_schema.customers;
CREATE TABLE ecom_schema.customers (
	customer_id varchar(36) NOT NULL,
	"name" varchar(255) NOT NULL,
	phone varchar(255) NOT NULL,
	"location" varchar(255) NOT NULL,
	status ecom_schema."status_options" NOT NULL,
	CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
);


-- ecom_schema.suppliers definition
-- Drop table
-- DROP TABLE ecom_schema.suppliers;
CREATE TABLE ecom_schema.suppliers (
	supplier_id varchar(36) NOT NULL,
	"name" varchar(255) NOT NULL,
	phone varchar(255) NOT NULL,
	"location" varchar(255) NOT NULL,
	status ecom_schema."status_options" NOT NULL,
	category varchar(255) NOT NULL,
	CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id)
);


-- ecom_schema.products definition
-- Drop table
-- DROP TABLE ecom_schema.products;
CREATE TABLE ecom_schema.products (
	product_id varchar(36) NOT NULL,
	"name" varchar(255) NOT NULL,
	supplier_id varchar(36) NOT NULL,
	category varchar(255) NOT NULL,
	price numeric(5, 2) NOT NULL,
	stock_avaialable int4 NOT NULL,
	status ecom_schema."status_options" NOT NULL,
	product_createtimestamp timestamp NOT NULL,
	CONSTRAINT products_pkey PRIMARY KEY (product_id),
	CONSTRAINT products_suppliers_fk FOREIGN KEY (supplier_id) REFERENCES ecom_schema.suppliers(supplier_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- ecom_schema.orders definition
-- Drop table
-- DROP TABLE ecom_schema.orders;
CREATE TABLE ecom_schema.orders (
	order_id varchar(36) NOT NULL,
	customer_id varchar(36) NOT NULL,
	status ecom_schema."status_options" NOT NULL,
	order_timestamp timestamp NOT NULL,
	total_amount numeric(5, 2) NOT NULL,
	CONSTRAINT orders_pkey PRIMARY KEY (order_id),
	CONSTRAINT orders_customers_fk FOREIGN KEY (customer_id) REFERENCES ecom_schema.customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- ecom_schema.items definition
-- Drop table
-- DROP TABLE ecom_schema.items;
CREATE TABLE ecom_schema.items (
	item_id varchar(36) NOT NULL,
	order_id varchar(36) NOT NULL,
	product_id varchar(36) NOT NULL,
	amount numeric(4, 2) NOT NULL,
	status ecom_schema."status_options" NOT NULL,
	item_timestamp timestamp NOT NULL,
	CONSTRAINT items_pkey PRIMARY KEY (item_id),
	CONSTRAINT items_products_fk FOREIGN KEY (product_id) REFERENCES ecom_schema.products(product_id) ON DELETE CASCADE ON UPDATE cascade,
	CONSTRAINT items_orders_fk FOREIGN KEY (order_id) REFERENCES ecom_schema.orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Testing
select length('feea5f6d-b82f-4094-80e4-f4d84509b604');


-- 1. Write a query to fetch all customer names and sort them alphabetically. (Topic Soring)
select name from ecom_schema.customers
order by name
;


--2. Write a query to fetch all product names and their prices, sorted by price from low to high. (Topic Sorting)
select name, price from ecom_schema.products
order by price;

--3. Write a query to fetch supplier names that start with the letter 'A' and sort them by their names. 
--(Topic Sorting with Operators and Wildcards)
select name from ecom_schema.suppliers
where name like 'A%'
order by name;

--4. Write a query to fetch all items and sort them by their status, placing NULL values first.
select * from ecom_schema.items
order by status
;


--5. Write a query to fetch all products, sort them first by category and then by price in descending order.
select * from ecom_schema.products
order by (category, price) desc;


--6. Write a query to fetch all customer names and phone numbers, but sort them by the last four digits of their
-- phone numbers in ascending order. (Hint use sorting with substings)
select name, phone from ecom_schema.customers
order by right(phone, 4);