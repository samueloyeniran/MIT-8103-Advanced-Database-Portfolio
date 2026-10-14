# Portfolio 3: Transactions and Concurrency

## 1. Introduction

This portfolio investigates transaction management and concurrency control in PostgreSQL using the NaijaMart e-commerce case study. The experiments demonstrate transaction commitment, rollback, transaction isolation, and protection against competing inventory updates.

Separate demonstration tables were used to avoid modifying the original NaijaMart business records.

## 2. COMMIT Experiment

The first experiment updated the amount in `transaction_demo` from 100.00 to 150.00 inside a transaction.

The transaction began with `BEGIN`, performed the update, and used `COMMIT` to save the change. A subsequent query confirmed that the amount remained 150.00.

**Result:** The transaction committed successfully, and the updated value persisted.

**Business relevance:** NaijaMart needs to commit valid database changes so that successful operations are retained.

## 3. ROLLBACK Experiment

The second experiment attempted to change the demonstration amount from 150.00 to 999.00. The update was executed inside a transaction, but `ROLLBACK` was issued instead of `COMMIT`.

The final query showed that the amount was still 150.00.

**Result:** The uncommitted update was undone.

**Business relevance:** Rollback allows a database transaction to abandon changes when an operation cannot be completed as intended. External payment operations require their own compensation or reconciliation mechanisms because a database rollback cannot reverse an external payment automatically.

## 4. Transaction Isolation Experiment

Two PostgreSQL sessions were used to investigate the `READ COMMITTED` isolation level.

Session A began a transaction and read an amount of 200.00. Session B then updated the amount to 250.00 and committed the change. A subsequent query in Session A returned 250.00.

**Result:** The later query in Session A observed the value committed by Session B.

**Interpretation:** Under PostgreSQL's `READ COMMITTED` isolation level, each query sees data committed before that query begins. This experiment demonstrates committed-data visibility, rather than a complete comparison of all isolation levels.

## 5. Concurrency Control Experiment

A separate `concurrency_demo` table was created with one test product and a stock quantity of one. Two database sessions attempted to decrement the stock using a conditional update:

```sql
UPDATE concurrency_demo
SET stock = stock - 1
WHERE product_id = 1
  AND stock > 0;
```

Session A updated the row and held its row-level lock until its transaction committed. Session B's competing update waited. After Session A committed, Session B's update affected zero rows because the stock condition was no longer satisfied.

The final query returned a stock quantity of zero.

**Result:** Only one transaction successfully decremented the final unit in this experiment. The stock did not become negative.

**Business relevance:** A conditional inventory update combined with PostgreSQL's row-level locking can prevent competing purchase attempts from decrementing the same final unit more than once. An application should also check the number of rows affected and treat an update affecting zero rows as an unsuccessful reservation.

The table's `CHECK (stock >= 0)` constraint provides an additional database-level safeguard against negative stock.

## 6. Evidence

The execution evidence is stored in the `evidence/` directory:

* `commit-transaction.txt` — COMMIT experiment output.
* `rollback-transaction.txt` — ROLLBACK experiment output.
* `isolation-setup.txt` — isolation demonstration table state.
* `concurrency-final-stock.txt` — final inventory state after the concurrency experiment.

The SQL scripts used for setup and experimentation are stored in `sql/`.

## 7. Limitations

The experiments use small demonstration tables and a local PostgreSQL instance. They demonstrate transaction behaviour but do not measure performance under production workloads.

The isolation experiment examines `READ COMMITTED` visibility only. It does not compare `REPEATABLE READ` and `SERIALIZABLE`, nor does it demonstrate every possible concurrency anomaly.

The concurrency experiment demonstrates conditional inventory updates with row-level locking. It does not test a complete checkout process involving orders, payments, and external services.

## 8. Conclusion

The experiments demonstrate that PostgreSQL supports committed transactions, rollback of uncommitted changes, visibility rules under `READ COMMITTED`, and row-level locking during competing updates.

These mechanisms are important for maintaining reliable data in an e-commerce system. Correct transaction design must be combined with suitable constraints, application-level checks, and appropriate handling of failed operations.

