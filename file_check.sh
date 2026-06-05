#!/bin/bash

read -p "Enter the Filename :  " filename

if [ -f $filename ]; then
	echo "The $filename file exist, you can proceed"
else
	echo "The $filename file didnt exist, go back and search for the same"
fi
