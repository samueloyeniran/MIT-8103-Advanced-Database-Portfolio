-- Portfolio 3: Transactions and Concurrency
-- Purpose: Create an isolated table for transaction experiments.

CREATE TABLE IF NOT EXISTS transaction_demo (
demo_id INTEGER PRIMARY KEY,
description VARCHAR(100) NOT NULL,
amount NUMERIC(10, 2) NOT NULL CHECK (amount >= 0)
);

INSERT INTO transaction_demo (demo_id, description, amount)
VALUES (1, 'Initial demonstration record', 100.00)
ON CONFLICT (demo_id) DO NOTHING;

SELECT * FROM transaction_demo ORDER BY demo_id;

