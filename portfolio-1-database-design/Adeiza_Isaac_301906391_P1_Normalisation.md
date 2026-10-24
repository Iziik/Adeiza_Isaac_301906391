# Banking accounts and transactions — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| customer_id | account records (list) |
| --- | --- |
| 101 | [201] |
| 102 | [202] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| account.account_id | account.customer_id | account.account_type | customer.customer_id | customer.full_name |
| --- | --- | --- | --- | --- |
| 201 | 101 | checking | 101 | Avery Morgan |
| 202 | 102 | savings | 102 | Jordan Lee |

Key: account_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## account_example

| account.account_id | account.customer_id | account.account_type | customer.customer_id | customer.full_name |
| --- | --- | --- | --- | --- |
| 201 | 101 | checking | 101 | Avery Morgan |
| 202 | 102 | savings | 102 | Jordan Lee |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## customer

| customer_id | full_name | email | opened_on |
| --- | --- | --- | --- |
| 101 | Avery Morgan | avery.morgan@example.test | 2025-01-10 |
| 102 | Jordan Lee | jordan.lee@example.test | 2025-02-14 |

## account

| account_id | customer_id | account_type | opened_on | balance | status |
| --- | --- | --- | --- | --- | --- |
| 201 | 101 | checking | 2025-01-12 | 150.5 | active |
| 202 | 102 | savings | 2025-02-16 | 800 | active |

## bank_transaction

| transaction_id | account_id | posted_at | amount | transaction_type | status | reference |
| --- | --- | --- | --- | --- | --- | --- |
| 301 | 201 | 2025-03-01T10:15:00+00:00 | 50.5 | deposit | posted | SYN-DEP-001 |
| 302 | 202 | 2025-03-02T11:30:00+00:00 | 20 | withdrawal | posted | SYN-WDR-001 |

## Dependencies

- customer: (customer_id) → full_name, email, opened_on
- account: (account_id) → customer_id, account_type, opened_on, balance, status
- bank_transaction: (transaction_id) → account_id, posted_at, amount, transaction_type, status, reference

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
