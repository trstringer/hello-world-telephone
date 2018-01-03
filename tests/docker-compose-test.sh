#!/bin/bash

fail() {
    echo "$(date) - tests failed"
    docker-compose down
    exit 1
}

succeed() {
    echo "$(date) - tests passed"
    docker-compose down
    exit
}

test_svc_1() {
    ATTEMPTS=30
    SLEEP_TIME=2
    ITERATION=0

    while [[ $ITERATION -lt $ATTEMPTS ]]; do
        echo "$(date) - testing svc1 (attempt $(( ITERATION + 1 )) of $ATTEMPTS)"
        LOCALHOST_CURL=$(curl -s -o /dev/null -w "%{http_code}" localhost:8080/talktwo)
        if [[ $LOCALHOST_CURL -eq "200" ]]; then
            echo "$(date) - test succeeded with status code $LOCALHOST_CURL"
            return 0
        else
            echo "$(date) - test failed with status code $LOCALHOST_CURL. Retrying..."
        fi

        ITERATION=$(( ITERATION + 1 ))
        sleep $SLEEP_TIME
    done

    return 1
}

if [[ ! $(which docker-compose 2> /dev/null) ]]; then
    echo "$(date) - docker-compose not found"
    exit 1
fi

SCRIPT_PATH=$(dirname "$(realpath "$0")")

docker-compose -f "$SCRIPT_PATH/../docker-compose.yml" up --build -d

if test_svc_1; then
    echo "$(date) - curl test to svc1/talktwo succeeded"
else
    echo "$(date) - curl test to svc1/talktwo failed"
    fail
fi

succeed
