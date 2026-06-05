#!/bin/bash

# Define the list of packages
PACKAGES=("nginx" "curl" "wget")

# Ensure the script is run with root/sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or using sudo."
  exit 1
fi

echo "Starting package installation check..."
echo "--------------------------------------"

# Loop through the list
for PACKAGE in "${PACKAGES[@]}"
do
    # Check if the package is installed
    # dpkg -s redirects standard output and errors to /dev/null so it stays quiet
    if dpkg -s "$PACKAGE" >/dev/null 2>&1; then
        echo "[ PRESENT ] $PACKAGE is already installed. Skipping."
    else
        echo "[ MISSING ] $PACKAGE is not installed. Installing now..."
        
        # Install the package (-y assumes 'yes' to prompts)
        apt-get install -y "$PACKAGE" >/dev/null 2>&1
        
        # Check if the installation was successful
        if [ $? -eq 0 ]; then
            echo "[ SUCCESS ] $PACKAGE has been successfully installed."
        else
            echo "[  ERROR  ] Failed to install $PACKAGE."
        fi
    fi
done

echo "--------------------------------------"
echo "All checks complete!"
