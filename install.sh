#!/bin/bash

# Define paths
REPO_PATH="$(pwd)"
SERVICE_FILE="watchtower-monitor.service"
TIMER_FILE="watchtower-monitor.timer"
SYSTEMD_PATH="/etc/systemd/system"

# Ensure the REPO_PATH is correctly replaced in the service file
sed "s|{{REPO_PATH}}|$REPO_PATH|g" "$SERVICE_FILE" > "$SERVICE_FILE.tmp"

# Copy the modified service and timer files to systemd directory
echo "Copying service and timer files to $SYSTEMD_PATH..."
sudo cp "$SERVICE_FILE.tmp" "$SYSTEMD_PATH/$SERVICE_FILE"
sudo cp "$TIMER_FILE" "$SYSTEMD_PATH/"

# Remove the temporary service file
rm "$SERVICE_FILE.tmp"

# Reload systemd and enable the timer
echo "Reloading systemd..."
sudo systemctl daemon-reload
echo "Enabling and starting the timer..."
sudo systemctl enable --now watchtower-monitor.timer

echo "Installation complete! The timer is now active and will check the container every 5 minutes."
