#!/usr/bin/env bash

# Wake up with monitor enabled
xset dpms force on

# and a fresh console
clear
echo "Good morning!"
echo "It is $(date +%R)"

# while [ true ]; do
# 	aplay -q rooster.wav
# 	sleep 1
# done

aplay -q rooster.wav
