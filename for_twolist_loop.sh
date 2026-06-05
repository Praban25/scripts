#!/bin/bash

#definig array
mood=("like" "eat" "love to eat" "like kapa" "love to suck")
fruits=("apple" "banana" "cherry" "jackfruit" "mango")

#Looping
for i in {0..4}
do
	echo "I ${mood[$i]} ${fruits[$i]}"
done









