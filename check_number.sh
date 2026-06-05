#!/bin/bash

read -p "Enter the number :  " number

if [ $number -gt 0 ]; then
        echo "This number is Positive"
elif [ $number -lt 0 ] ; then  # <-- Spacing fixed here
        echo "This number is Negative"
else
        echo "This number is Zero"
fi
