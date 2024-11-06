#!/bin/bash

# Set your container name and start command
CONTAINER_NAME="shadowbox"
START_COMMAND="bash /opt/outline/persisted-state/start_container.sh"

# Check if the container is running (up) or stopped (down)
STATUS=$(docker inspect --format='{{.State.Status}}' "$CONTAINER_NAME" 2>/dev/null)

# If the container doesn't exist or isn't running, start it
if [ -z "$STATUS" ]; then
    echo "Container $CONTAINER_NAME does not exist. Starting it..."
    $START_COMMAND
elif [ "$STATUS" != "running" ]; then
    echo "Container $CONTAINER_NAME is not running. Starting it..."
    $START_COMMAND
else
    echo "Container $CONTAINER_NAME is running."
fi
