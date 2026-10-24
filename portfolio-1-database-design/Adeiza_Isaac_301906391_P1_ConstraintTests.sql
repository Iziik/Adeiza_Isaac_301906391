-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. customer pk reject. Expected: pk_customer, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "opened_on")
VALUES (101, 'Casey Example', 'casey.pk@example.test', '2025-04-01');

-- 2. customer unique reject. Expected: uq_customer_0, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "opened_on")
VALUES (9001, 'Casey Example', 'avery.morgan@example.test', '2025-04-02');

-- 3. customer not null reject. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "opened_on")
VALUES (9002, NULL, 'casey.null@example.test', '2025-04-03');

-- 4. account pk reject. Expected: pk_account, SQLSTATE 23505.
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_type", "opened_on", "balance", "status")
VALUES (201, 102, 'checking', '2025-04-04', 10, 'active');

-- 5. account fk reject. Expected: fk_account_0, SQLSTATE 23503.
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_type", "opened_on", "balance", "status")
VALUES (9003, 9999, 'checking', '2025-04-05', 10, 'active');

-- 6. account check reject. Expected: account_balance_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_type", "opened_on", "balance", "status")
VALUES (9004, 101, 'checking', '2025-04-06', -1, 'active');

-- 7. transaction pk reject. Expected: pk_bank_transaction, SQLSTATE 23505.
INSERT INTO portfolio."bank_transaction" ("transaction_id", "account_id", "posted_at", "amount", "transaction_type", "status", "reference")
VALUES (301, 202, '2025-04-07T09:00:00Z', 5, 'deposit', 'posted', 'SYN-PK-REJECT');

-- 8. transaction fk reject. Expected: fk_bank_transaction_0, SQLSTATE 23503.
INSERT INTO portfolio."bank_transaction" ("transaction_id", "account_id", "posted_at", "amount", "transaction_type", "status", "reference")
VALUES (9005, 9999, '2025-04-08T09:00:00Z', 5, 'deposit', 'posted', 'SYN-FK-REJECT');

-- 9. transaction check reject. Expected: transaction_amount_positive, SQLSTATE 23514.
INSERT INTO portfolio."bank_transaction" ("transaction_id", "account_id", "posted_at", "amount", "transaction_type", "status", "reference")
VALUES (9006, 201, '2025-04-09T09:00:00Z', 0, 'deposit', 'posted', 'SYN-CHECK-REJECT');
