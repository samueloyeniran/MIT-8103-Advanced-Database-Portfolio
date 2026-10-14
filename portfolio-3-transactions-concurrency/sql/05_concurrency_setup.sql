-- Portfolio 3: Concurrency Control
-- Simulate a product with only one unit remaining.

CREATE TABLE IF NOT EXISTS concurrency_demo (
product_id INTEGER PRIMARY KEY,
product_name VARCHAR(100) NOT NULL,
stock INTEGER NOT NULL CHECK (stock >= 0)
);

INSERT INTO concurrency_demo (product_id, product_name, stock)
VALUES (1, 'Concurrency Test Product', 1)
ON CONFLICT (product_id) DO NOTHING;

SELECT * FROM concurrency_demo;

