#!/bin/bash

echo "main.sh: Start main.sh script"
if [[ $# -eq 1 && $1 =~ [1-4] ]]
then
    # переменные для таймера старт
    start=$(date +%s)
    start_time=$(date +%T)

    # скрипт для разбора логов
    ./run.sh $1

    # переменные для таймера стоп
    stop=$(date +%s)
    stop_time=$(date +%T)

    # расчет времени работы таймера
    time_works=$(( $stop - $start ))

    # вывод информации работы таймера
    echo "start time script: $start_time"
    echo "stop time script: $stop_time"
    echo "time works script: $time_works sec"
    echo "*************************"
else
    echo "main.sh: Error1: Need to enter one parameter. Please, use numbers from 1 to 4"
    echo "main.sh: Example: ./main.sh 1 - All records sorted by response code"
    echo "main.sh: Example: ./main.sh 2 - All unique IP addresses found in the records;"
    echo "main.sh: Example: ./main.sh 3 - All requests with errors (response code - 4xx or 5xx"
    echo "main.sh: Example: ./main.sh 4 - All unique IP addresses that are found among erroneous requests."
fi
echo "main.sh: Stop main.sh script"
