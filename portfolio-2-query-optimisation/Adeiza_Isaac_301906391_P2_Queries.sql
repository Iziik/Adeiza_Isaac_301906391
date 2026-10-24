-- Show related customer, account, bank_transaction records (up to 20).
SELECT t0."customer_id" AS "customer_customer_id",
       t0."full_name" AS "customer_full_name",
       t1."account_id" AS "account_account_id",
       t1."account_type" AS "account_account_type",
       t2."transaction_id" AS "bank_transaction_transaction_id",
       t2."posted_at" AS "bank_transaction_posted_at"
FROM portfolio."customer" t0
JOIN portfolio."account" t1 ON t1."customer_id" = t0."customer_id"
JOIN portfolio."bank_transaction" t2 ON t2."account_id" = t1."account_id"
ORDER BY t0."customer_id", t1."account_id", t2."transaction_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."customer_id" AS "customer_customer_id",
       t0."full_name" AS "customer_full_name",
       t1."account_id" AS "account_account_id",
       t1."account_type" AS "account_account_type",
       t2."transaction_id" AS "bank_transaction_transaction_id",
       t2."posted_at" AS "bank_transaction_posted_at"
FROM portfolio."customer" t0
JOIN portfolio."account" t1 ON t1."customer_id" = t0."customer_id"
JOIN portfolio."bank_transaction" t2 ON t2."account_id" = t1."account_id"
ORDER BY t0."customer_id", t1."account_id", t2."transaction_id"
LIMIT 20;

-- Find account records where customer_id matches 101 (up to 20).
SELECT * FROM portfolio."account"
WHERE "customer_id" IS NOT DISTINCT FROM 101
ORDER BY "account_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."account"
WHERE "customer_id" IS NOT DISTINCT FROM 101
ORDER BY "account_id"
LIMIT 20;

-- Count account records for each customer_id (up to 20 groups).
SELECT "customer_id", count(*) AS record_count
FROM portfolio."account"
GROUP BY "customer_id"
ORDER BY record_count DESC, "customer_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "customer_id", count(*) AS record_count
FROM portfolio."account"
GROUP BY "customer_id"
ORDER BY record_count DESC, "customer_id" NULLS LAST
LIMIT 20;
