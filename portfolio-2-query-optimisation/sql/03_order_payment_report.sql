-- Portfolio 2: Query Processing and Optimisation
-- Query 3: Order Details and Payment Report
-- Business question: Which products were ordered, who placed the
-- orders, and what payment information is available?

SELECT
c.customer_id,
c.first_name,
c.last_name,
o.order_id,
o.order_date,
o.status AS order_status,
p.product_name,
oi.quantity,
oi.unit_price,
pay.payment_method,
pay.status AS payment_status,
pay.amount AS payment_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
ON o.order_id = oi.order_id
INNER JOIN products AS p
ON oi.product_id = p.product_id
LEFT JOIN payments AS pay
ON o.order_id = pay.order_id
ORDER BY
o.order_id,
p.product_name;

