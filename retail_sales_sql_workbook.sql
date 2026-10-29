

-- ALL SQL PRACTICE 

-- RETAIL SALES SQL PRACTICE WORKBOOK
-- Compatible with MySQL 8+
-- Run this script in your SQL editor.

CREATE DATABASE IF NOT EXISTS retail_sales_practice;
USE retail_sales_practice;

-- Drop child table first, then parent tables, so the script can be rerun.
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    sale_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    CONSTRAINT fk_sales_product FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Amit', 'Pune'),
(2, 'Priya', 'Mumbai'),
(3, 'Rahul', 'Nagpur'),
(4, 'Sneha', 'Pune'),
(5, 'Neha', 'Nashik'),
(6, 'Karan', 'Mumbai'),
(7, 'Pooja', 'Pune'),
(8, 'Rohan', 'Nagpur'),
(9, 'Anjali', 'Nashik'),
(10, 'Vijay', 'Mumbai'),
(11, 'Meera', 'Pune'),
(12, 'Arjun', 'Aurangabad');

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Mobile', 'Electronics', 20000),
(103, 'Headphones', 'Electronics', 2000),
(104, 'T-Shirt', 'Clothing', 800),
(105, 'Jeans', 'Clothing', 1500),
(106, 'Shoes', 'Footwear', 2500),
(107, 'Watch', 'Accessories', 3000),
(108, 'Keyboard', 'Electronics', 1200);

INSERT INTO sales
(order_id, customer_id, product_id, quantity, unit_price, sale_date, status)
VALUES
(1001, 1, 101, 1, 50000, '2025-01-05', 'Completed'),
(1002, 2, 102, 2, 20000, '2025-01-08', 'Completed'),
(1003, 3, 103, 3, 2000, '2025-01-12', 'Completed'),
(1004, 1, 104, 4, 800, '2025-01-15', 'Completed'),
(1005, 4, 105, 2, 1500, '2025-02-02', 'Pending'),
(1006, 5, 106, 1, 2500, '2025-02-05', 'Completed'),
(1007, 6, 101, 1, 50000, '2025-02-10', 'Completed'),
(1008, 7, 107, 2, 3000, '2025-02-14', 'Cancelled'),
(1009, 2, 103, 5, 2000, '2025-02-18', 'Completed'),
(1010, 8, 102, 1, 20000, '2025-03-01', 'Completed'),
(1011, 9, 104, 3, 800, '2025-03-04', 'Completed'),
(1012, 3, 106, 2, 2500, '2025-03-08', 'Pending'),
(1013, 10, 105, 4, 1500, '2025-03-12', 'Completed'),
(1014, 1, 107, 1, 3000, '2025-03-15', 'Completed'),
(1015, 4, 102, 2, 20000, '2025-04-02', 'Completed'),
(1016, 5, 103, 2, 2000, '2025-04-05', 'Cancelled'),
(1017, 6, 106, 3, 2500, '2025-04-10', 'Completed'),
(1018, 7, 101, 1, 50000, '2025-04-15', 'Completed'),
(1019, 8, 104, 5, 800, '2025-04-20', 'Completed'),
(1020, 2, 105, 2, 1500, '2025-05-01', 'Completed'),
(1021, 10, 102, 1, 20000, '2025-05-05', 'Pending'),
(1022, 9, 107, 2, 3000, '2025-05-10', 'Completed'),
(1023, 3, 101, 1, 50000, '2025-05-15', 'Completed'),
(1024, 6, 103, 4, 2000, '2025-05-20', 'Completed');

-- Verification queries: each should return the expected row count.
SELECT COUNT(*) AS total_customers FROM customers; -- 12
SELECT COUNT(*) AS total_products FROM products;   -- 8
SELECT COUNT(*) AS total_sales FROM sales;         -- 24

Use retail_sales_practice;
Select * from sales

-- 2 I Want to show all orders with Completed Status.
SELECT * from sales where status = 'Completed';

-- 3. Show rhe name and price of products priced above rs.5000 from the products table.
select product_name, unit_price from products where unit_price > 5000;

-- 4. show all non-dublicate city names from the customers table.
select distinct city from customers;

-- 5. show the top 5 most expencive products by price from the products table
select product_name, unit_price from products order by unit_price desc limit 5;

-- 6. write a sql query to find out the total number of orders in the sales table
select count(*) as total_sales from sales;

-- 7. now extract the total sales amount of all orders from the sales table
select sum(quantity * unit_price) as total_sales from sales;

-- 8. now find the average price of all the products in products table
select AVG(unit_price) as average_price from products;

-- 9. find how many customers there are in each city from the customers table
select city, count(*) as total_customers from customers group by city;

-- 10. find the total sales amount for each status from your sales table
select status, sum(quantity * unit_price) as total_sales from sales group by status;

-- 11. select only those satuses from  the sales tables whose total sales amount is more than 50000
select status, sum(quantity * unit_price) as total_sales from sales group by status having Sum(quantity * unit_price) > 50000;

-- 12. we want to assign a category label to each product in the products table by looking at its price
select product_name, unit_price, case when unit_price >= 5000 then 'Expencive' when unit_price >= 2000 then 'Madium' else 'Cheap' end as price_category from products;

-- 13. find how many products are in each category from the products table
select category, count(*) as total_products from products group by category;

-- 14. i want to get only completed orders from the sales table then i want to count  the number of completed orders made by each customer. only those with 2 or more completed ordes
select customer_id, count(*) as total_orders from sales where status = 'Completed' group by customers_id having count(*) >= 2;

-- 15. use the customers and sales tables to display the customer name with each others
select sales.order_id, customers.customer_name, sales.quantity, sales.status from sales inner join customers on sales.customer_id = customers.customer_id;

-- 16. show the product name with each order. show these column by joining the sales and products tables
select sales.order_id, products.product_name, sales.quantity, sales.status from sales inner join products on sales.product_id = products.product_id;

-- 17. Show the customer name and product name for each order
select sales.order_id, customers.customer_name, products.product_name, sales.quantity from sales inner join customers on sales.customer_id = customers.customer_id inner join products on sales.product_id = products.product_id;

-- 18. show the total number of ordersplaced by each customer
select customers.customer_id, customers.customer_name, count(sales.order_id) as total_orders from customers left join sales on customers.customer_id = sales.customer_id group by customers.customer_id, customers.customer_name;

-- 19. we want to find out how much money each customer spent in total
select customers.customer_name, sum(sales.quantity * sales.unit_price) as total_sales from customers inner join sales on customers.customer_id = sales.customer_id group by customers.customer_id, customers.customer_name;

-- 20.  i want to dispalay all the customers in the customers table, whether they have placed an order or not
select customers.customer_name, sales.order_id from customers left join sales on customers.customer_id = sales.customer_id;

-- 21.  find which customers have not placed any orders. show only customer_id and customer_name in the output
select customers.customer_id, customers.customer_name from customers left join sales on customers.customer_id = sales.customer_id where sales.order_id is null;

-- 22. the total sales amount of each product is to be calculated
select products.product_name, sum(sales.quantity * sales.unitprice) as total_sales from products inner join sales on products.prouduct_id = sales.product_id group by proudcts.proudct_name;

-- 23. find the largest order amount among the orders placed by each customer
select customers.customer_name, max(sales.quantity * sales.unit_price) as highest_order_amount from customers inner join sales on customers.customer_id = sales.customer_id group by customers.customer_id, customers.customer_name;

-- 24. find the total sales amount for each category.
select products.category, sum(sales.quantity * sales.unit_price) as total_sales from products inner join sales on products.product_id = sales.product_id group by products.category;

-- 25. write a sql query to find products whose price is greater then the average price of all products.
select * from products where unit_price > (select avg(unit_price) from products);

-- 26. find the product or products with the highest price in the products table. display the product name and price.
select product_name, unit_price from products where unit_price = (select Max(Unit_price) from products);

-- 27 find products whose price is greater then the average price of products in the electronics category. 
select product_name, unit_price from products where unit_price > (select avg(unit_price) from products where category = 'Electronics');

-- 28 customers with above-averge orders :- find customers who have placed more order then the average number of orders per customers. 
SELECT c.customer_name,
       COUNT(s.order_id) AS total_orders
FROM customers c
INNER JOIN sales s
    ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(s.order_id) > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM sales
        GROUP BY customer_id
    ) AS customer_orders
);

