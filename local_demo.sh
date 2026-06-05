#!/bin/bash

# --- Function 1: Using local variables ---
local_function() {
    local local_var="I am inside the local function"
    echo "Inside local_function: \$local_var = '$local_var'"
}

# --- Function 2: Using regular (global) variables ---
global_function() {
    global_var="I am inside the global function"
    echo "Inside global_function: \$global_var = '$global_var'"
}

# --- Main Demonstration ---

echo "========================================="
echo "1. TESTING LOCAL VARIABLES"
echo "========================================="
# Run the function
local_function

# Try to access the variable outside the function
echo "Outside function: \$local_var = '$local_var'"
if [ -z "$local_var" ]; then
    echo "Result: Success! The variable did NOT leak outside."
else
    echo "Result: Fail! The variable Leaked. Immidiate action needed"	
fi

echo ""
echo "========================================="
echo "2. TESTING REGULAR (GLOBAL) VARIABLES"
echo "========================================="
# Run the function
global_function

# Try to access the variable outside the function
echo "Outside function: \$global_var = '$global_var'"
if [ -z "$global_var" ]; then
    echo "Nothing in Local variable. All good"
else
    echo "Result: Danger! The variable LEAKED and is now globally accessible."
fi
echo "========================================="
