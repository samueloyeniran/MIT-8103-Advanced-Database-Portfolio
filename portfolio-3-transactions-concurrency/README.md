# Portfolio 3: Transactions and Concurrency

## 1. Overview

This portfolio investigates transaction management and concurrency control using PostgreSQL and the NaijaMart e-commerce case study.

The experiments demonstrate:

* Committing changes using `COMMIT`.
* Reversing uncommitted changes using `ROLLBACK`.
* Observing committed data under the `READ COMMITTED` isolation level.
* Controlling competing inventory updates using conditional updates and row-level locking.

All experiments use dedicated demonstration tables to avoid modifying the original NaijaMart business records.

## 2. Technologies

* PostgreSQL 18.6
* SQL
* Ubuntu Linux running in WSL

## 3. Directory Structure

```text
portfolio-3-transactions-concurrency/
├── README.md
├── analysis/
│   └── transaction-analysis.md
├── evidence/
│   ├── commit-transaction.txt
│   ├── rollback-transaction.txt
│   ├── isolation-setup.txt
│   └── concurrency-final-stock.txt
├── experiments/
└── sql/
    ├── 01_transaction_setup.sql
    ├── 02_commit_transaction.sql
    ├── 03_rollback_transaction.sql
    ├── 04_isolation_setup.sql
    └── 05_concurrency_setup.sql
```

## 4. Experiments

### Experiment 1: COMMIT

The `transaction_demo` table was updated from 100.00 to 150.00 inside a transaction. The change was committed and verified with a subsequent query.

### Experiment 2: ROLLBACK

An update attempted to change the amount from 150.00 to 999.00. The transaction was rolled back, and the final value remained 150.00.

### Experiment 3: READ COMMITTED

Two database sessions were used. Session A read an amount of 200.00. Session B changed it to 250.00 and committed. A subsequent query in Session A observed 250.00.

### Experiment 4: Concurrent Inventory Updates

A test product began with one unit in stock. Session A decremented the stock and held the row lock. Session B's conditional update waited. After Session A committed, Session B updated zero rows because the stock was no longer greater than zero.

The final stock quantity was zero.

## 5. Reproducing the Experiments

Connect to the existing NaijaMart database using a PostgreSQL account with the necessary privileges.

From this directory, execute the setup scripts:

```bash
sudo -u postgres psql -d naijamart -v ON_ERROR_STOP=1 -f sql/01_transaction_setup.sql
sudo -u postgres psql -d naijamart -v ON_ERROR_STOP=1 -f sql/04_isolation_setup.sql
sudo -u postgres psql -d naijamart -v ON_ERROR_STOP=1 -f sql/05_concurrency_setup.sql
```

Then run the transaction demonstrations:

```bash
sudo -u postgres psql -d naijamart -v ON_ERROR_STOP=1 -f sql/02_commit_transaction.sql
sudo -u postgres psql -d naijamart -v ON_ERROR_STOP=1 -f sql/03_rollback_transaction.sql
```

The isolation and concurrency experiments require two separate interactive PostgreSQL sessions. Follow `analysis/transaction-analysis.md` for their observed results and interpretation.

The scripts use existing demonstration records when rerun. Reset the relevant demonstration data to its initial state before repeating experiments if you want to reproduce the original sequence exactly.

## 6. Evidence and Analysis

The `evidence/` directory contains captured SQL output. The `analysis/transaction-analysis.md` document explains the results, their business relevance, and the limitations of the experiments.

## 7. Limitations

The experiments use small local demonstration tables rather than production-scale data. They illustrate transaction behaviour and concurrency control but do not benchmark performance or implement a complete order-and-payment workflow.

## 8. Conclusion

The experiments demonstrate how PostgreSQL commits changes, rolls back uncommitted updates, exposes committed data under `READ COMMITTED`, and coordinates competing updates using row-level locking.

These techniques help maintain data integrity in an e-commerce database.

