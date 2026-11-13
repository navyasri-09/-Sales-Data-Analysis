-- Sales Data Analysis Project
-- Database: sales_analysis_db
CREATE DATABASE IF NOT EXISTS sales_analysis_db;
USE sales_analysis_db;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer VARCHAR(100) NOT NULL,
    city VARCHAR(60) NOT NULL,
    category VARCHAR(60) NOT NULL,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    salesperson VARCHAR(60) NOT NULL
);

-- Import sales_data.csv using MySQL Workbench Table Data Import Wizard,
-- or insert rows manually. Then run the analysis queries below.

-- 1. View all sales
SELECT * FROM sales;

-- 2. Total number of orders
SELECT COUNT(*) AS total_orders FROM sales;

-- 3. Total revenue
SELECT SUM(quantity * unit_price) AS total_revenue FROM sales;

-- 4. Total units sold
SELECT SUM(quantity) AS total_units_sold FROM sales;

-- 5. Revenue by city
SELECT city, SUM(quantity * unit_price) AS revenue
FROM sales GROUP BY city ORDER BY revenue DESC;

-- 6. Revenue by category
SELECT category, SUM(quantity * unit_price) AS revenue
FROM sales GROUP BY category ORDER BY revenue DESC;

-- 7. Revenue by salesperson
SELECT salesperson, SUM(quantity * unit_price) AS revenue
FROM sales GROUP BY salesperson ORDER BY revenue DESC;

-- 8. Monthly revenue
SELECT DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
       SUM(quantity * unit_price) AS revenue
FROM sales GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY sales_month;

-- 9. Highest-value orders
SELECT order_id, customer, city, quantity * unit_price AS order_value
FROM sales ORDER BY order_value DESC LIMIT 5;

-- 10. Average order value
SELECT AVG(quantity * unit_price) AS average_order_value FROM sales;
