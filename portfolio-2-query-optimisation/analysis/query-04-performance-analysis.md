# Query 4: Low-Stock Products — Performance Analysis

## 1. Business Question

Which products have fewer than 30 units in stock and may need restocking?

## 2. Query Description

This query joins the `products`, `categories`, and `inventory` tables to identify products whose inventory quantity is below the threshold of 30 units.

The query returns the product ID, product name, category, available stock, and price. Results are sorted by stock quantity in ascending order so that products with the lowest inventory appear first.

The threshold of 30 units is an illustrative business rule used for this exercise.

## 3. Execution Plan Analysis

The execution plan contains the following operations:

* **Sequential Scan on inventory:** PostgreSQL examines inventory records and applies the condition `quantity_in_stock < 30`.
* **Hash Join:** PostgreSQL joins matching records from the inventory and product tables.
* **Sequential Scan on products:** PostgreSQL reads the product records.
* **Sequential Scan on categories:** PostgreSQL reads the category records.
* **Sort:** PostgreSQL orders the results by inventory quantity and product name.

The execution plan shows that PostgreSQL used sequential scans and hash joins to retrieve the results.

## 4. Performance Observations

The query returned two products: Laptop 14-inch, with 10 units in stock, and Running Shoes, with 25 units in stock.

The inventory scan estimated 567 rows but returned only 2. This difference indicates that the planner's estimated row count did not match the actual result for the current dataset.

The measured execution time was 0.262 milliseconds. This represents a single execution against a small sample database and should not be treated as a reliable production performance benchmark.

## 5. Indexing and Optimisation Decision

No additional index was created for this query.

The inventory table contains only four sample records, so a sequential scan is a reasonable strategy. Adding an index solely to avoid this scan is not justified by the current evidence.

If the inventory table grows substantially, an index on `quantity_in_stock` could be evaluated. Its usefulness would depend on data distribution, the proportion of rows matching the threshold, and the workload.

Any proposed index should be tested against the existing query using representative data and comparable execution plans.

## 6. Conclusion

The query correctly identifies products whose stock falls below the illustrative restocking threshold. The execution plan provides evidence of how PostgreSQL filters, joins, and sorts the records.

The current dataset is too small to establish how the query would perform at production scale. Further testing with representative inventory volumes would be needed before recommending additional indexing.

