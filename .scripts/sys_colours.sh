#!/bin/bash

for i in {0..7}; do echo -n -e "\x1b[4${i}m   \x1b[0m"; done   
echo
for i in {0..7}; do echo -ne "\x1b[10${i}m   \x1b[0m"; done   
echo
