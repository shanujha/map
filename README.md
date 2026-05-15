# map

Docker Compose stack for running:

- **Postgres** as the shared transactional database
- **Appsmith** as the frontend for forms, data entry, and internal tools
- **Metabase** as the analytics/dashboard layer on top of Postgres

## Configure environment variables

Copy the example environment file and choose your own passwords before starting the stack:

```bash
cp .env.example .env
```

## Start the stack

```bash
docker compose up -d
```

## Services

- Appsmith: http://localhost:8080
- Metabase: http://localhost:3000
- Postgres: localhost:5432

## Default connection settings

The values below come from your local `.env` file.

### Postgres application database

Use these credentials from Appsmith when creating a Postgres datasource:

- Host: `postgres` (inside Docker) or `localhost` (from your machine)
- Port: `5432`
- Database: `${POSTGRES_DB}`
- Username: `${POSTGRES_USER}`
- Password: `${POSTGRES_PASSWORD}`

### Metabase application database

Metabase stores its own internal metadata in a separate Postgres database created automatically at startup:

- Database: `${METABASE_DB_NAME}`
- Username: `${METABASE_DB_USER}`
- Password: `${METABASE_DB_PASSWORD}`

## Wiring the services together

1. Open **Appsmith** and create a Postgres datasource using the application database credentials from `.env`.
2. Build your forms and data entry apps in Appsmith so they read from and write to Postgres.
3. Open **Metabase**, complete the first-run setup, and add the same Postgres server as a data source for analytics using:
   - Host: `postgres`
   - Port: `5432`
   - Database: the `POSTGRES_DB` value from `.env`
   - Username: the `POSTGRES_USER` value from `.env`
   - Password: the `POSTGRES_PASSWORD` value from `.env`

## Stop the stack

```bash
docker compose down
```

To remove persisted data as well:

```bash
docker compose down -v
```
