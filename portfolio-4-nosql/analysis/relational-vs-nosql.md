# NaijaMart: Relational Databases vs NoSQL

## 1. Introduction

NaijaMart is a fictional Nigerian e-commerce platform used to evaluate database design choices for an online retail system.

The platform needs to manage products, categories, inventory, customers, orders, payments, and other business information.

This analysis compares relational databases with MongoDB, a document-oriented NoSQL database, and evaluates their suitability for different parts of the platform.

## 2. Relational Database Approach

Relational databases organise data into tables containing rows and columns. Relationships between tables can be represented using primary keys and foreign keys.

For example, NaijaMart could use tables such as:

* `products`
* `categories`
* `customers`
* `orders`
* `order_items`
* `payments`
* `inventory`

A product could reference a category using a foreign key. Order items could reference both an order and a product.

### Advantages

1. Relational databases support structured schemas and constraints.
2. Foreign keys help enforce relationships between records.
3. Transactions can preserve consistency across related operations.
4. SQL supports joins and complex reporting queries.
5. Unique constraints can prevent duplicate business identifiers.

### Limitations

1. The schema must be designed carefully as requirements evolve.
2. Retrieving related information may require joins.
3. Representing highly variable product attributes may require additional tables or other modelling techniques.

These are design trade-offs rather than universal disadvantages; relational databases can also support evolving schemas and efficient queries.

## 3. MongoDB Document Database Approach

MongoDB stores data as BSON documents within collections.

A NaijaMart product can contain basic fields such as its name, category, price, and stock quantity, together with an embedded `attributes` document and a `tags` array.

### Advantages

1. Embedded documents group related product information together.
2. Different product categories can have different optional attributes.
3. Documents can be retrieved without joining separate collections when the required data is embedded.
4. MongoDB supports filtering, sorting, projections, and indexes.
5. The model can evolve as product requirements change.

### Limitations

1. Flexible schemas require appropriate validation and governance.
2. Duplicating information across documents can introduce consistency problems.
3. References between separate documents require deliberate modelling.
4. Indexes consume storage and can increase write overhead.
5. Multi-document transactions and complex relationships require careful design.

## 4. Comparison

| Criterion                    | Relational Database                                          | MongoDB                                                           |
| ---------------------------- | ------------------------------------------------------------ | ----------------------------------------------------------------- |
| Data organisation            | Tables                                                       | BSON documents in collections                                     |
| Schema                       | Structured schema with defined columns                       | Flexible document structure, with optional validation             |
| Relationships                | Foreign keys and joins                                       | Embedded documents and references                                 |
| Variable product attributes  | Additional columns or related tables                         | Optional fields and embedded documents                            |
| Transactions                 | Supported                                                    | Supported, including multi-document transactions where configured |
| Query language               | SQL                                                          | MongoDB Query Language                                            |
| Integrity                    | Constraints and relationships can enforce integrity          | Validation and application logic can enforce integrity            |
| Indexing                     | Supports indexes                                             | Supports indexes                                                  |
| Complex relational reporting | Often convenient with joins                                  | May require aggregation pipelines or additional modelling         |
| Best fit                     | Strongly related transactional data and relational reporting | Document-oriented data with suitable access patterns              |

## 5. Suitability for NaijaMart

MongoDB is a reasonable option for the product catalogue because products from different categories can require different attributes.

For example, a computing product may include RAM and storage specifications, while a fashion product may need size and material fields.

During the practical session, the product collection demonstrated embedded attributes, nested-field queries, filtering, sorting, inventory updates, and indexing.

However, this practical work does not establish that MongoDB is superior to relational databases for the entire platform.

Order processing, payments, and inventory allocation across warehouses have important consistency requirements. A relational database could be appropriate for these areas because of its constraints, relationships, and transaction capabilities. MongoDB could also support such workflows if they were carefully designed.

The final choice should depend on business requirements, expected query patterns, consistency needs, scalability requirements, and operational expertise.

## 6. Recommendation

For this portfolio, MongoDB is suitable for demonstrating a flexible, document-oriented product catalogue.

A production NaijaMart system should evaluate its database architecture against measured requirements rather than selecting a technology solely because it is NoSQL.

A hybrid architecture could also be considered, using MongoDB for suitable catalogue workloads and a relational database for strongly related transactional data. Such an approach introduces additional operational complexity and should only be adopted when its benefits justify that cost.

## 7. Conclusion

Relational databases and MongoDB offer different data modelling approaches.

MongoDB provides flexible documents, embedded attributes, and document-oriented queries. Relational databases provide structured relationships, constraints, and established transactional modelling.

For NaijaMart, the most suitable technology depends on the needs of each part of the system. The practical MongoDB implementation demonstrates a viable approach for a product catalogue, while the wider e-commerce platform requires further design and evaluation.

