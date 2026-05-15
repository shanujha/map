# map

Docker Compose stack for running:

- **Postgres** as the shared transactional database
- **Appsmith** as the frontend for forms, data entry, and internal tools
- **Metabase** as the analytics/dashboard layer on top of Postgres

## Start the stack

```bash
docker compose up -d
```

## Services

- Appsmith: http://localhost:8080
- Metabase: http://localhost:3000
- Postgres: localhost:5432

## Default database credentials

### Postgres application database

Use these credentials from Appsmith when creating a Postgres datasource:

- Host: `postgres` (inside Docker) or `localhost` (from your machine)
- Port: `5432`
- Database: `map`
- Username: `map`
- Password: `map_password`

### Metabase application database

Metabase stores its own internal metadata in a separate Postgres database created automatically at startup:

- Database: `metabase`
- Username: `metabase`
- Password: `metabase_password`

## Wiring the services together

1. Open **Appsmith** and create a Postgres datasource using the `map` database credentials above.
2. Build your forms and data entry apps in Appsmith so they read from and write to Postgres.
3. Open **Metabase**, complete the first-run setup, and add the same Postgres server as a data source for analytics using:
   - Host: `postgres`
   - Port: `5432`
   - Database: `map`
   - Username: `map`
   - Password: `map_password`

## Stop the stack

```bash
docker compose down
```

To remove persisted data as well:

```bash
docker compose down -v
```
