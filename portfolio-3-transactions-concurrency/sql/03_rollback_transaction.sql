-- Portfolio 3: Demonstrate ROLLBACK
-- Attempt an update, then undo it before committing.

BEGIN;

UPDATE transaction_demo
SET amount = 999.00
WHERE demo_id = 1;

-- Inspect the value inside the transaction.
SELECT * FROM transaction_demo WHERE demo_id = 1;

ROLLBACK;

-- Verify that the original committed value is restored.
SELECT * FROM transaction_demo WHERE demo_id = 1;

