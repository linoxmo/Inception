# USER DOCUMENTATION

## Description

This document explains how to use and manage the Inception stack.

The stack is composed of three services:

- **NGINX**: Web server and reverse proxy. It receives HTTPS requests and forwards them to WordPress.
- **WordPress**: Content management system used to create and manage the website.
- **MariaDB**: Database management system used by WordPress to store the website's data.

The services run in separate Docker containers and communicate through a Docker network.

---

## Services

### NGINX

NGINX is the entry point of the stack.

It:

- Handles HTTPS connections.
- Uses TLS to secure communications.
- Receives requests from the user.
- Forwards requests to the WordPress service.

NGINX is accessible through:

```text
https://tmagoudi42.fr
```

### WORDPRESS

You will access WordPress directly with the basic configuration.

You can publish new messages by connecting as an admin. Then, you can write your message and add it to the blog.

### MARIADB

All this information will be stored in MariaDB.

MariaDB stores the information used by WordPress, such as published messages, users and website configuration.

### Credentials

The credentials used by WordPress and MariaDB are stored in the project's environment configuration.

They can be found in:

.env

The .env file contains the configuration needed by the services, including the database name, database user and passwords.

The WordPress administrator credentials are used to access the WordPress administration panel.

Do not share or publish these credentials.

### Check the Services 

To check if the three services are running correctly, use:

docker compose ps

The three containers should be running:

nginx
wordpress
mariadb

You can also check the logs of the services with:

docker compose logs nginx
docker compose logs wordpress
docker compose logs mariadb

If the containers are running and the website can be accessed through:

https://tmagoudi42.fr

the stack is working correctly.
