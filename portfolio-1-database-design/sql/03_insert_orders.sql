-- MIT 8103 Advanced Database Systems
-- Case Study: NaijaMart E-commerce Platform
-- Portfolio 1: Sample Orders and Order Items

-- 1. Create three customer orders
INSERT INTO orders (customer_id, status, total_amount) VALUES
(1, 'confirmed', 20500.00),
(2, 'processing', 650000.00),
(3, 'pending', 90000.00);

-- 2. Add products to each order
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 8500.00),
(1, 2, 1, 12000.00),
(2, 3, 1, 650000.00),
(3, 4, 2, 45000.00);

