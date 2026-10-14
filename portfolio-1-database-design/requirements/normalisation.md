# NaijaMart Database Normalisation

## 1. Introduction

Database normalisation is the process of organising data into related tables to reduce unnecessary duplication and improve data integrity.

NaijaMart uses PostgreSQL to manage customers, products, categories, orders, order items, payments, inventory, and deliveries.

This document explains how the database design relates to First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF).

## 2. First Normal Form (1NF)

A table satisfies First Normal Form when each column contains a single value in each row and repeating groups are avoided.

In the NaijaMart database:

* The `customers` table stores individual customer details in separate columns.
* The `products` table stores each product as a separate record.
* The `order_items` table stores each product included in an order as a separate row.
* The `payments` table stores payment records separately from order records.

For example, an order containing a wireless mouse and a USB-C charger has two corresponding rows in `order_items`, rather than storing both products in one column.

This structure supports First Normal Form by keeping individual values and records organised.

## 3. Second Normal Form (2NF)

Second Normal Form requires a table to satisfy First Normal Form and ensures that every non-key attribute depends on the whole of each candidate key, rather than only part of a composite candidate key.

The `order_items` table has a primary key called `order_item_id` and a unique constraint on the combination of `order_id` and `product_id`.

The unique combination prevents the same product from appearing more than once in the same order under the current design.

Attributes such as `quantity` and `unit_price` describe the product entry within a particular order. They are associated with the order-product combination rather than depending on only one part of that combination.

Other tables use single-column primary keys, which avoids partial dependencies on composite primary keys.

These design choices support Second Normal Form. A complete formal assessment should consider all candidate keys and functional dependencies in each table.

## 4. Third Normal Form (3NF)

Third Normal Form requires a table to satisfy Second Normal Form and prevents non-key attributes from depending transitively on a candidate key.

NaijaMart separates information about different business entities into related tables.

Examples include:

* Customer names and email addresses are stored in `customers`.
* Category names and descriptions are stored in `categories`.
* Product details are stored in `products`, with `category_id` referencing the relevant category.
* Customer order information is stored in `orders`.
* Product quantities and purchase-time prices are stored in `order_items`.
* Payment information is stored in `payments`.
* Stock quantities are stored in `inventory`.
* Delivery information is stored in `deliveries`.

For example, a category name is stored in `categories` rather than being repeated as a category description in every product record. The product refers to its category through `category_id`.

This separation reduces duplicated information and supports Third Normal Form. A complete formal proof would require documenting the functional dependencies for every table.

## 5. Database Anomalies Reduced by the Design

Normalisation helps reduce three common database anomalies.

### Update Anomaly

If a customer's email address changes, it can be updated in the `customers` table rather than being changed in every order record.

### Insertion Anomaly

A product can be added to the catalogue before a customer places an order, provided the required product information and category relationship are valid.

### Deletion Anomaly

Deleting an order does not inherently require deleting the customer's account or the associated product catalogue records.

The actual deletion behaviour depends on the foreign-key constraints. For example, the current schema uses `ON DELETE CASCADE` for the relationship between `orders` and `order_items`, so deleting an order also deletes its associated order-item records.

## 6. Design Trade-Off: Stored Order Totals

The `orders` table stores a `total_amount` value. However, the order total can also be calculated by summing `quantity * unit_price` across the order's items.

Storing the total can simplify reporting, but it creates a consistency risk if an order item changes without the stored total being recalculated.

A production implementation should maintain consistency through an appropriately designed transaction, application logic, or database mechanism.

During testing, SQL queries confirmed that the stored totals matched the calculated totals for all three sample orders. This verifies the sample data at the time of testing; it does not guarantee that future changes will remain consistent automatically.

## 7. Limitations of the Current Design

The current schema is a learning prototype and has several limitations:

* An order can exist without any order-item records.
* Inventory quantities are not automatically reduced when an order is placed.
* The `inventory` table supports one inventory record per product, rather than multiple warehouses.
* Payment records are stored, but payment processing and reconciliation are not implemented.
* Stored order totals can become inconsistent with order items unless additional logic maintains them.
* Further analysis of functional dependencies is required to formally demonstrate that every table satisfies 3NF.

These limitations identify areas for future development and do not invalidate the normalisation principles used in the current design.

## 8. Conclusion

The NaijaMart database separates customers, categories, products, orders, order items, payments, inventory, and deliveries into related tables.

The design applies the principles of 1NF, 2NF, and 3NF to reduce unnecessary duplication and improve data organisation. Primary keys, foreign keys, unique constraints, and check constraints also help maintain data integrity.

Further validation and implementation work are needed to address business rules that cannot be enforced by the existing constraints alone.
