# Portfolio 4: NoSQL Database Implementation

## Project Title

**NaijaMart: NoSQL Database Design and Implementation**

## 1. Project Overview

NaijaMart is a fictional Nigerian e-commerce platform used as a case study for exploring NoSQL database design and implementation.

The platform requires a flexible way to represent products from different categories, including computing devices, phones, fashion items, home appliances, and accessories.

This portfolio explores MongoDB's document-oriented data model and demonstrates how it can support product catalogue queries, nested attributes, inventory updates, and indexing.

All product names, prices, and stock quantities used in the practical exercises are synthetic sample data.

## 2. Database Technology

* **Database:** MongoDB
* **Version used:** 9.0.4
* **Query interface:** MongoDB Shell (`mongosh`)
* **Database name:** `naijamart`
* **Collection:** `products`
* **Development environment:** Ubuntu on WSL2

## 3. Objectives

The objectives of this portfolio are to:

1. Explain the document-oriented NoSQL data model.
2. Represent e-commerce products as BSON documents.
3. Demonstrate queries using filters, comparison operators, projections, and sorting.
4. Demonstrate nested documents and flexible product attributes.
5. Perform inventory updates and verify their results.
6. Create an index and inspect a query execution plan.
7. Discuss the suitability of MongoDB for the NaijaMart product catalogue.
8. Compare document-oriented storage with a relational database approach.

## 4. Repository Structure

```text
portfolio-4-nosql/
├── README.md
├── analysis/
│   └── relational-vs-nosql.md
├── data/
│   └── products.json
├── evidence/
│   └── mongodb-practical-session.md
├── model/
│   └── document-model.md
└── scripts/
    └── product-queries.js
```

The files listed above describe the intended deliverables. They will be added and verified as the portfolio progresses.

## 5. Practical Work Completed

The MongoDB practical session has demonstrated:

* Inserting and counting product documents.
* Filtering products by category, price, and stock.
* Sorting products by price and limiting query results.
* Querying nested product attributes.
* Updating product stock quantities.
* Adding optional attributes to an existing document.
* Creating an index on `productId`.
* Examining query execution statistics to confirm index use.

The practical evidence is recorded in `evidence/mongodb-practical-session.md`.

## 6. Initial Design Rationale

MongoDB stores records as documents, making it possible to group related product information within a single document.

For NaijaMart, this approach can be useful because different categories require different attributes. For example, a laptop may have RAM and storage fields, while a fashion product may require size and material attributes.

The flexible document model can accommodate such differences. However, flexibility does not remove the need for validation, appropriate indexes, data consistency, and careful design of relationships between products, inventory, orders, and customers.

## 7. Limitations

This practical implementation focuses on the product catalogue and selected inventory operations.

It does not yet represent a complete production e-commerce database. Authentication, orders, payments, warehouse relationships, and other business processes would require additional modelling and testing.

The sample dataset is synthetic and must not be interpreted as real commercial inventory.

## 8. Conclusion

This portfolio demonstrates practical use of MongoDB for a document-oriented e-commerce product catalogue. The exercises provide a basis for evaluating NoSQL modelling choices, query behaviour, indexing, and the trade-offs between document databases and relational databases.

