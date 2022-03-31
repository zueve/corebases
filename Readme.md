# Corebases

> Full power of *asyncpg* with user friendly api of *sqlalchemy.core*


Corebases - is *async* adapter for [Sqlalchemy.Core](https://docs.sqlalchemy.org/en/14/core/).
Interface and code based on [encode/databases](https://github.com/encode/databases), but has bit [difference](#difference-between-encodedatabases). Now supported only **asycnpg** driver (but It's possible to extend)

Current status - **Experimental**

## Reason for create fork
 - https://github.com/encode/databases/issues/403#issue-1016133277

## Install
```bash
> pip install corebases
```

## Usage

```python
# Create a database instance, and connect to it.
from corebases import database
database = database('postgres://user:pass@localhost:5432')
await database.connect()

# Insert some data.
query = "INSERT INTO HighScores(name, score) VALUES (:name, :score)"
value =  {"name": "Daisy", "score": 92}

with database.transaction() as db:
    await db.execute(query=query, value=value)

# Run a database query.
query = "SELECT * FROM HighScores"
rows = await database.fetch_all(query=query)
print('High Scores:', rows)

await database.disconnect()


```

## Difference between encode/databases
Principal is a bit of difference in interface on transactions:

*encode/database*:

```python
with database.transaction():
    await database.execute(query=query, value=value)

```

*corebases*:

```python
with database.transaction() as db:
    await db.execute(query=query, value=value)

```

Also, *corebases* doesn't support methods:
- feach_val
- execute_many

But we can add in the future.
