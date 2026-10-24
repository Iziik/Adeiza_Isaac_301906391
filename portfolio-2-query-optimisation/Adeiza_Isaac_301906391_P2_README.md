# Banking accounts and transactions — SQL queries

## 1. Show related customer, account, bank_transaction records (up to 20).

```sql
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
```

| customer_customer_id | customer_full_name | account_account_id | account_account_type | bank_transaction_transaction_id | bank_transaction_posted_at |
| --- | --- | --- | --- | --- | --- |
| 101 | Avery Morgan | 201 | checking | 301 | 2025-03-01T10:15:00+00:00 |
| 102 | Jordan Lee | 202 | savings | 302 | 2025-03-02T11:30:00+00:00 |

## 2. Find account records where customer_id matches 101 (up to 20).

```sql
SELECT * FROM portfolio."account"
WHERE "customer_id" IS NOT DISTINCT FROM 101
ORDER BY "account_id"
LIMIT 20;
```

| account_id | customer_id | account_type | opened_on | balance | status |
| --- | --- | --- | --- | --- | --- |
| 201 | 101 | checking | 2025-01-12 | 150.5 | active |

## 3. Count account records for each customer_id (up to 20 groups).

```sql
SELECT "customer_id", count(*) AS record_count
FROM portfolio."account"
GROUP BY "customer_id"
ORDER BY record_count DESC, "customer_id" NULLS LAST
LIMIT 20;
```

| customer_id | record_count |
| --- | --- |
| 101 | 1 |
| 102 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.482 | 1.386, 1.539, 1.482 | Sort → Seq Scan | 163 |
| After index | 0.17 | 0.171, 0.17, 0.167 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 30 |

The median execution time changed from 1.482 ms to 0.17 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.359..1.36 rows=25 loops=1)
  Seq Scan on bank_transaction (actual time=0.014..1.326 rows=25 loops=1)
Planning Time: 0.364 ms
Execution Time: 1.386 ms
```

### Before index, run 2

```text
Sort (actual time=1.51..1.512 rows=25 loops=1)
  Seq Scan on bank_transaction (actual time=0.014..1.477 rows=25 loops=1)
Planning Time: 0.355 ms
Execution Time: 1.539 ms
```

### Before index, run 3

```text
Sort (actual time=1.425..1.427 rows=25 loops=1)
  Seq Scan on bank_transaction (actual time=0.016..1.387 rows=25 loops=1)
Planning Time: 0.466 ms
Execution Time: 1.482 ms
```

### After index, run 1

```text
Sort (actual time=0.128..0.13 rows=25 loops=1)
  Bitmap Heap Scan on bank_transaction (actual time=0.026..0.093 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.014 rows=25 loops=1)
Planning Time: 0.568 ms
Execution Time: 0.171 ms
```

### After index, run 2

```text
Sort (actual time=0.127..0.129 rows=25 loops=1)
  Bitmap Heap Scan on bank_transaction (actual time=0.025..0.093 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.014 rows=25 loops=1)
Planning Time: 0.549 ms
Execution Time: 0.17 ms
```

### After index, run 3

```text
Sort (actual time=0.124..0.126 rows=25 loops=1)
  Bitmap Heap Scan on bank_transaction (actual time=0.024..0.091 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.014 rows=25 loops=1)
Planning Time: 0.534 ms
Execution Time: 0.167 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Adeiza_Isaac_301906391_P2_Queries.sql, then Adeiza_Isaac_301906391_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Adeiza_Isaac_301906391_P2_QueryResults.png) · [Index comparison](screenshots/Adeiza_Isaac_301906391_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

