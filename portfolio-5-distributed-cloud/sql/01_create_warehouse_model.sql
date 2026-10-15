-- MIT 8103 Portfolio 5: Distributed and Cloud Databases
-- Case study: NaijaMart warehouse inventory distribution
-- This is a local simulation, not a multi-server deployment.

CREATE TABLE IF NOT EXISTS warehouses (
    warehouse_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL UNIQUE,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS warehouse_inventory (
    warehouse_id INTEGER NOT NULL REFERENCES warehouses(warehouse_id),
    product_id BIGINT NOT NULL REFERENCES products(product_id),
    quantity_in_stock INTEGER NOT NULL DEFAULT 0
        CHECK (quantity_in_stock >= 0),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (warehouse_id, product_id)
);
