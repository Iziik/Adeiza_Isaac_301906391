# Portfolio 1 — Database Design and Modelling

I organised the data into customer, account, bank_transaction. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| customer | 2 |
| account | 2 |
| bank_transaction | 2 |

The 9 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Adeiza_Isaac_301906391_P1_Design.md)
- [ER diagram](Adeiza_Isaac_301906391_P1_ERDiagram.md)
- [Normalisation](Adeiza_Isaac_301906391_P1_Normalisation.md)
- [Schema](Adeiza_Isaac_301906391_P1_Schema.sql)
- [Sample data](Adeiza_Isaac_301906391_P1_SampleData.sql)
- [Constraint tests](Adeiza_Isaac_301906391_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Adeiza_Isaac_301906391_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

