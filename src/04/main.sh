#!/bin/bash

echo "main.sh: Start main.sh script"
if [ $# -eq 0 ]; 
then
    # переменные для таймера старт
    start=$(date +%s)
    start_time=$(date +%T)

    # скрипт для создания лог файлов
    ./run.sh

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
    echo "main.sh: Error1: No need parameters"
    echo "main.sh: Example: ./main.sh"
fi
echo "main.sh: Stop main.sh script"