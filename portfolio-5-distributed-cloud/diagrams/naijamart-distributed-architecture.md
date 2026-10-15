# NaijaMart Distributed Database Architecture

**Status:** Conceptual architecture — not deployed.

## Proposed architecture

```mermaid
flowchart TD
    U["NaijaMart Customers and Staff"] --> APP["NaijaMart Application / API"]
    APP --> ROUTER["Inventory Query Routing"]

    ROUTER --> L["Lagos Warehouse Data"]
    ROUTER --> A["Abuja Warehouse Data"]
    ROUTER --> P["Port Harcourt Warehouse Data"]
    ROUTER --> E["Ekiti Warehouse Data"]

    L --> DB[("Primary PostgreSQL Database")]
    A --> DB
    P --> DB
    E --> DB

    DB -. "Replication" .-> REPLICA[("Read Replica")]
    APP -. "Eligible read queries" .-> REPLICA

    DB --> BACKUP["Database Backups"]
    DB --> MON["Monitoring and Recovery"]
    REPLICA --> MON
```

## Component descriptions

- **Application/API:** Receives customer and staff requests.
- **Query routing:** Represents application logic for locating warehouse inventory.
- **Warehouse data:** Represents four logical warehouse allocations stored in the current database.
- **Primary PostgreSQL database:** The database used for this exercise.
- **Read replica:** A proposed replicated database for eligible read queries; not deployed.
- **Backups and monitoring:** Proposed operational components; not configured.

## Current implementation

PostgreSQL 18 runs on one local server. The implementation contains four warehouses and 16 warehouse inventory records. Inventory totals match the original quantities for all four products.

## Limitations

This diagram presents a proposed architecture, not a deployed distributed system. Separate warehouse database servers, actual data sharding, replication, automatic failover, and cloud database deployment have not been implemented.
