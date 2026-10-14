# MIT 8103 Advanced Database Systems Portfolio

## Project Title

**NaijaMart: Database Design, Implementation, and Optimisation for an E-Commerce Platform**

## 1. Project Overview

NaijaMart is a fictional Nigerian e-commerce platform used as a case study for the MIT 8103 Advanced Database Systems continuous assessment.

The project explores how database technologies can support an e-commerce business that manages customers, products, categories, orders, payments, inventory, and deliveries.

The primary relational database management system used in the project is PostgreSQL.

The portfolio combines database design, SQL implementation, query optimisation, transaction management, NoSQL modelling, and distributed or cloud database concepts.

## 2. Business Problem

An e-commerce platform needs to store and retrieve business information accurately.

Poor database design can lead to duplicated records, inconsistent order totals, invalid stock quantities, and difficulties generating reports.

NaijaMart provides a practical case study for designing a structured database, enforcing data integrity, testing SQL queries, and investigating approaches to performance, concurrency, and scalability.

## 3. Technology Stack

* **PostgreSQL:** Relational database implementation.
* **SQL:** Database schema creation, data insertion, reporting, and testing.
* **Ubuntu on WSL:** Linux development environment.
* **Git and GitHub:** Version control and portfolio management.
* **VS Code:** Source-code and documentation editing.

Additional technologies may be introduced as the NoSQL and distributed/cloud database exercises progress.

## 4. Database Implementation

The current PostgreSQL implementation contains eight tables:

1. `customers` — customer information.
2. `categories` — product categories.
3. `products` — product catalogue and prices.
4. `orders` — customer orders and order statuses.
5. `order_items` — products and quantities associated with orders.
6. `payments` — payment records and statuses.
7. `inventory` — available stock quantities.
8. `deliveries` — delivery addresses and statuses.

Primary keys, foreign keys, unique constraints, and check constraints are used to enforce important data-integrity rules.

The implementation also includes illustrative sample data for testing database queries and relationships.

## 5. Portfolio Components

### Portfolio 1: Database Design and Implementation

Focus areas:

* Business requirements and assumptions.
* Entity-relationship modelling.
* Relational schema design.
* Primary keys, foreign keys, and integrity constraints.
* Database normalisation.
* PostgreSQL implementation and verification.

Location: `portfolio-1-database-design/`

### Portfolio 2: SQL Queries and Query Optimisation

Planned focus areas:

* SQL queries for business reporting.
* Query execution plans.
* Indexing experiments.
* Query performance analysis and optimisation.

Location: `portfolio-2-query-optimisation/`

### Portfolio 3: Transactions and Concurrency

Planned focus areas:

* Transaction execution.
* Commit and rollback.
* Transaction isolation.
* Concurrency problems and controls.

Location: `portfolio-3-transactions-concurrency/`

### Portfolio 4: NoSQL Database Modelling

Planned focus areas:

* Modelling NaijaMart data for a NoSQL database.
* Implementing and testing the model.
* Comparing relational and NoSQL approaches.
* Explaining the suitability and trade-offs of the chosen model.

Location: `portfolio-4-nosql/`

### Portfolio 5: Distributed and Cloud Databases

Planned focus areas:

* Distributed database concepts.
* Replication, sharding, availability, and consistency.
* A practical configuration, deployment, or experiment appropriate to the assignment.

Location: `portfolio-5-distributed-cloud/`

*The status of each component will be updated as implementation and evidence are completed.*

## 6. Repository Structure

```text
MIT-8103-Advanced-Database-Portfolio/
├── README.md
├── portfolio-1-database-design/
│   ├── diagrams/
│   ├── evidence/
│   ├── requirements/
│   └── sql/
├── portfolio-2-query-optimisation/
│   ├── evidence/
│   ├── execution-plans/
│   └── sql/
├── portfolio-3-transactions-concurrency/
│   ├── evidence/
│   ├── experiments/
│   └── sql/
├── portfolio-4-nosql/
│   ├── evidence/
│   ├── implementation/
│   └── models/
├── portfolio-5-distributed-cloud/
│   ├── architecture/
│   ├── configuration/
│   └── evidence/
└── final-documentation/
    ├── evidence/
    ├── references/
    └── report/
```

## 7. Running the PostgreSQL Schema

The following instructions assume PostgreSQL is installed and running in the development environment.

Open the project directory:

```bash
cd ~/MIT-8103-Advanced-Database-Portfolio
```

Connect to the NaijaMart database:

```bash
sudo -u postgres psql -d naijamart
```

To inspect the database tables, run this command inside the PostgreSQL prompt:

```sql
\dt
```

To exit PostgreSQL:

```sql
\q
```

The schema and sample-data SQL scripts are stored in:

`portfolio-1-database-design/sql/`

Review each SQL file before executing it. Sample-data scripts are intended for the current example dataset and may need adjustment before being rerun against a database that already contains records.

## 8. Evidence and Documentation

Implementation evidence is stored in the relevant portfolio's `evidence/` directory.

The portfolio aims to include actual query outputs, database verification results, execution plans, transaction experiments, and implementation screenshots where required.

Final documentation will be maintained in `final-documentation/`.

Evidence will be added as each activity is completed. Planned activities will not be presented as completed implementations.

## 9. Learning Objectives

Through this project, I aim to develop practical skills in:

* Relational database design and normalisation.
* SQL querying and reporting.
* Data integrity and constraint enforcement.
* Query execution plans and indexing.
* Transactions and concurrency control.
* NoSQL data modelling.
* Distributed database concepts.
* Technical documentation and evidence-based analysis.

## 10. Conclusion

NaijaMart serves as a practical case study for exploring database design and advanced database systems in an e-commerce context.

The project will be developed incrementally, with implementation evidence, explanations of design decisions, identified limitations, and reflections on the results.

The final portfolio will distinguish completed experiments from planned work and will document the technologies, methods, and findings used throughout the assessment.

