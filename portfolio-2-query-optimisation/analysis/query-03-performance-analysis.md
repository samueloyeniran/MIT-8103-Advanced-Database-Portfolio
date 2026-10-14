# Query 3: Order Details and Payment Report — Performance Analysis

## 1. Business Question

Which customers placed orders, what products were ordered, and what payment information is available for each order?

## 2. Query Description

The query joins five tables: `customers`, `orders`, `order_items`, `products`, and `payments`.

It retrieves customer names, order details, product names, quantities, unit prices, and payment information.

The query uses `INNER JOIN` to retrieve matching customer, order, order-item, and product records. It uses `LEFT JOIN` for payments so that an order can still appear even when no matching payment record exists.

## 3. Baseline Execution Plan

The execution plan contains:

* Sequential scans on all five tables.
* Hash joins to combine customers with orders and products with order items.
* A merge left join to combine orders with payment records.
* A merge join to combine orders with order items.
* An incremental sort to produce the requested result order.

The query returned four rows. The recorded planning time was 1.654 ms, and execution time was 0.369 ms.

## 4. Interpretation of the Plan

PostgreSQL selected a combination of hash joins, merge joins, and sorting operations.

The sequential scans are reasonable for the current sample database because each table contains only a few records. Reading these small tables directly can be cheaper than using indexes.

The plan's estimated row counts are substantially higher than the actual row counts for some operations. For example, the top merge join estimates 71,567 rows but returns four. This difference suggests that the planner's estimates do not accurately reflect the current sample data.

## 5. Important Reporting Consideration

Payment amounts are associated with orders, while products and quantities are associated with order items.

Consequently, an order-level payment amount can appear on multiple rows when an order contains multiple products. For example, Ada's payment of 20,500 appears twice because her order contains two items.

Reports that calculate payment totals must account for this one-to-many relationship to avoid counting the same payment multiple times.

## 6. Limitations

The execution time represents one run against a very small dataset. It is not a reliable prediction of performance at production scale.

The difference between estimated and actual row counts is worth investigating, but the sample is too small to support firm conclusions about production performance.

Repeated measurements and representative test data would be needed to assess performance and determine whether additional optimisation is beneficial.

## 7. Conclusion

The query successfully combines customer, order, product, and payment information into a single report.

The execution plan demonstrates how PostgreSQL can combine different join algorithms and sorting operations to produce the required result. It also highlights the importance of understanding table relationships and avoiding duplicate counting in reports.


