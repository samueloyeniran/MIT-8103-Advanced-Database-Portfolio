# MIT 8103 — Advanced Database Systems
## Final Portfolio Summary: NaijaMart E-commerce Database

**Student Name:** [Enter your full name]  
**Programme:** [Enter your programme]  
**Course:** MIT 8103 — Advanced Database Systems  
**Project:** NaijaMart E-commerce Database  
**GitHub Repository:** https://github.com/samueloyeniran/MIT-8103-Advanced-Database-Portfolio

## 1. Introduction

This portfolio applies database concepts to NaijaMart, a fictional Nigerian e-commerce platform. The project explores relational database design, query processing and optimisation, transactions and concurrency, NoSQL data modelling, and distributed database architecture.

The practical work used PostgreSQL in an Ubuntu environment running through Windows Subsystem for Linux (WSL) and MongoDB for document-oriented data exercises. SQL scripts, database outputs, design documents, and analysis notes are organised in the project repository.

The purpose was to understand how database design decisions affect data integrity, query performance, transaction reliability, flexibility, and the distribution of data across business locations.

## 2. Portfolio 1: Database Design and Modelling

The first activity established a relational foundation for NaijaMart. The schema includes customers, categories, products, orders, order items, payments, inventory, and deliveries.

Primary keys identify records, while foreign keys establish relationships between related entities. Unique and check constraints help prevent invalid or duplicate data. Examples include unique customer email addresses, unique product SKUs, positive order-item quantities, and non-negative inventory values.

Sample data was inserted and queried to examine the relationships between the tables. Verification evidence included table and constraint listings, record counts, product inventory reports, order details, and checks comparing stored order totals with calculated totals. The sample order-total checks showed matching stored and calculated values.

The normalisation notes discuss First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF). A more formal demonstration of functional dependencies remains an area for improvement.

**Key learning:** A relational schema is not simply a collection of tables. Relationships, constraints, and appropriate data organisation are essential for maintaining consistency. The current model also has limitations: inventory is not automatically reduced when orders are placed, and an order can exist without order items.

## 3. Portfolio 2: Query Processing and Optimisation

The second activity examined how business questions can be answered using SQL and how PostgreSQL executes queries.

The practical queries covered customer orders, product inventory, order details with payment information, and products with low stock. `EXPLAIN ANALYZE` was used to inspect execution plans, including scans, joins, estimated and actual rows, and execution times.

An index was created on `orders(customer_id)` using the name `idx_orders_customer_id`. PostgreSQL continued to use sequential scans for the small dataset during the observed tests. Therefore, the exercise did not establish a measurable performance improvement from this index.

This result demonstrates why indexes should be evaluated against actual query plans and representative workloads rather than added without evidence. Small datasets may not justify the additional cost of maintaining an index.

**Key learning:** Query optimisation requires understanding the query, examining its execution plan, and testing changes. The recorded timings are practical observations, not production-scale benchmarks.

## 4. Portfolio 3: Transactions and Concurrency

The third activity explored transaction control and concurrent database access using PostgreSQL.

The practical work demonstrated `COMMIT` by preserving a change, and `ROLLBACK` by undoing an uncommitted change. A two-session exercise illustrated the READ COMMITTED isolation level: after one session updated a value and committed, a subsequent query in the other session observed the new committed value.

A separate inventory exercise demonstrated row locking and a conditional stock update. The test product began with one unit in stock. One session updated the row while another session attempted a conditional update. After the first transaction released its lock, the second update affected zero rows because the stock condition was no longer satisfied. The final stock quantity was zero, rather than negative.

Dedicated demonstration tables were used to avoid altering the original business records during these experiments.

**Key learning:** Transactions help control when changes become permanent, while isolation and locking influence how concurrent operations interact. Conditional updates can help protect inventory from overselling, although a complete production order-and-payment workflow would require additional design and testing.

## 5. Portfolio 4: NoSQL and Advanced Data Models

The fourth activity introduced MongoDB through a product-catalogue exercise. The work used MongoDB 9 and `mongosh`, with a `naijamart` database and a `products` collection containing synthetic product data.

The practical exercises covered inserting documents, counting records, filtering by category, price, and stock, sorting and limiting results, querying nested attributes, updating inventory values, and handling optional product attributes. An index was created on `productId`, and query execution information was examined.

The activity also considered differences between document-oriented and relational modelling. MongoDB allows related product attributes to be represented within a document, which can be convenient when catalogue items have different characteristics. Relational databases remain useful where structured relationships and cross-entity integrity are important.

**Key learning:** NoSQL databases provide alternative modelling choices rather than eliminating the need for sound data design. This exercise focused on product catalogue data; it did not implement the complete production e-commerce application, including all authentication, order, payment, and warehouse workflows.

## 6. Portfolio 5: Distributed and Cloud Database Exercise

The fifth activity extended the NaijaMart model to represent inventory across four warehouse locations: Lagos, Abuja, Port Harcourt, and Ado-Ekiti.

Two tables, `warehouses` and `warehouse_inventory`, represent warehouse details and product quantities at each location. The warehouse inventory table uses a composite primary key consisting of `warehouse_id` and `product_id`, foreign keys to the related records, and a check constraint preventing negative stock quantities.

The practical exercise created four warehouse records and sixteen warehouse-inventory records. The totals were checked against the original product quantities:

| Product | Original Quantity | Distributed Quantity |
|---|---:|---:|
| Wireless Mouse | 50 | 50 |
| USB-C Charger | 30 | 30 |
| Laptop 14-inch | 10 | 10 |
| Running Shoes | 25 | 25 |
| **Total** | **115** | **115** |

These results demonstrate that the logical allocation preserved the quantities in this exercise.

The architecture and analysis documents discuss data distribution, sharding, replication, availability, consistency, the CAP theorem, and cloud database considerations. However, the practical implementation remains a local PostgreSQL model with a conceptual distributed architecture. It is not a deployed multi-server distributed database, and it does not demonstrate live replication, automatic failover, or cloud database deployment.

**Key learning:** Distributing data logically across warehouses is different from deploying a physically distributed database. A real implementation would require further decisions about routing, replication, failure recovery, monitoring, network security, and consistency requirements.

## 7. Overall Technical Reflection

The five activities show that database engineering involves more than writing queries. The initial relational design established a structured foundation; query analysis provided a way to investigate execution behaviour; transaction exercises illustrated the importance of reliable concurrent updates; MongoDB introduced a document-oriented approach; and the warehouse exercise connected data modelling with distributed-system design.

One important lesson was the value of evidence. The query optimisation exercise did not prove that the index improved performance, and the distributed database exercise did not deploy a real distributed environment. Recording these limitations makes the conclusions more reliable.

The work also identified opportunities for further development: completing formal normalisation proofs, implementing automatic inventory updates within an order transaction, testing queries with larger datasets, expanding the MongoDB model, and deploying a genuine distributed or managed cloud database environment.

## 8. Conclusion

The NaijaMart portfolio provided practical experience with relational modelling, SQL querying, execution plans, transaction control, concurrency, MongoDB documents, and warehouse inventory allocation. It also highlighted the importance of integrity constraints, controlled experiments, and honest reporting of what has and has not been implemented.

The portfolio provides a foundation for further study and practical database engineering. The saved scripts, evidence files, diagrams, and analysis documents allow the work to be reviewed and extended.

## 9. References

1. PostgreSQL Global Development Group. *PostgreSQL Documentation*. https://www.postgresql.org/docs/
2. MongoDB, Inc. *MongoDB Manual*. https://www.mongodb.com/docs/manual/
3. MIT 8103 Advanced Database Systems assignment instructions and assessment criteria supplied for this coursework.
4. NaijaMart portfolio SQL scripts, evidence files, diagrams, and analysis documents maintained in the project repository.

## 10. Declaration of AI Assistance

AI assistance was used to support concept explanations, troubleshooting guidance, review of database approaches, and the organisation and drafting of project documentation. Practical database operations, command execution, and examination of outputs were carried out in the local learning environment. The portfolio records the scope and limitations of the exercises as implemented.

I will review this report, verify its statements against my saved evidence, and ensure that the final submission complies with my institution's requirements for acknowledging AI assistance.
