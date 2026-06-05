#!/bin/bash

read -p "Enter the number to start the countdown :  " count

while [ $count -ge 0 ]
do
	echo $count
	count=$((count - 1))

	sleep 1
done

echo "Boooommmm!!!!"
