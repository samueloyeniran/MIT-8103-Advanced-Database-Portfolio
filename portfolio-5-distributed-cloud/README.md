# Portfolio 5: Distributed and Cloud Database Exercise

## 1. Overview

**Case study:** NaijaMart — a fictional Nigerian e-commerce platform.

**Database:** PostgreSQL 18.

**Environment:** Ubuntu on WSL.

This portfolio models inventory distribution across four NaijaMart warehouses and explores distributed database concepts, including data distribution, consistency, replication, availability, sharding, and cloud database services.

**Implementation status:** Local PostgreSQL practical exercise with a conceptual distributed architecture. A multi-server distributed database was not deployed.

## 2. Learning Objectives

- Model warehouse-level inventory using relational tables.
- Apply primary keys, foreign keys, and CHECK constraints.
- Distribute product quantities across multiple logical warehouses.
- Validate inventory totals using SQL aggregation.
- Explain the differences between logical data distribution and database sharding.
- Analyse replication, consistency, availability, and the CAP theorem.
- Evaluate considerations for a future cloud-hosted database.

## 3. Warehouse Locations

The exercise includes four warehouses:

1. Lagos
2. Abuja
3. Port Harcourt
4. Ado-Ekiti

Sixteen warehouse inventory records represent four products across the four locations.

## 4. Database Design

Two tables were added to the existing NaijaMart PostgreSQL database.

### warehouses

Stores the warehouse identifier, warehouse name, and city.

### warehouse_inventory

Stores inventory quantities for each product at each warehouse.

The table uses a composite primary key consisting of `warehouse_id` and `product_id`. Foreign keys reference the warehouse and product records, while a CHECK constraint prevents negative inventory quantities.

## 5. Results

The warehouse inventory totals were compared with the original inventory quantities.

| Product | Original Quantity | Warehouse Total | Result |
|---|---:|---:|---|
| Wireless Mouse | 50 | 50 | Match |
| USB-C Charger | 30 | 30 | Match |
| Laptop 14-inch | 10 | 10 | Match |
| Running Shoes | 25 | 25 | Match |
| **Total** | **115** | **115** | **Match** |

All four products passed the inventory consistency check.

The SQL output supporting these results is available in the `evidence/` directory.

## 6. Repository Structure

- `sql/01_create_warehouse_model.sql` — creates the warehouse and warehouse inventory tables.
- `sql/02_insert_warehouses.sql` — inserts the four warehouse records.
- `sql/03_distribute_inventory.sql` — inserts the warehouse inventory allocations.
- `evidence/inventory-consistency-check.txt` — records the inventory consistency results.
- `evidence/warehouse-inventory-distribution.txt` — records the warehouse inventory distribution.
- `analysis/distributed-database-analysis.md` — discusses the implementation and distributed database concepts.
- `diagrams/naijamart-distributed-architecture.md` — documents the proposed architecture.

## 7. Reproducing the Practical Exercise

Run these commands from this portfolio directory, assuming PostgreSQL is installed, the `naijamart` database exists, and the required original `products` table is present.

Execute the scripts in order:

    sudo -u postgres psql -v ON_ERROR_STOP=1 -d naijamart -f sql/01_create_warehouse_model.sql

    sudo -u postgres psql -v ON_ERROR_STOP=1 -d naijamart -f sql/02_insert_warehouses.sql

    sudo -u postgres psql -v ON_ERROR_STOP=1 -d naijamart -f sql/03_distribute_inventory.sql

**Important:** These scripts are designed to be rerun safely: warehouse names are protected by a unique constraint and `ON CONFLICT`, while warehouse inventory uses its composite primary key to update existing records. The schema must already have the expected structure; `CREATE TABLE IF NOT EXISTS` does not update an existing table definition.

## 8. Distributed Database Analysis

The analysis considers:

- Logical warehouse inventory distribution.
- The distinction between distribution and actual database sharding.
- Synchronous and asynchronous replication.
- Consistency and availability trade-offs during network partitions.
- Backups, monitoring, recovery, and failover.
- Potential use of a managed PostgreSQL cloud service.

## 9. Limitations

The practical implementation runs on one local PostgreSQL server. The four warehouses are represented as records in relational tables rather than separate database servers.

Actual multi-server sharding, replication, automatic failover, network partition testing, and cloud deployment were not implemented.

The architecture diagram is conceptual and must not be interpreted as evidence of a deployed distributed system.

## 10. Conclusion

This exercise demonstrates relational modelling, inventory distribution, integrity constraints, and SQL-based consistency validation. It also identifies the infrastructure and operational work required to build a genuinely distributed and highly available database system.
