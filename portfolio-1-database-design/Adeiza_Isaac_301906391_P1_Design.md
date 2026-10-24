# Banking accounts and transactions — database design

My case study records customer, account, bank_transaction.

## Users

- Bank staff reviewing customer accounts and transaction activity
- Students analyzing database design and query behavior

## Main operations

- Open customer accounts and record account details.
- Post deposits and withdrawals while maintaining each account balance.
- Review transaction activity and summarize posted amounts.
- Benchmark filtering transactions by status with and without a B-tree index using 25000 synthetic rows; compare the planned and observed query behavior without treating the discussion as a measured result.

## Entities

| Entity | Information stored |
| --- | --- |
| customer | Stores synthetic customer identity and onboarding details. |
| account | Stores an account, its owning customer, current balance, and lifecycle status. |
| bank_transaction | Records posted or reversed deposits and withdrawals for an account. |

## customer

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| customer_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| opened_on | DATE |  | Yes |
- Unique key: (email).

## account

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| account_id | BIGINT | PK | Yes |
| customer_id | BIGINT | FK | Yes |
| account_type | TEXT |  | Yes |
| opened_on | DATE |  | Yes |
| balance | NUMERIC(18,2) |  | Yes |
| status | TEXT |  | Yes |
- customer_id → customer.customer_id

## bank_transaction

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| transaction_id | BIGINT | PK | Yes |
| account_id | BIGINT | FK | Yes |
| posted_at | TIMESTAMPTZ |  | Yes |
| amount | NUMERIC(18,2) |  | Yes |
| transaction_type | TEXT |  | Yes |
| status | TEXT |  | Yes |
| reference | TEXT |  | Yes |
- account_id → account.account_id

## Relationships and business rules

- Each customer email identifies at most one customer.
- Every account references an existing customer.
- An account balance must be zero or greater, preventing overdrafts.
- Every transaction references an existing account.
- Every transaction amount must be greater than zero.

## Assumptions

- Each account belongs to exactly one customer; a customer may own multiple accounts.
- Transactions are deposits or withdrawals with positive amounts. A withdrawal may not make an account balance negative.
- For a normalization exercise, use account as the foreign-key-bearing root: keep customer attributes in customer and account attributes in account, with one customer role and no repeated customer details in account rows.
- All names, identifiers, and records used in the exercise are synthetic.

