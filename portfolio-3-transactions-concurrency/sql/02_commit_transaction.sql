-- Portfolio 3: Demonstrate COMMIT
-- Update the demonstration record and permanently save the change.

BEGIN;

UPDATE transaction_demo
SET amount = 150.00
WHERE demo_id = 1;

SELECT * FROM transaction_demo WHERE demo_id = 1;

COMMIT;

-- Verify the committed value.
SELECT * FROM transaction_demo WHERE demo_id = 1;

