-- MIT 8103 Advanced Database Systems
-- Case Study: NaijaMart E-commerce Platform
-- Portfolio 1: Sample Payment Data

INSERT INTO payments
    (order_id, amount, payment_method, status, payment_reference)
VALUES
    (1, 20500.00, 'card', 'successful', 'NM-PAY-1001'),
    (2, 650000.00, 'bank_transfer', 'successful', 'NM-PAY-1002'),
    (3, 90000.00, 'card', 'pending', 'NM-PAY-1003');
