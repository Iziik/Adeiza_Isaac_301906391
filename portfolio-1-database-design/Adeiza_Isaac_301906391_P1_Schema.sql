-- Banking accounts and transactions: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."customer" (
  "customer_id" bigint NOT NULL,
  "full_name" text NOT NULL,
  "email" text NOT NULL,
  "opened_on" date NOT NULL,
  CONSTRAINT "pk_customer" PRIMARY KEY ("customer_id"),
  CONSTRAINT "uq_customer_0" UNIQUE ("email")
);
CREATE TABLE portfolio."account" (
  "account_id" bigint NOT NULL,
  "customer_id" bigint NOT NULL,
  "account_type" text NOT NULL,
  "opened_on" date NOT NULL,
  "balance" numeric(18,2) NOT NULL,
  "status" text NOT NULL,
  CONSTRAINT "pk_account" PRIMARY KEY ("account_id")
);
CREATE TABLE portfolio."bank_transaction" (
  "transaction_id" bigint NOT NULL,
  "account_id" bigint NOT NULL,
  "posted_at" timestamptz NOT NULL,
  "amount" numeric(18,2) NOT NULL,
  "transaction_type" text NOT NULL,
  "status" text NOT NULL,
  "reference" text NOT NULL,
  CONSTRAINT "pk_bank_transaction" PRIMARY KEY ("transaction_id")
);
ALTER TABLE portfolio."account" ADD CONSTRAINT "fk_account_0" FOREIGN KEY ("customer_id") REFERENCES portfolio."customer" ("customer_id");
ALTER TABLE portfolio."bank_transaction" ADD CONSTRAINT "fk_bank_transaction_0" FOREIGN KEY ("account_id") REFERENCES portfolio."account" ("account_id");
ALTER TABLE portfolio."account" ADD CONSTRAINT "account_balance_nonnegative" CHECK ("balance" >= 0);
ALTER TABLE portfolio."bank_transaction" ADD CONSTRAINT "transaction_amount_positive" CHECK ("amount" > 0);
COMMIT;
