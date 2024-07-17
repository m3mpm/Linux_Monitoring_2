#!/bin/bash

echo "main.sh: Start main.sh script"
if [ $# -eq 0 ]; 
then
    ./run.sh
else
    echo "main.sh: Error1: No need parameters"
    echo "main.sh: Example: ./main.sh"
fi
echo "main.sh: Stop main.sh script"