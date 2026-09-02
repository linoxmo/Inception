# Developer Documentation

## Using the make commands

- **`make`**: default target (equivalent to `make all`). Creates the data persistence directories if they don't already exist, then builds and starts all containers in the background (`docker compose up -d --build`). This is the command to use for a first launch.

- **`make re`**: full rebuild from scratch. Chains `fclean` (stops and removes containers, volumes, images, and cleans up disk data) followed by `all` (full rebuild). Use this when something behaves unexpectedly, or after a deep configuration change (Dockerfiles, docker-compose.yaml).

- **`make start`**: restarts containers that already exist but are currently stopped (`docker compose start`), without rebuilding them. Useful after a `make stop` — faster than a full `make up` since no build is triggered.

- **`make build`**: rebuilds the Docker images (`docker compose build`) without starting the containers. Useful for validating that a modified Dockerfile compiles correctly before launching the services.

- **`make down`**: stops and removes the containers (`docker compose down --remove-orphans`), but keeps the volumes and images. Persistent data (database, WordPress files) remains intact.

- **`make logs`**: displays logs from all services continuously (`docker compose logs -f`). Handy for monitoring startup or debugging a service in real time. `Ctrl+C` to exit without stopping the containers.

- **`make ps`**: lists the status of every container in the project, including stopped ones (`docker compose ps -a`). Lets you quickly check whether a service has crashed.

### Other available targets

- **`make stop`**: stops the containers without removing them (opposite of `start`).
- **`make restart`**: restarts the containers in place (`docker compose restart`).
- **`make clean`**: stops and removes containers, volumes, and orphaned networks, without touching the images.
- **`make fclean`**: goes further than `clean` — also removes the project's Docker images, performs a global cleanup (`docker system prune`), and deletes data stored on the host disk.

## Build

The build is triggered automatically by `make` or `make up` through Docker Compose, which builds the project's three images from their respective Dockerfiles:

```bash
make build
```

This command builds (or rebuilds) the `nginx`, `wordpress`, and `mariadb` images without starting the containers. It's useful for:
- validating that a Dockerfile change doesn't break the build before launching the services,
- forcing a rebuild of an image after a script change (`nginx.sh`, `wordpress.sh`, `mariadb.sh`) without restarting the whole stack.

To force a full rebuild without cache (useful if a change isn't being picked up due to Docker's cache):

```bash
docker compose build --no-cache
```

Once the build is done, start the containers with `make up` or `make`.

## Using MariaDB

### Connect to the MariaDB container

Open a shell inside the container:

```bash
docker exec -it mariadb bash
```

### Connect to the MySQL/MariaDB client

Once inside the container (or directly from the host with `docker exec`), connect using the application user defined in `.env`:

```bash
docker exec -it mariadb mariadb -u wpuser -p wordpress
```

The requested password is the one stored in the `db_password` secret (file `~/.secrets/db_password.txt`).

To connect as root (full access to all databases):

```bash
docker exec -it mariadb mariadb -u root -p
```

The root password corresponds to the `db_root_password` secret.

### Useful MySQL commands once connected

```sql
SHOW DATABASES;                    -- list all databases
USE wordpress;                     -- select the WordPress database
SHOW TABLES;                       -- list the tables in the database
SELECT User, Host FROM mysql.user; -- list MySQL users and their hosts
DESCRIBE wp_users;                 -- structure of the WordPress users table
SELECT user_login, user_email FROM wp_users; -- list WordPress accounts
```

### Check that the service is responding without opening an interactive session

```bash
docker exec mariadb mariadb-admin -u root -p"$(cat ~/.secrets/db_root_password.txt)" ping
```

Should reply `mysqld is alive`.

### View MariaDB logs

```bash
docker logs mariadb
docker logs -f mariadb   # continuously
```

### Backup or restore the database

Export (dump):

```bash
docker exec mariadb mariadb-dump -u root -p"$(cat ~/.secrets/db_root_password.txt)" wordpress > backup.sql
```

Import (restore):

```bash
cat backup.sql | docker exec -i mariadb mariadb -u root -p"$(cat ~/.secrets/db_root_password.txt)" wordpress
```
