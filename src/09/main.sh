#!/bin/bash

if [ $# -eq 0 ]
then
    while [ 1 ]
    do
        ./run.sh > /var/www/html/index.html
        sleep 3
    done
else
    echo "main.sh: Error1: No need parameters"
    echo "main.sh: Example: ./main.sh"
fi