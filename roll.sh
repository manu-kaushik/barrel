#!/bin/bash

PREFIX="roll"

RED="\e[1;31m"
GREEN="\e[1;32m"
BLUE="\e[1;34m"
YELLOW="\e[1;33m"
RESET="\e[0m"
BOLD="\e[1m"

display_usage() {
    echo -e "\n${YELLOW}${BOLD}Usage${RESET}"
    echo -e "  ${BLUE}run${RESET} ${GREEN}<command>${RESET}\n"

    display_available_commands
}

source_env_if_present() {
    if [ -f .env ]; then
        source .env
    else
        echo -e "${RED}ERR: .env file not found${RESET}"
        exit 1
    fi
}

run_docker_compose() {
    docker-compose -p $PREFIX "$@"
}

run_composer() {
    run_docker_compose exec php composer "$@"
}

run_artisan() {
    run_docker_compose exec php php artisan "$@"
}

run_npm() {
    run_docker_compose exec php npm "$@"
}

run_npx() {
    run_docker_compose exec php npx "$@"
}

run_psql() {
    run_docker_compose exec postgres psql "$@"
}

run_mysql() {
    run_docker_compose exec mysql mysql "$@"
}

display_available_commands() {
    local padding=25

    echo -e "${YELLOW}Available commands:${RESET}"

    printf "  ${BLUE}%-${padding}s${RESET}%s\n" "serve [--default]" "Serves application on default env port."
    printf "  ${GREEN}%-${padding}s${RESET}%s\n" "composer ..." "Run composer commands"
    printf "  ${GREEN}%-${padding}s${RESET}%s\n" "artisan ..." "Run artisan commands"
    printf "  ${GREEN}%-${padding}s${RESET}%s\n" "npm ..." "Run npm commands"
    printf "  ${GREEN}%-${padding}s${RESET}%s\n" "npx ..." "Run npx commands"
    printf "  ${GREEN}%-${padding}s${RESET}%s\n" "psql ..." "Run psql commands"
    printf "  ${GREEN}%-${padding}s${RESET}%s\n" "mysql ..." "Run mysql commands"
    printf "  ${GREEN}%-${padding}s${RESET}%s\n" "..." "Run docker compose commands"
}

if [ $# -lt 1 ]; then
    display_usage
    exit 1
fi

case "$1" in
"serve")
    shift

    source_env_if_present

    if [ "$1" = "--default" ]; then
        run_artisan serve --host=0.0.0.0 --port=$APP_PORT
    else
        run_artisan octane:start --watch --poll --host=0.0.0.0 --port=$APP_PORT
    fi
    ;;

"help")
    display_usage
    ;;

"composer")
    shift
    run_composer "$@"
    ;;

"artisan")
    shift
    run_artisan "$@"
    ;;

"npm")
    shift
    run_npm "$@"
    ;;

"npx")
    shift
    run_npx "$@"
    ;;

"psql")
    shift
    run_psql "$@"
    ;;

"mysql")
    shift
    run_mysql "$@"
    ;;

*)
    run_docker_compose "$@"
    ;;
esac
