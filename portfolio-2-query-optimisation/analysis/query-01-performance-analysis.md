# Query 1: Customer Orders — Performance Analysis

## 1. Business Question

Which customers placed orders, and what are the date, status, and total amount of each order?

## 2. Query Description

The query joins the `customers` and `orders` tables using `customer_id`. It retrieves customer names and order details, then sorts the results by order date in descending order and order ID.

The query uses an `INNER JOIN`, so only customers with matching orders are returned.

## 3. Baseline Execution Plan

The initial execution plan contained:

* Sequential scans on `customers` and `orders`.
* A Hash Join to combine matching customer and order records.
* A Sort operation to order the results.

The query returned three rows. The first recorded execution time was 1.607 ms.

## 4. Indexing Experiment

An index named `idx_orders_customer_id` was created on `orders(customer_id)`.

The index was selected because the column is used to associate orders with customers and may benefit queries that filter orders by customer.

The index was verified through PostgreSQL's `pg_indexes` system view.

## 5. Results After Indexing

The execution plan after creating the index still used sequential scans on both tables, followed by a Hash Join and a Sort operation.

The query returned the same three rows. The recorded execution time was 0.243 ms.

The planner's estimated cost also changed. The estimated number of rows for the orders scan changed from 640 in the original plan to 3 in the later plan.

## 6. Interpretation and Limitations

The index was created successfully, but PostgreSQL did not use it in the execution plan for this query.

The tables contain only three customers and three orders. For tables this small, sequential scans can be more efficient than index access because the database can read the few available rows directly.

Although the later execution was faster in the recorded run, the measurements were not collected through a controlled benchmark. Differences in caching, planning, and system activity may affect execution times. Therefore, the timing results do not establish that the index caused a performance improvement.

The change in estimated row counts also indicates that planner estimates differed between the two runs. Further investigation and controlled testing would be needed before drawing firm conclusions about performance.

## 7. Conclusion

The experiment demonstrates that creating an index does not guarantee that PostgreSQL will use it. The query planner selects a plan based on its estimates of the available execution strategies.

The index may be useful for queries that retrieve orders by customer, particularly as the dataset grows. Testing with representative data and repeated measurements would be necessary to evaluate its practical benefit.

