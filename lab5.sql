-- Student: Atamuratov Nursultan
-- Student ID: 24B030987


--task 1.1
create table employees(
    employee_id int primary key,
    first_name text,
    last_name text,
    age int,
    salary numeric,
    check (age between 18 and 65 and salary > 0)
);

-- task 1.2
create table products_catalog(
    product_id int primary key,
    product_name text,
    regular_price numeric,
    discount_price numeric,
    constraint  valid_discount check (
        regular_price > 0 and
        discount_price > 0 and
        discount_price < regular_price)
);

--task 1.3
create table bookings(
    booking_id     int primary key,
    check_in_date  date,
    check_out_date date,
    num_guests     int,
    check (num_guests between 1 and 10 and check_out_date > check_in_date)
);

--task 1.4
--1
insert into employees (employee_id, first_name, last_name, age, salary) values
(1, 'Alex', 'Don', 21, 50000.00),
(2, 'Bon', 'Jaycap', 23, 75000.50);

--2
insert into employees (employee_id, first_name, last_name, age, salary) values
(3, 'Anna', 'Bella', 17, 30000.00);

--3
-- Violated constraint: CHECK (age between 18 and 65)
-- Why violated: Age (17) is less than the minimum allowed value (18).


--1
insert into products_catalog (product_id, product_name, regular_price, discount_price) values
(101, 'MacBook', 1200.00, 1000.00),
(102, 'iPad', 700.00, 50.00);

--2
insert into products_catalog (product_id, product_name, regular_price, discount_price) values
(103, 'keyboard', 50.00, 65.00);

--3
--Violated constraint: valid discount (regular price > discount_price)
--Why violated: The regular price is not greater than discount_price.


--1
insert into bookings (booking_id, check_in_date, check_out_date, num_guests) values
(201, '2023-10-26', '2023-10-30', 2),
(202, '2024-01-15', '2024-01-20', 5);

--2
insert into bookings (booking_id, check_in_date, check_out_date, num_guests) values
(203, '2023-11-01', '2023-11-05', 0);

--3
--Violated constraint: CHECK (num_guests between 1 and 10)
--Why it is violated: The number of guests (0) is less than the minimum allowed value(1).




--task2.1
create table customers(
    customer_id int primary key not null,
    email text not null,
    phone text,
    registration_date date not null
);

--task2.2
create table inventory(
    item_id int primary key not null,
    item_name text not null,
    quantity int not null check(quantity >= 0),
    unit_price numeric not null check (unit_price >= 0),
    last_updated timestamp not null
);

--task2.3
--1
insert into customers (customer_id, email, phone, registration_date) values
(1, 'alice@example.com', '123-456-7890', '2023-01-10'),
(2, 'bob@example.com', '987-654-3210', '2023-02-15');
insert into inventory (item_id, item_name, quantity, unit_price, last_updated) values
(101, 'Книга "Основы SQL"', 50, 25.50, '2023-10-25 10:00:00'),
(102, 'Ручка шариковая', 200, 1.20, '2023-10-25 10:05:00');

--2
insert into customers (customer_id, email, phone, registration_date) values
(25, null, '555-111-2222', '2023-03-20');
insert into inventory (item_id, item_name, quantity, unit_price, last_updated) values
(12, null, 100, 3.00, '2023-10-25 10:10:00');

--3
-- Пример, если бы был столбец description_text (nullable)
-- INSERT INTO inventory (item_id, item_name, quantity, unit_price, last_updated, description) VALUES
-- (107, 'Files for documents', 150, 0.10, '2023-10-25 10:30:00', NULL);




--task3.1
create table users(
    user_id int,
    username text unique,
    email text unique,
    created_at timestamp
);

--task3.2
create table course_enrollments(
    enrollment_id int,
    student_id int,
    course_code text,
    semester text,
    constraint uq unique (student_id, course_code, semester)
);

--task3.3
alter table users
add constraint unique_username unique (username),
add constraint unique_email unique (email);

insert into Users (user_id, username, Email, created_at) VALUES
(1, 'ivan_p', 'ivan@example.com', '2023-10-26 10:15:00'),
(2, 'maria_s', 'maria@example.com', '2023-10-26 10:20:00');

INSERT INTO Users (user_id, Username, Email, created_at) VALUES
(3, 'john_d', 'ivan@example.com', '2023-10-26 10:25:00');
-- Error! Email 'ivan@example.com' already exists




--task4.1
create table departments(
    dept_id int primary key,
    dept_name text not null,
    location text
);
insert into departments(dept_id, dept_name, location) values
(01, 'Sales', 'Seol'),
(02, 'Marketing', 'Paris'),
(03, 'Development', 'Singapore');
-- insert into departments (dept_id, dept_name, location) values
-- (101, 'Security', 'Seattle'),
-- (null, 'Security', 'Seattle');

--task4.2
create table student_courses(
    student_id int,
    course_id int,
    enrollment_date date,
    grade text,
    primary key (student_id, course_id)
);

-- Task4.3: Comparison (document in comments)
-- UNIQUE vs PRIMARY KEY:
-- * Both enforce uniqueness.
-- * PRIMARY KEY also implies NOT NULL and identifies the row; table can have only one PRIMARY KEY.
-- * A table may have multiple UNIQUE constraints, but only one PRIMARY KEY.
-- When to use single vs composite PK:
-- * Single-column PK when one natural/key column identifies rows (e.g., dept_id).
-- * Composite PK when the combination uniquely identifies rows (e.g., student_id+course_id).
-- Why only one PK but many UNIQUE:
-- * The PK is the table’s canonical identifier; databases allow only one such identifier.
-- * UNIQUE just enforces additional uniqueness rules on other columns/combos.




--task5.1
CREATE TABLE employees_dept(
    emp_id int primary key,
    emp_name text NOT NULL,
    dept_id int,
    hire_date date,
    CONSTRAINT FK_EmployeeDept
        FOREIGN KEY (dept_id)
        REFERENCES departments (dept_id)
);

INSERT INTO employees_dept (emp_id, emp_name, dept_id, hire_date) VALUES
(1, 'John Maks', 1, '2022-03-01'), -- works in sales
(2, 'Vladimir Don', 2, '2021-07-15'), -- works in marketing
(3, 'Alex Steve', 1, '2023-01-10'); -- worls in sales
-- INSERT INTO employees_dept (emp_id, emp_name, dept_id, hire_date) VALUES
-- (4, 'Oleg Koffi', 105, '2023-05-20'); -- Отдела 105 не существует


--task5.2
--table: authors
CREATE TABLE authors (
    author_id integer PRIMARY KEY,
    author_name text NOT NULL,
    country text
);

--table: publishers
CREATE TABLE publishers (
    publisher_id integer PRIMARY KEY,
    publisher_name text NOT NULL,
    city text
);

--table: books (с двумя внешними ключами)
CREATE TABLE books (
    book_id integer PRIMARY KEY,
    title text NOT NULL,
    author_id integer,
    publisher_id integer,
    publication_year integer,
    isbn text UNIQUE, -- ISBN должен быть уникальным
    CONSTRAINT FK_BookAuthor
        FOREIGN KEY (author_id)
        REFERENCES authors (author_id),
    CONSTRAINT FK_BookPublisher
        FOREIGN KEY (publisher_id)
        REFERENCES publishers (publisher_id)
);

INSERT INTO authors (author_id, author_name, country) VALUES
(1, 'Лев Толстой', 'Россия'),
(2, 'Джейн Остин', 'Великобритания'),
(3, 'Джордж Оруэлл', 'Великобритания');

INSERT INTO publishers (publisher_id, publisher_name, city) VALUES
(10, 'Эксмо', 'Москва'),
(11, 'Penguin Books', 'Лондон'),
(12, 'АСТ', 'Москва');

INSERT INTO books (book_id, title, author_id, publisher_id, publication_year, isbn) VALUES
(1001, 'Война и мир', 1, 10, 1869, '978-5-04-099493-2'),
(1002, 'Гордость и предубеждение', 2, 11, 1813, '978-0-14-143951-8'),
(1003, '1984', 3, 11, 1949, '978-0-452-28423-4'),
(1004, 'Анна Каренина', 1, 12, 1877, '978-5-17-080352-7');


--task5.3
-- Таблица: categories (Родительская для products_fk)
CREATE TABLE categories (
    category_id integer PRIMARY KEY,
    category_name text NOT NULL
);

-- Таблица: products_fk (Дочерняя для categories, ON DELETE RESTRICT)
CREATE TABLE products_fk (
    product_id integer PRIMARY KEY,
    product_name text NOT NULL,
    category_id integer,
    CONSTRAINT FK_ProductCategory
        FOREIGN KEY (category_id)
        REFERENCES categories (category_id)
        ON DELETE RESTRICT -- Не позволит удалить категорию, если к ней привязаны товары
);

-- Таблица: orders (Родительская для order_items)
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    order_date date NOT NULL
);

-- Таблица: order_items (Дочерняя для orders (ON DELETE CASCADE) и products_fk)
CREATE TABLE order_items (
    item_id integer PRIMARY KEY,
    order_id integer,
    product_id integer,
    quantity integer CHECK (quantity > 0),
    CONSTRAINT FK_ItemOrder
        FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
        ON DELETE CASCADE, -- При удалении заказа, все его позиции также удалятся
    CONSTRAINT FK_ItemProduct
        FOREIGN KEY (product_id)
        REFERENCES products_fk (product_id)
        -- По умолчанию ON DELETE RESTRICT/NO ACTION, если явно не указано
);


INSERT INTO categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Clothes'),
(3, 'Books');

INSERT INTO products_fk (product_id, product_name, category_id) VALUES
(101, 'Smartphone', 1),
(102, 'Hoodie', 2),
(103, 'iPad', 1);

INSERT INTO orders (order_id, order_date) VALUES
(1001, '2023-10-20'),
(1002, '2023-10-21');

INSERT INTO order_items (item_id, order_id, product_id, quantity) VALUES
(1, 1001, 101, 1),  -- smartphone
(2, 1001, 102, 2),  -- hoodie
(3, 1002, 103, 1);  -- iPad

-- Scenario 1: Try to delete a category that has products (should fail)
-- DELETE FROM categories WHERE category_id = 1;
--   -- EXPECT: ERROR (RESTRICT) because products_fk rows reference category 1

-- Scenario 2: Delete an order and see items auto-deleted
-- SELECT COUNT(*) AS before_items FROM order_items WHERE order_id=1001;
-- DELETE FROM orders WHERE order_id=1001;            -- CASCADE to order_items
-- SELECT COUNT(*) AS after_items  FROM order_items WHERE order_id=1001;
--   -- EXPECT: before_items=2, after_items=0





--task6.1
-- Таблица 1: customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    registration_date DATE NOT NULL
);

-- Таблица 2: products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0)
);

-- Таблица 3: orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC CHECK (total_amount >= 0),
    status TEXT NOT NULL CHECK (status IN (
                                            'pending',
                                           'processing',
                                           'shipped',
                                           'delivered',
                                           'cancelled')),
    CONSTRAINT FK_OrderCustomer
        FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
        ON DELETE RESTRICT                     -- Нельзя удалить клиента, если у него есть заказы
);

-- Таблица 4: order_details
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC NOT NULL CHECK (unit_price >= 0),

    CONSTRAINT FK_DetailOrder
        FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
        ON DELETE CASCADE,                     -- При удалении заказа, все его детали также удаляются

    CONSTRAINT FK_DetailProduct
        FOREIGN KEY (product_id)
        REFERENCES products (product_id)
        ON DELETE RESTRICT                     -- Нельзя удалить продукт, если он есть в каком-либо заказе
);

-- Data for customers
INSERT INTO customers (customer_id, name, email, phone, registration_date) VALUES
(1, 'John Doe', 'john.doe@example.com', '111-222-3333', '2023-01-10'),
(2, 'Jane Smith', 'jane.smith@example.com', '444-555-6666', '2023-01-15'),
(3, 'Robert Johnson', 'robert.j@example.com', NULL, '2023-02-01'),
(4, 'Emily White', 'emily.w@example.com', '777-888-9999', '2023-02-20'),
(5, 'David Brown', 'david.b@example.com', '000-111-2222', '2023-03-05');

-- Data for products
INSERT INTO products (product_id, name, description, price, stock_quantity) VALUES
(101, 'HP Laptop', 'Powerful laptop for work and gaming', 1200.00, 50),
(102, 'Logitech Wireless Mouse', 'Ergonomic and responsive mouse', 25.00, 200),
(103, 'Mechanical Keyboard', 'Gaming keyboard with RGB lighting', 80.00, 75),
(104, 'Dell 27" 4K Monitor', 'Ultra HD display for professionals', 450.00, 30),
(105, 'Full HD Webcam', 'High-quality camera for video calls', 40.00, 150);

-- Data for orders
INSERT INTO orders (order_id, customer_id, order_date, total_amount, status) VALUES
(1001, 1, '2023-10-25', 1225.00, 'shipped'),
(1002, 2, '2023-10-26', 80.00, 'pending'),
(1003, 1, '2023-10-26', 490.00, 'processing'),
(1004, 3, '2023-10-27', 40.00, 'delivered'),
(1005, 5, '2023-10-28', 1200.00, 'cancelled');

-- Data for order_details
INSERT INTO order_details (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 101, 1, 1200.00), -- 1x HP Laptop for Order 1001
(2, 1001, 102, 1, 25.00),   -- 1x Logitech Mouse for Order 1001
(3, 1002, 103, 1, 80.00),   -- 1x Mechanical Keyboard for Order 1002
(4, 1003, 104, 1, 450.00),  -- 1x Dell Monitor for Order 1003
(5, 1003, 102, 1, 25.00),   -- 1x Logitech Mouse for Order 1003
(6, 1004, 105, 1, 40.00),   -- 1x Full HD Webcam for Order 1004
(7, 1005, 101, 1, 1200.00); -- 1x HP Laptop for Order 1005


/*
-- === Test PRIMARY KEY Constraints (for customers) ===

-- Attempt to insert a customer with an existing customer_id = 1
-- EXPECT: ERROR (PRIMARY KEY violation - uniqueness)
-- INSERT INTO customers (customer_id, name, email, phone, registration_date) VALUES
-- (1, 'Duplicate ID Customer', 'duplicate.id@example.com', NULL, '2023-04-01');

-- Attempt to insert a customer with NULL in customer_id
-- EXPECT: ERROR (PRIMARY KEY violation - NOT NULL)
-- INSERT INTO customers (customer_id, name, email, phone, registration_date) VALUES
-- (NULL, 'Null ID Customer', 'null.id@example.com', NULL, '2023-04-02');


-- === Test NOT NULL Constraints (for customers) ===

-- Attempt to insert a customer with NULL in 'name'
-- EXPECT: ERROR (NOT NULL violation for 'name')
-- INSERT INTO customers (customer_id, name, email, phone, registration_date) VALUES
-- (6, NULL, 'noname@example.com', NULL, '2023-04-03');

-- Attempt to insert a customer with NULL in 'email'
-- EXPECT: ERROR (NOT NULL violation for 'email')
-- INSERT INTO customers (customer_id, name, email, phone, registration_date) VALUES
-- (7, 'Test Null Email', NULL, NULL, '2023-04-04');


-- === Test UNIQUE Constraint (for customers.email) ===

-- Attempt to insert a customer with an existing email 'john.doe@example.com'
-- EXPECT: ERROR (UNIQUE violation for 'email')
-- INSERT INTO customers (customer_id, name, email, phone, registration_date) VALUES
-- (8, 'John Doe Duplicate', 'john.doe@example.com', NULL, '2023-04-05');


-- === Test CHECK Constraints (for products and orders) ===

-- Attempt to insert a product with a negative price
-- EXPECT: ERROR (CHECK constraint violation - price >= 0)
-- INSERT INTO products (product_id, name, description, price, stock_quantity) VALUES
-- (106, 'Product with negative price', NULL, -10.00, 10);

-- Attempt to insert a product with a negative stock_quantity
-- EXPECT: ERROR (CHECK constraint violation - stock_quantity >= 0)
-- INSERT INTO products (product_id, name, description, price, stock_quantity) VALUES
-- (107, 'Product with negative stock', NULL, 100.00, -5);

-- Attempt to insert an order with an invalid status
-- EXPECT: ERROR (CHECK constraint violation - status IN (...))
-- INSERT INTO orders (order_id, customer_id, order_date, total_amount, status) VALUES
-- (1006, 1, '2023-10-29', 50.00, 'invalid_status');

-- Attempt to insert an order detail with quantity 0 or negative
-- EXPECT: ERROR (CHECK constraint violation - quantity > 0)
-- INSERT INTO order_details (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
-- (8, 1001, 101, 0, 1200.00);


-- === Test FOREIGN KEY Constraints (and ON DELETE behavior) ===

-- Test FK_OrderCustomer with ON DELETE RESTRICT (attempt to delete a customer with existing orders)
-- Attempt to delete customer 1, who has orders (1001, 1003)
-- EXPECT: ERROR (FOREIGN KEY violation - ON DELETE RESTRICT)
-- (To delete customer 1, you must first delete all their orders.)
-- DELETE FROM customers WHERE customer_id = 1;

-- Test FK_DetailOrder with ON DELETE CASCADE (deleting an order automatically deletes its details)
-- 1. Check details for order 1001 (should be 2 records)
-- SELECT COUNT(*) FROM order_details WHERE order_id = 1001; -- EXPECT: 2

-- 2. Delete order 1001
-- DELETE FROM orders WHERE order_id = 1001;

-- 3. Check details for order 1001 after deletion
-- SELECT COUNT(*) FROM order_details WHERE order_id = 1001; -- EXPECT: 0
-- EXPECT: Order deletion successful, and 2 order details were automatically deleted.

-- Test FK_DetailProduct with ON DELETE RESTRICT (attempt to delete a product present in an order)
-- (Note: Order 1001 might have been deleted in the previous test, but product 101 is still in order_details for order 1005)
-- Attempt to delete product 101 ('HP Laptop'), which is in order 1005.
-- EXPECT: ERROR (FOREIGN KEY violation - ON DELETE RESTRICT)
-- (To delete product 101, you must first delete all order_details that contain it.)
-- DELETE FROM products WHERE product_id = 101;
*/
