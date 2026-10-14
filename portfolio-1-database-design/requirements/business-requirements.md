# NaijaMart E-Commerce Database: Business Requirements

## 1. Business Overview

NaijaMart is a fictional Nigerian e-commerce platform that sells products such as electronics, computing equipment, and fashion items.

The platform needs a relational database to organise customer information, product catalogues, orders, payments, inventory, and delivery records.

PostgreSQL is used to implement the database because it supports relational modelling, integrity constraints, joins, transactions, and SQL-based reporting.

## 2. Database Users and Stakeholders

The NaijaMart database is intended to support several business roles:

* **Customers:** Place orders and access information about their purchases.
* **Catalogue staff:** Maintain product details, prices, and categories.
* **Order-processing staff:** Review orders and update order statuses.
* **Inventory staff:** Monitor product stock levels and availability.
* **Payment staff:** Review payment records and payment statuses.
* **Management:** Use business reports to monitor orders, sales, and inventory.
* **Database administrators:** Maintain the database, manage database access, and monitor performance.

These roles describe the intended users of the NaijaMart system. The current prototype implements the underlying database structure; it does not yet implement separate application accounts or role-based access controls for these business users.

## 3. Problem Statement

An e-commerce business must manage information about customers, products, purchases, stock, payments, and deliveries in a consistent manner.

If these records are poorly organised, the business may encounter duplicated data, inaccurate order totals, invalid stock quantities, and difficulty producing reliable sales reports.

NaijaMart therefore requires a structured database that separates business entities while maintaining the relationships between them.

## 4. Functional Requirements

The database should support the following operations:

1. Register and store customer information.
2. Organise products into categories.
3. Store product names, descriptions, prices, and unique stock-keeping units.
4. Record customer orders and their statuses.
5. Record the products, quantities, and purchase-time prices associated with each order.
6. Record payment amounts, methods, references, and statuses.
7. Track the stock quantity available for each product.
8. Store delivery addresses and delivery statuses.
9. Retrieve order details alongside customer and product information.
10. Produce reports that support order monitoring, sales analysis, and inventory management.

## 5. Business Rules

* Each customer has a unique customer ID and email address.
* Each product belongs to one category in the initial implementation.
* Each product has a unique stock-keeping unit (SKU).
* Each order belongs to one customer.
* An order may contain multiple order items.
* Each order item references one product and one order.
* The same product can appear in different orders.
* The combination of order ID and product ID must be unique in the `order_items` table.
* Each order can have multiple payment records.
* Each product can have at most one inventory record.
* Each order can have at most one delivery record.
* Product prices, order totals, and payment amounts cannot be negative; payment amounts must be greater than zero.
* Order-item quantities must be greater than zero.
* Inventory quantities cannot be negative.
* Order, payment, and delivery statuses must belong to the values permitted by the database schema.

## 6. Scope and Assumptions

This implementation is a practical database prototype, not a complete production e-commerce application.

The initial scope includes customers, categories, products, orders, order items, payments, inventory, and deliveries.

The design assumes one category per product, one inventory record per product, and at most one delivery record per order.

Multiple payment records are allowed for an order to represent payment attempts.

The prototype does not yet implement a complete shopping cart, payment gateway integration, warehouse management, multiple product variants, or a production-grade authorisation system.

The current schema also does not automatically guarantee that every order contains at least one item or that inventory is reduced when an order is placed. These requirements would need additional application logic or database mechanisms.

## 7. Reporting Requirements

The database should support queries to:

* List products alongside their categories and available stock.
* Retrieve orders with customer and product details.
* Review payment statuses.
* Review delivery statuses.
* Calculate order totals from order items.
* Compare stored order totals with calculated totals.
* Identify products with low stock.
* Summarise sales using appropriate payment and order-status rules.

## 8. Technology Choice

PostgreSQL was selected as the relational database management system (RDBMS) for the NaijaMart project.

Its support for primary keys, foreign keys, unique constraints, check constraints, and transactions helps enforce data integrity and supports the practical exercises required for this project.

The database is being developed and tested in an Ubuntu environment using SQL and PostgreSQL command-line tools.

## 9. Conclusion

The NaijaMart requirements establish the business needs and scope used to develop the relational schema.

The resulting design separates key business entities into eight tables and uses constraints and relationships to maintain consistency.

The database will be further evaluated through query optimisation, transaction testing, NoSQL modelling, and distributed or cloud database exercises in the subsequent portfolio activities.

