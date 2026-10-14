-- MIT 8103 Advanced Database Systems
-- Case Study: NaijaMart E-commerce Platform
-- Portfolio 1: Sample Data

-- 1. Create product categories
INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Computing', 'Laptops, desktops, and computer accessories'),
('Fashion', 'Clothing, footwear, and fashion accessories');

-- 2. Add products
INSERT INTO products
    (category_id, product_name, description, price, sku)
VALUES
    (1, 'Wireless Mouse', 'Wireless computer mouse', 8500.00, 'NM-ACC-001'),
    (1, 'USB-C Charger', 'Fast charging USB-C adapter', 12000.00, 'NM-ACC-002'),
    (2, 'Laptop 14-inch', 'Laptop for work and study', 650000.00, 'NM-COM-001'),
    (3, 'Running Shoes', 'Comfortable everyday running shoes', 45000.00, 'NM-FAS-001');

-- 3. Register customers
INSERT INTO customers (first_name, last_name, email, phone) VALUES
('Ada', 'Okafor', 'ada.okafor@example.com', '08030000001'),
('Tunde', 'Bello', 'tunde.bello@example.com', '08030000002'),
('Mariam', 'Ibrahim', 'mariam.ibrahim@example.com', '08030000003');

-- 4. Record initial stock levels
INSERT INTO inventory (product_id, quantity_in_stock) VALUES
(1, 50),
(2, 30),
(3, 10),
(4, 25);

