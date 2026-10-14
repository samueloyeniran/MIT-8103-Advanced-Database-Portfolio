# Portfolio 2: Query Processing and Optimisation

## 1. Overview

This portfolio demonstrates SQL query development, execution-plan analysis, indexing, and query optimisation using the NaijaMart e-commerce database built in Portfolio 1.

The database uses PostgreSQL and contains tables for customers, categories, products, orders, order items, payments, inventory, and deliveries.

## 2. Business Queries

Four SQL queries were developed to answer common business questions:

| Query                                     | Business Purpose                                            |
| ----------------------------------------- | ----------------------------------------------------------- |
| Query 1: Customer Orders                  | Retrieves customers and their order details.                |
| Query 2: Product Inventory                | Reports products, categories, prices, and available stock.  |
| Query 3: Order Details and Payment Report | Combines customer, order, product, and payment information. |
| Query 4: Low-Stock Products               | Identifies products with fewer than 30 units in stock.      |

The stock threshold of 30 units is an illustrative business rule for this exercise.

## 3. Directory Structure

* `sql/` — SQL scripts for the four business queries.
* `evidence/` — Saved query results.
* `execution-plans/` — PostgreSQL execution plans, including plans collected before and after adding an index.
* `analysis/` — Individual performance-analysis reports for the four queries.

## 4. Indexing and Optimisation

An index named `idx_orders_customer_id` was created on `orders(customer_id)` to investigate whether indexing the foreign-key column would improve the customer-orders query.

The execution plan continued to use sequential scans on the small sample dataset. Therefore, the index did not demonstrate a measurable query-performance improvement in this experiment.

This result illustrates that indexes do not automatically make every query faster. PostgreSQL's planner considers factors such as table size, data distribution, selectivity, and estimated execution cost when choosing a plan.

No additional indexes were introduced for the other queries because the small sample dataset did not provide sufficient evidence that they would improve performance.

## 5. Performance Analysis

The execution plans were collected using PostgreSQL's `EXPLAIN ANALYZE` functionality.

The analysis considers:

* Execution-plan operators and join strategies.
* Estimated versus actual row counts.
* Execution time reported for each test run.
* Whether indexes were used by the query planner.
* The limitations of testing with a small dataset.

The recorded execution times are observations from individual test runs, not production performance benchmarks. More representative data and repeated controlled tests would be required to draw stronger performance conclusions.

## 6. How to Reproduce the Queries

Run the commands from the project root in a terminal where PostgreSQL is available and the `naijamart` database has been created and populated.

Execute each query and save its output:

```bash
psql -d naijamart -f portfolio-2-query-optimisation/sql/01_customer_orders.sql
psql -d naijamart -f portfolio-2-query-optimisation/sql/02_product_inventory.sql
psql -d naijamart -f portfolio-2-query-optimisation/sql/03_order_payment_report.sql
psql -d naijamart -f portfolio-2-query-optimisation/sql/04_low_stock_products.sql
```

The saved results and execution plans are included in their respective directories for review.

## 7. Conclusion

This portfolio demonstrates practical SQL querying, multi-table joins, filtering, sorting, execution-plan interpretation, and an index evaluation.

The experiment also highlights the importance of evaluating optimisation decisions using execution evidence rather than assuming that adding an index will always improve performance.

