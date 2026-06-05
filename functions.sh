#!/bin/bash

read -p "Enter your name & First Number & Second Number (separated by space) :  " your_name n1 n2

greet() {
	local name=$1
	echo "Hello ${name}"
}


add() {
	local num1=$1
	local num2=$2
	local sum=$((num1 + num2))
	echo "The sum of $num1 and $num2 is $sum "
}


greet "$your_name"
add "$n1" "$n2"
