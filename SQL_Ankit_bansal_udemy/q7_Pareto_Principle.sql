
use ankit_bansal_udemy;


-----------------Pareto Principle-------------------------------
-----------------Pareto Principle-------------------------------


DROP TABLE IF EXISTS product_sales;

CREATE TABLE product_sales (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    sale_date DATE NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);



INSERT INTO product_sales
    (sale_date, product_id, product_name, quantity, unit_price)
VALUES
('2025-01-01', 101, 'Laptop', 2, 55000),
('2025-01-02', 101, 'Laptop', 1, 55000),
('2025-01-05', 101, 'Laptop', 3, 55000),
('2025-01-10', 101, 'Laptop', 1, 55000),
('2025-01-15', 101, 'Laptop', 2, 55000),

('2025-01-01', 102, 'Mobile Phone', 5, 18000),
('2025-01-03', 102, 'Mobile Phone', 4, 18000),
('2025-01-07', 102, 'Mobile Phone', 6, 18000),
('2025-01-12', 102, 'Mobile Phone', 3, 18000),
('2025-01-18', 102, 'Mobile Phone', 7, 18000),

('2025-01-02', 103, 'Headphones', 10, 2500),
('2025-01-04', 103, 'Headphones', 15, 2500),
('2025-01-09', 103, 'Headphones', 8, 2500),
('2025-01-16', 103, 'Headphones', 12, 2500),

('2025-01-03', 104, 'Keyboard', 7, 1500),
('2025-01-06', 104, 'Keyboard', 8, 1500),
('2025-01-11', 104, 'Keyboard', 6, 1500),
('2025-01-17', 104, 'Keyboard', 9, 1500),

('2025-01-04', 105, 'Mouse', 12, 800),
('2025-01-08', 105, 'Mouse', 15, 800),
('2025-01-14', 105, 'Mouse', 10, 800),
('2025-01-20', 105, 'Mouse', 18, 800),

('2025-01-05', 106, 'Monitor', 2, 22000),
('2025-01-13', 106, 'Monitor', 3, 22000),
('2025-01-19', 106, 'Monitor', 1, 22000);


---------------------------------------------- Solution ----------------------------------------------



select * from product_sales;



WITH product_revenue AS (
    SELECT
        p.product_name,
        SUM(p.unit_price * p.quantity) AS product_revenue
    FROM product_sales AS p
    GROUP BY p.product_name
),
total_revenue AS (
    SELECT
        SUM(p.unit_price * p.quantity) AS total_revenue
    FROM product_sales AS p
),
revenue_percentage AS (
    SELECT
        product_name,
        100.0 * product_revenue / total_revenue AS revenue_percent
    FROM product_revenue
    CROSS JOIN total_revenue
)
SELECT
    product_name,
    revenue_percent,
    SUM(revenue_percent) OVER (ORDER BY revenue_percent DESC) AS cumulative_percent
FROM revenue_percentage
ORDER BY revenue_percent DESC;






