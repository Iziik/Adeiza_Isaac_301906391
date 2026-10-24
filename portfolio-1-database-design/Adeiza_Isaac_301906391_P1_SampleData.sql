-- Fictional sample records for Banking accounts and transactions.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "opened_on") VALUES (101, 'Avery Morgan', 'avery.morgan@example.test', '2025-01-10');
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "opened_on") VALUES (102, 'Jordan Lee', 'jordan.lee@example.test', '2025-02-14');
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_type", "opened_on", "balance", "status") VALUES (201, 101, 'checking', '2025-01-12', 150.5, 'active');
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_type", "opened_on", "balance", "status") VALUES (202, 102, 'savings', '2025-02-16', 800, 'active');
INSERT INTO portfolio."bank_transaction" ("transaction_id", "account_id", "posted_at", "amount", "transaction_type", "status", "reference") VALUES (301, 201, '2025-03-01T10:15:00Z', 50.5, 'deposit', 'posted', 'SYN-DEP-001');
INSERT INTO portfolio."bank_transaction" ("transaction_id", "account_id", "posted_at", "amount", "transaction_type", "status", "reference") VALUES (302, 202, '2025-03-02T11:30:00+00:00', 20, 'withdrawal', 'posted', 'SYN-WDR-001');
COMMIT;
