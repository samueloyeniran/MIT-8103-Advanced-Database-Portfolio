-- MIT 8103 Portfolio 5: NaijaMart warehouse locations
-- Register four warehouse locations.
-- ON CONFLICT prevents duplicate warehouse names if rerun.

INSERT INTO warehouses (warehouse_name, city)
VALUES
    ('NaijaMart Lagos Warehouse', 'Lagos'),
    ('NaijaMart Abuja Warehouse', 'Abuja'),
    ('NaijaMart Port Harcourt Warehouse', 'Port Harcourt'),
    ('NaijaMart Ekiti Warehouse', 'Ado-Ekiti')
ON CONFLICT (warehouse_name) DO NOTHING;

-- Display the registered warehouses.
SELECT warehouse_id, warehouse_name, city
FROM warehouses
ORDER BY warehouse_id;
