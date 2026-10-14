-- Portfolio 2: Query Processing and Optimisation
-- Query 1: Retrieve customer orders
-- Business question: Which customers placed orders, and what is
-- the date, status, and total amount of each order?

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.status AS order_status,
    o.total_amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
ORDER BY
    o.order_date DESC,
    o.order_id;
