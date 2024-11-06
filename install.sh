#!/bin/bash

# Define paths
REPO_PATH="$(pwd)"
SERVICE_FILE="watchtower-monitor.service"
TIMER_FILE="watchtower-monitor.timer"
SYSTEMD_PATH="/etc/systemd/system"

# Replace placeholder in the service file with the actual path
# Ensure that the REPO_PATH placeholder is replaced correctly in the service file
echo "Replacing placeholder in $SERVICE_FILE..."
sed "s|{{REPO_PATH}}|$REPO_PATH|g" "$SERVICE_FILE" > "$SERVICE_FILE.tmp"

# Check if the service file replacement was successful
if [ $? -ne 0 ]; then
    echo "Error replacing placeholder in $SERVICE_FILE."
    exit 1
fi

# Copy the modified service and timer files to the systemd path
echo "Copying service and timer files to $SYSTEMD_PATH..."
sudo cp "$SERVICE_FILE.tmp" "$SYSTEMD_PATH/$SERVICE_FILE"
sudo cp "$TIMER_FILE" "$SYSTEMD_PATH/"

# Remove the temporary service file after copying
rm "$SERVICE_FILE.tmp"

# Reload systemd, enable, and start the timer
echo "Reloading systemd..."
sudo systemctl daemon-reload

# Enable and start the service and timer
echo "Enabling and starting the timer..."
sudo systemctl enable --now watchtower-monitor.timer

# Output installation complete
echo "Installation complete! The timer is now active and will check the container every 5 minutes."
