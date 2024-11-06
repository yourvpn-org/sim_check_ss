#!/bin/bash

# Define paths
REPO_PATH="$(pwd)"
SERVICE_FILE="watchtower-monitor.service"
TIMER_FILE="watchtower-monitor.timer"
SYSTEMD_PATH="/etc/systemd/system"

# Check if the service and timer files exist
if [ ! -f "$SERVICE_FILE" ]; then
    echo "Error: $SERVICE_FILE not found!"
    exit 1
fi

if [ ! -f "$TIMER_FILE" ]; then
    echo "Error: $TIMER_FILE not found!"
    exit 1
fi

# Replace placeholder in the service file with the actual path
echo "Replacing placeholder in the service file with the actual path..."
sed "s|/path/to/your-repo|$REPO_PATH|g" "$SERVICE_FILE" > "$SERVICE_FILE.tmp"

# Copy the modified service and timer files to the systemd directory
echo "Copying service and timer files to $SYSTEMD_PATH..."
sudo cp "$SERVICE_FILE.tmp" "$SYSTEMD_PATH/$SERVICE_FILE"
sudo cp "$TIMER_FILE" "$SYSTEMD_PATH/"

# Remove the temporary service file
rm "$SERVICE_FILE.tmp"

# Set the correct permissions for the copied files
echo "Setting permissions for service and timer files..."
sudo chmod 644 "$SYSTEMD_PATH/$SERVICE_FILE"
sudo chmod 644 "$SYSTEMD_PATH/$TIMER_FILE"

# Reload systemd, enable, and start the timer
echo "Reloading systemd..."
sudo systemctl daemon-reload

echo "Enabling and starting the timer..."
sudo systemctl enable --now watchtower-monitor.timer

echo "Installation complete! The timer is now active and will check the container every 5 minutes."


