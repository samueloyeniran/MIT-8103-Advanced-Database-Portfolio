-- Portfolio 2: Query Processing and Optimisation
-- Query 4: Low-Stock Products
-- Business question: Which products have fewer than 30 units
-- in stock and may need restocking?

SELECT
p.product_id,
p.product_name,
c.category_name,
i.quantity_in_stock,
p.price
FROM products AS p
INNER JOIN categories AS c
ON p.category_id = c.category_id
INNER JOIN inventory AS i
ON p.product_id = i.product_id
WHERE i.quantity_in_stock < 30
ORDER BY
i.quantity_in_stock ASC,
p.product_name;

