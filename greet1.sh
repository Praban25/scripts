#!/bin/bash

# Check if the first argument ($1) is empty
if [ -z "$1" ]; then
    echo "Usage: ./greet.sh <name>"
else
    echo "Hello, $1!"
fi
