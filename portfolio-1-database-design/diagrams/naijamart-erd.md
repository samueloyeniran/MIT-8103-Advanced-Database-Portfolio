# NaijaMart Entity-Relationship Diagram

This diagram represents the eight tables implemented in the NaijaMart PostgreSQL database and their relationships.

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : places
    CATEGORIES ||--o{ PRODUCTS : contains
    ORDERS ||--o{ ORDER_ITEMS : includes
    PRODUCTS ||--o{ ORDER_ITEMS : appears_in
    ORDERS ||--o{ PAYMENTS : has
    PRODUCTS ||--o| INVENTORY : has
    ORDERS ||--o| DELIVERIES : has

    CUSTOMERS {
        bigint customer_id PK
        varchar first_name
        varchar last_name
        varchar email UK
        varchar phone
    }

    CATEGORIES {
        bigint category_id PK
        varchar category_name UK
        text description
    }

    PRODUCTS {
        bigint product_id PK
        bigint category_id FK
        varchar product_name
        numeric price
        varchar sku UK
        boolean is_active
    }

    ORDERS {
        bigint order_id PK
        bigint customer_id FK
        timestamptz order_date
        varchar status
        numeric total_amount
    }

    ORDER_ITEMS {
        bigint order_item_id PK
        bigint order_id FK
        bigint product_id FK
        integer quantity
        numeric unit_price
    }

    PAYMENTS {
        bigint payment_id PK
        bigint order_id FK
        numeric amount
        varchar payment_method
        varchar status
        varchar payment_reference UK
    }

    INVENTORY {
        bigint product_id PK, FK
        integer quantity_in_stock
        timestamptz updated_at
    }

    DELIVERIES {
        bigint delivery_id PK
        bigint order_id FK, UK
        text delivery_address
        varchar delivery_status
        timestamptz dispatched_at
        timestamptz delivered_at
    }
```

**Constraint note:** The `order_items` table has a composite unique constraint on (`order_id`, `product_id`). This prevents the same product from appearing in multiple order-item rows for the same order. Neither column is independently unique.
