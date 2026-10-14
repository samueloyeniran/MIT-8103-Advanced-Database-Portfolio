-- Portfolio 3: Transaction Isolation
-- Create an isolated table for testing transaction visibility.

CREATE TABLE IF NOT EXISTS isolation_demo (
demo_id INTEGER PRIMARY KEY,
description VARCHAR(100) NOT NULL,
amount NUMERIC(10, 2) NOT NULL CHECK (amount >= 0)
);

INSERT INTO isolation_demo (demo_id, description, amount)
VALUES (1, 'Isolation demonstration record', 200.00)
ON CONFLICT (demo_id) DO NOTHING;

SELECT * FROM isolation_demo ORDER BY demo_id;

