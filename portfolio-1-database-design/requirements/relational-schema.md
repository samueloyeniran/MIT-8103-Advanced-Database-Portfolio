# NaijaMart Relational Schema

## 1. Overview

NaijaMart is a fictional Nigerian e-commerce platform that sells products such as electronics, computing equipment, and fashion items.

The database is implemented using PostgreSQL. It organises customer information, product catalogues, orders, payments, inventory, and delivery records into related tables.

The relational design uses primary keys, foreign keys, unique constraints, and check constraints to maintain data integrity and represent relationships between business entities.

## 2. Summary of Database Tables

The NaijaMart database contains eight tables. Each table represents a business entity or an association between entities.

| Table         | Purpose                                                                              |
| ------------- | ------------------------------------------------------------------------------------ |
| `customers`   | Stores customer names, email addresses, phone numbers, and registration timestamps.  |
| `categories`  | Stores product category names and descriptions.                                      |
| `products`    | Stores product names, descriptions, catalogue prices, SKUs, and category references. |
| `orders`      | Records customer orders, order dates, statuses, and total amounts.                   |
| `order_items` | Records the products, quantities, and purchase-time prices associated with orders.   |
| `payments`    | Stores payment attempts, amounts, methods, references, and statuses.                 |
| `inventory`   | Tracks the available stock quantity for each product.                                |
| `deliveries`  | Stores delivery addresses, delivery statuses, and relevant timestamps.               |

## 3. Tables and Keys

### 3.1 Customers

* **Primary key:** `customer_id`
* **Unique constraint:** `email`
* **Purpose:** Stores customer information.
* **Relationship:** One customer can have multiple orders.

The unique email constraint prevents two customer records from using the same email address.

### 3.2 Categories

* **Primary key:** `category_id`
* **Unique constraint:** `category_name`
* **Purpose:** Groups products into categories.
* **Relationship:** One category can contain multiple products.

### 3.3 Products

* **Primary key:** `product_id`
* **Foreign key:** `category_id` references `categories(category_id)`
* **Unique constraint:** `sku`
* **Check constraint:** `price >= 0`
* **Purpose:** Stores product information and catalogue prices.

Each product belongs to one category in the current implementation. The SKU uniquely identifies each product within the catalogue.

### 3.4 Orders

* **Primary key:** `order_id`
* **Foreign key:** `customer_id` references `customers(customer_id)`
* **Check constraint:** `total_amount >= 0`
* **Check constraint:** `status` must be one of the permitted order statuses.
* **Purpose:** Records customer orders, order dates, statuses, and total amounts.

Each order belongs to one customer. A customer can have multiple orders.

### 3.5 Order Items

* **Primary key:** `order_item_id`
* **Foreign key:** `order_id` references `orders(order_id)`
* **Foreign key:** `product_id` references `products(product_id)`
* **Unique constraint:** `(order_id, product_id)`
* **Check constraint:** `quantity > 0`
* **Check constraint:** `unit_price >= 0`
* **Purpose:** Records the products and quantities included in each order.

The combination of `order_id` and `product_id` must be unique. Therefore, a product can appear only once as an order-item row within a particular order in the current design.

The `quantity` field records how many units were ordered. The `unit_price` field records the price used when the order item was created.

### 3.6 Payments

* **Primary key:** `payment_id`
* **Foreign key:** `order_id` references `orders(order_id)`
* **Unique constraint:** `payment_reference`
* **Check constraint:** `amount > 0`
* **Check constraint:** `status` must be one of the permitted payment statuses.
* **Purpose:** Records payment attempts, amounts, methods, references, and statuses.

An order can have multiple payment records. This supports recording payment attempts, although additional business rules are required to reconcile payments with order totals.

### 3.7 Inventory

* **Primary key:** `product_id`
* **Foreign key:** `product_id` references `products(product_id)`
* **Default value:** `quantity_in_stock` defaults to zero.
* **Check constraint:** `quantity_in_stock >= 0`
* **Purpose:** Records the stock quantity available for each product.

Using `product_id` as both the primary key and foreign key means that each product can have at most one inventory record.

This design suits the current prototype but would need modification to support multiple warehouses storing the same product.

### 3.8 Deliveries

* **Primary key:** `delivery_id`
* **Foreign key:** `order_id` references `orders(order_id)`
* **Unique constraint:** `order_id`
* **Purpose:** Stores delivery addresses, statuses, and relevant timestamps.

The unique constraint on `order_id` means an order can have at most one delivery record. An order does not have to have a delivery record.

## 4. Relationships Between Tables

The database contains the following relationships:

1. **Customers and Orders:** One customer can place many orders. Each order references one customer.
2. **Categories and Products:** One category can contain many products. Each product references one category.
3. **Orders and Order Items:** One order can contain multiple order items.
4. **Products and Order Items:** One product can appear in multiple order items belonging to different orders.
5. **Orders and Payments:** One order can have multiple payment records.
6. **Products and Inventory:** One product can have at most one inventory record.
7. **Orders and Deliveries:** One order can have at most one delivery record.

### Resolving the Many-to-Many Relationship

An order can contain multiple products, and a product can appear in multiple orders. This creates a many-to-many relationship between orders and products.

The `order_items` table resolves this relationship by storing the association between an order and a product.

It also records the quantity and purchase-time unit price for each order item.

## 5. Integrity Constraints

The schema uses several types of constraints to maintain data integrity.

### Primary Keys

Primary keys uniquely identify records in their respective tables.

For example, `customer_id` identifies a customer, while `product_id` identifies a product.

### Foreign Keys

Foreign keys maintain relationships between related tables and prevent references to parent records that do not exist.

For example, `orders.customer_id` references `customers.customer_id`.

### Unique Constraints

Unique constraints prevent duplicate values where uniqueness is required.

Examples include customer email addresses, product SKUs, category names, payment references, and delivery order IDs.

The composite unique constraint on `(order_id, product_id)` prevents duplicate order-item combinations.

### NOT NULL Constraints

NOT NULL constraints require specified columns to contain values.

For example, required identifiers and business fields must be supplied when records are inserted.

### CHECK Constraints

CHECK constraints restrict values to permitted conditions.

Examples include:

* Product prices cannot be negative.
* Order totals cannot be negative.
* Payment amounts must be greater than zero.
* Order-item quantities must be greater than zero.
* Inventory quantities cannot be negative.
* Order, payment, and delivery statuses must belong to their permitted values.

Together, these constraints help protect the database from invalid records.

## 6. Verification Evidence

The implemented PostgreSQL database was inspected using SQL queries against database metadata.

The checks confirmed the following:

* Eight tables exist in the database.
* Seven foreign-key relationships are defined.
* Eight primary-key constraints exist.
* Six unique constraints exist separately from the primary keys.
* Sample order totals match the totals calculated from their order items.

The six unique constraints are:

1. `customers.email`
2. `categories.category_name`
3. `products.sku`
4. `order_items(order_id, product_id)`
5. `payments.payment_reference`
6. `deliveries.order_id`

These counts describe the current implemented schema.

The order-total comparison confirms that the sample records are consistent at the time of testing. It does not guarantee that stored totals will remain consistent if order items change later.

Supporting evidence is stored in:

`portfolio-1-database-design/evidence/`

## 7. Design Decisions and Limitations

### 7.1 Separate Order Items

The `order_items` table separates individual products from the main order record.

This allows an order to contain multiple products and records the quantity and purchase-time price associated with each product.

### 7.2 Historical Purchase Prices

The `unit_price` field in `order_items` records the price used for a particular order item.

This prevents a later change to the catalogue price in `products` from automatically changing the recorded price of an existing order item.

### 7.3 Inventory Relationship

The `inventory` table uses `product_id` as both its primary key and a foreign key to `products`.

This permits at most one inventory record per product. A future multi-warehouse design would require a different key structure, such as a combination of product and warehouse identifiers.

### 7.4 Payment History

The `payments` table allows multiple payment records for an order.

This can represent payment attempts, but additional application logic or database mechanisms would be needed to enforce business rules governing successful payments, refunds, and order totals.

### 7.5 Stored Order Totals

The `total_amount` field in `orders` stores the order total separately from the amounts calculated from `order_items`.

The current sample data has matching totals. However, changes to order items could cause the stored total to become inconsistent with the calculated total.

Application logic, database triggers, or calculating totals when needed could address this issue, depending on the chosen design.

### 7.6 Other Limitations

The current schema does not automatically guarantee that every order contains at least one order item.

It also does not automatically reduce inventory quantities when orders are placed.

The prototype does not yet implement a complete shopping cart, payment gateway integration, product variants, multi-warehouse inventory management, or a production-grade authorisation system.

These limitations define the scope of the current implementation and identify areas for future development.

## 8. Conclusion

The NaijaMart relational schema organises the main business entities of the fictional e-commerce platform into eight related PostgreSQL tables.

Primary keys, foreign keys, unique constraints, and check constraints support data integrity and enforce important business rules.

The separation of orders and order items supports multi-product orders, while the inventory, payment, and delivery tables represent related operational information.

The implemented schema provides a foundation for the remaining portfolio activities, including query optimisation, transaction and concurrency testing, NoSQL modelling, and distributed or cloud database exercises.

