-- Portfolio 2: Query Processing and Optimisation
-- Query 2: Product inventory report
-- Business question: What products does NaijaMart sell, which
-- categories do they belong to, and how much stock is available?

SELECT
p.product_id,
p.product_name,
c.category_name,
p.price,
i.quantity_in_stock,
i.updated_at AS inventory_last_updated
FROM products AS p
INNER JOIN categories AS c
ON p.category_id = c.category_id
INNER JOIN inventory AS i
ON p.product_id = i.product_id
ORDER BY
i.quantity_in_stock ASC,
p.product_name;

