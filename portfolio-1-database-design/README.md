# Portfolio 1: Database Design and Modelling

## 1. Project Overview

This portfolio develops the relational database foundation for NaijaMart, a fictional Nigerian e-commerce platform. The design supports customers, product catalogues, orders, payments, inventory, and deliveries.

**Database:** PostgreSQL  
**Case Study:** NaijaMart E-commerce Platform

## 2. Database Schema

The design contains eight principal tables:

- `customers` — customer information.
- `categories` — product categories.
- `products` — product details and prices.
- `orders` — customer order records.
- `order_items` — products and quantities associated with orders.
- `payments` — payment records associated with orders.
- `inventory` — product stock quantities.
- `deliveries` — delivery information for orders.

Primary keys uniquely identify records, while foreign keys connect related tables. Unique and check constraints help enforce data integrity.

Examples include unique customer email addresses, unique product SKUs, positive order-item quantities, and non-negative inventory quantities.

## 3. Normalisation and Requirements

The `requirements/` directory contains the business requirements, relational schema description, and normalisation notes.

The normalisation document discusses First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF). A more formal functional-dependency analysis would strengthen the demonstration.

## 4. SQL Implementation

The `sql/` directory contains scripts for creating the schema and inserting sample data, including orders, payments, and deliveries.

Review the scripts in dependency order where necessary: create the schema before inserting records that depend on its tables and relationships.

## 5. Evidence and Verification

The `evidence/` directory contains saved database outputs used to inspect the implementation, including:

- Table and record listings.
- Primary-key, unique, foreign-key, and check-constraint evidence.
- Product inventory and order-detail reports.
- Comparisons between stored and calculated order totals.

The sample order-total checks showed matching stored and calculated totals.

## 6. Limitations and Future Improvements

This is an academic database model rather than a complete production e-commerce system.

Known limitations include:

- Inventory is not automatically reduced when an order is placed.
- An order may exist without associated order items.
- Inventory does not yet support multiple warehouses in this initial model.
- Stored order totals could become inconsistent if order items are subsequently changed.
- Production authentication, authorisation, and payment gateway integration are outside the current scope.

Future work could introduce transactional order processing, automated stock updates, more formal normalisation proofs, and expanded inventory management.

## 7. Conclusion

This portfolio establishes a relational foundation for the NaijaMart case study. It demonstrates schema creation, relationships, integrity constraints, sample data insertion, and verification through SQL queries and saved evidence.
