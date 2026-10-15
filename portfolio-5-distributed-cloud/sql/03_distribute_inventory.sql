-- MIT 8103 Portfolio 5: NaijaMart warehouse inventory allocation
-- Illustrative distribution preserving existing product stock totals.
-- Warehouse IDs: 1=Lagos, 2=Abuja, 3=Port Harcourt, 4=Ekiti.

INSERT INTO warehouse_inventory
    (warehouse_id, product_id, quantity_in_stock)
VALUES
    (1, 1, 20), (2, 1, 12), (3, 1, 10), (4, 1, 8),
    (1, 2, 12), (2, 2,  8), (3, 2,  6), (4, 2, 4),
    (1, 3,  4), (2, 3,  2), (3, 3,  2), (4, 3, 2),
    (1, 4, 10), (2, 4,  5), (3, 4,  6), (4, 4, 4)
ON CONFLICT (warehouse_id, product_id)
DO UPDATE SET
    quantity_in_stock = EXCLUDED.quantity_in_stock,
    updated_at = CURRENT_TIMESTAMP;
