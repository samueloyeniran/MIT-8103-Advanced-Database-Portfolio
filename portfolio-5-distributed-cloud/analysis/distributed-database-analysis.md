# Portfolio 5: Distributed and Cloud Database Analysis

## 1. Case Study

NaijaMart is a fictional Nigerian e-commerce platform that manages products and inventory for customers in different locations. As the business grows, maintaining inventory across warehouses in Lagos, Abuja, Port Harcourt, and Ado-Ekiti becomes important.

The objective of this exercise is to model warehouse-level inventory and examine how distribution, consistency, replication, availability, and cloud database services could support the business.

## 2. Implementation and Data Model

The practical exercise was implemented using PostgreSQL 18 on a local Ubuntu environment.

Two tables were added:

- `warehouses`: stores each warehouse's identifier, name, and city.
- `warehouse_inventory`: stores the quantity of each product allocated to each warehouse.

The `warehouse_inventory` table uses a composite primary key consisting of `warehouse_id` and `product_id`. Foreign keys reference the `warehouses` and `products` tables. A CHECK constraint prevents negative inventory quantities.

Four warehouses and sixteen warehouse-product inventory records were created. Four products were allocated across the four locations.

## 3. Inventory Consistency Results

A SQL aggregation query compared each product's original inventory quantity with the sum of its warehouse allocations.

| Product | Original quantity | Warehouse total | Result |
|---|---:|---:|---|
| Wireless Mouse | 50 | 50 | Match |
| USB-C Charger | 30 | 30 | Match |
| Laptop 14-inch | 10 | 10 | Match |
| Running Shoes | 25 | 25 | Match |
| **Total** | **115** | **115** | **Match** |

All four products passed the consistency check. These results show that the illustrative warehouse allocations preserve the original quantity of each product.

## 4. Distribution and Sharding

Warehouse-level allocation provides a useful model for distributing inventory data by location. In a larger implementation, a warehouse identifier could help route inventory queries to the relevant data partition.

However, logical allocation across warehouses is not the same as database sharding. Sharding distributes data across multiple database nodes or servers and requires an appropriate routing and operational design. The implementation in this exercise runs on one PostgreSQL server and therefore does not demonstrate actual multi-server sharding.

## 5. Replication, Availability, and Consistency

A production NaijaMart platform could use a primary database and one or more replicas. The primary would handle writes, while replicas could serve selected read queries and support recovery if the primary failed.

Synchronous replication waits for confirmation from replicas according to its configuration. This can improve durability guarantees but may increase write latency. Asynchronous replication can reduce write latency but may leave replicas temporarily behind the primary, creating a risk of stale reads and loss of recent changes during some failures.

The system would need monitoring, tested recovery procedures, backups, access controls, and a clear failover strategy. Replication is not a substitute for backups.

The CAP theorem describes a trade-off during a network partition: a distributed system cannot guarantee both strong consistency and full availability for every request. NaijaMart would need to choose suitable behavior for each operation. For example, stock deductions should prioritize preventing overselling, while some catalogue reads may tolerate slightly stale information.

## 6. Cloud Database Considerations

A cloud-hosted PostgreSQL deployment could reduce the burden of maintaining database servers and provide managed backups, monitoring, and recovery features, depending on the chosen service and configuration.

For example, a managed PostgreSQL service such as Amazon RDS for PostgreSQL could be evaluated for the relational workload. A high-availability configuration and read replicas would need to be selected and tested against business requirements. A managed service alone does not automatically provide application-level warehouse sharding.

No cloud database deployment was performed as part of this practical exercise.

## 7. Limitations

This implementation is a local simulation using one PostgreSQL server. The four warehouses are represented as rows in relational tables; they are not four separate database servers. Replication, automatic failover, network partition handling, and real sharding were not configured or tested.

The inventory quantities are illustrative values chosen to preserve the existing totals. They should not be interpreted as real warehouse measurements.

## 8. Conclusion

The exercise demonstrates relational modelling for warehouse-level inventory, the use of primary and foreign keys, a constraint against negative stock, and SQL validation of aggregate inventory totals. It also identifies the additional infrastructure and operational decisions required to move from a local distribution model to a genuinely distributed and highly available database architecture.
