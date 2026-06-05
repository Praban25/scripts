#!/bin/bash

# Store the service name in a variable
SERVICE_NAME="nginx"

# Ask the user if they want to check the status
read -p "Do you want to check the status of $SERVICE_NAME? (y/n): " choice

# Convert choice to lowercase to handle 'Y' or 'y'
choice=${choice,,}

if [ "$choice" = "y" ]; then
    echo "Checking $SERVICE_NAME status..."
    echo "--------------------------------"
    
    # Run systemctl status
    systemctl status "$SERVICE_NAME"
    
    # Check the exit status of the systemctl command
    if [ $? -eq 0 ]; then
        echo "--------------------------------"
        echo "Result: $SERVICE_NAME is active and running."
    else
        echo "--------------------------------"
        echo "Result: $SERVICE_NAME is NOT active or not installed."
    fi

elif [ "$choice" = "n" ]; then
    echo "Skipped."
else
    echo "Invalid option. Please enter 'y' or 'n'."
fi
