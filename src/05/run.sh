#!/bin/bash

echo "*************************"
echo "run.sh: Start run.sh script"

# получить путь до папки с лог файлами
log_path=$(pwd)
log_path=${log_path/%05/04}

case $1 in
    1)  awk '{print $0}' $log_path/*.log | sort  -n -k9 > 01.log
    ;;
    2)  awk '{print $1}' $log_path/*.log | sort  -u -k1 > 02.log
    ;;
    3)  awk '$9 ~ /[45][0-9][0-9]/ {print $0}' $log_path/*.log > 03.log
    ;;
    4)  awk '$9 ~ /[45][0-9][0-9]/ {print $1}' $log_path/*.log | sort -u -k1 > 04.log
    ;;
esac

echo "run.sh: Stop run.sh script"
echo "*************************"
