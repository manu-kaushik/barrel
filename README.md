# Barrel 

Dockerized Laravel Template with Octane-Swoole & Roll CLI

---

## Getting Started

- Customize environment variables and Docker services as needed (optional).

- Create `.env`
    ```
    cp .env.example .env
    ```

- Grant executable permissions to `roll.sh`:
    ```
    chmod +x roll.sh
    ```

- Create an alias for `roll.sh`:
    ```
    alias roll=./roll.sh
    ```

- Build images:
    ```
    roll build
    ```

- Launch containers:
    ```
    roll up -d
    ```

- Start the server:
    ```
    roll serve
    ```
    > Note: This will serve the application using Octane. If you prefer Laravel's default server, use the `--default` option.

- Explore available commands and usage:
    ```
    roll help
    ```

- Confirm functionality by checking `APP_URL:APP_PORT`.

> Note: Modify the `PREFIX` variable in `roll.sh`. It applies to all containers, networks, and volumes managed by Roll.

