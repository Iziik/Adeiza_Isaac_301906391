# Banking accounts and transactions — ER diagram

```mermaid
erDiagram
    direction LR
    customer {
        bigint customer_id PK
        text full_name
        text email UK
        date opened_on
    }
    account {
        bigint account_id PK
        bigint customer_id FK
        text account_type
        date opened_on
        numeric balance
        text status
    }
    bank_transaction {
        bigint transaction_id PK
        bigint account_id FK
        timestamptz posted_at
        numeric amount
        text transaction_type
        text status
        text reference
    }
    customer ||--o{ account : "customer_id"
    account ||--o{ bank_transaction : "account_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Adeiza_Isaac_301906391_ERDiagram.png)
