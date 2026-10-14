# Query 2: Product Inventory Report — Performance Analysis

## 1. Business Question

Which products are available, what categories do they belong to, what are their prices, and how many units are currently in stock?

## 2. Query Description

The query joins the `products`, `categories`, and `inventory` tables. It retrieves product details, category names, prices, stock quantities, and the last inventory update timestamp.

The results are ordered by stock quantity in ascending order, followed by product name.

## 3. Baseline Execution Plan

The baseline execution plan contains:

* Sequential scans on the `products`, `categories`, and `inventory` tables.
* Hash joins to combine related records.
* A sort operation to arrange the final results.

The query returned four rows. The recorded planning time was 1.143 ms, while execution time was 0.279 ms.

## 4. Existing Indexes

Inspection of PostgreSQL's `pg_indexes` system view identified five indexes across the three tables:

* `categories_pkey` on `categories(category_id)`.
* `categories_category_name_key` on `categories(category_name)`.
* `products_pkey` on `products(product_id)`.
* `products_sku_key` on `products(sku)`.
* `inventory_pkey` on `inventory(product_id)`.

These indexes support primary-key lookups and enforce uniqueness where required.

## 5. Indexing Decision

No additional index was created for this query at this stage.

The existing indexes were inspected, and the baseline execution plan was examined before deciding whether further optimisation was justified.

PostgreSQL selected sequential scans and hash joins. Because the sample tables contain only four products, three categories, and four inventory records, sequential scans may be more efficient than index access.

Although an index on the inventory quantity column could be investigated for larger datasets, the current experiment does not establish that such an index would improve performance.

## 6. Interpretation and Limitations

The recorded execution time was 0.279 ms, but this measurement represents one run against a very small dataset.

The result should not be treated as a reliable prediction of performance with thousands or millions of records. Repeated measurements and representative data would be needed for a meaningful comparison.

The baseline plan also demonstrates that having indexes available does not guarantee PostgreSQL will use them. The query planner chooses an execution strategy based on its cost estimates.

## 7. Conclusion

The baseline query successfully returned all four products and their inventory information.

The existing indexes were documented, and no additional index was introduced without sufficient evidence of a likely benefit. Further optimisation should be evaluated using a larger dataset and controlled performance measurements.

