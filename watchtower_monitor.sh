#!/bin/bash

# Set your container name and start command
CONTAINER_NAME="shadowbox"
START_COMMAND="bash /opt/outline/persisted-state/start_container.sh"

# Check if the container exists and is running healthily
STATUS=$(docker inspect --format='{{.State.Health.Status}}' "$CONTAINER_NAME" 2>/dev/null)

if [ "$STATUS" != "healthy" ]; then
    echo "Container $CONTAINER_NAME is not healthy or doesn't exist. Starting it..."
    $START_COMMAND
else
    echo "Container $CONTAINER_NAME is healthy."
fi

