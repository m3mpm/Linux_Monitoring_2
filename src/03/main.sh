#!/bin/bash

# подключение библиотеки
source ./lib

echo "main.sh: Start main.sh script"
if [[ $# -eq 1 ]]
then

    # переменные для таймера старт
    start=$(date +%s)
    start_time=$(date +%T)

    case $1 in
    1)
        # информация о системе до удаления
        system_info_f

        ./run_log.sh
        if [[ $? -eq 0 ]]
        then
            # информация о системе после удаления
            system_info_f
            echo "main.sh: Stop main.sh script"
        else
            echo "main.sh: Error3: Stop main.sh script"
        fi
    ;;
    2)
        # информация о системе до удаления
        system_info_f

        ./run_date.sh
        if [[ $? -eq 0 ]]
        then
            # информация о системе после удаления
            system_info_f
            echo "main.sh: Stop main.sh script"
        else
            echo "main.sh: Error4: Stop main.sh script"
        fi
    ;;
    3)
        # информация о системе до удаления
        system_info_f
        
        ./run_mask.sh
        if [[ $? -eq 0 ]]
        then
            # информация о системе после удаления
            system_info_f
            echo "main.sh: Stop main.sh script"
        else
            echo "main.sh: Error5: Stop main.sh script"
        fi
    ;;
    *)
        echo "main.sh: Error2: Need to enter one parameter. Please, use numbers from 1 to 3"
    ;;
    esac

    # переменные для таймера стоп
    stop=$(date +%s)
    stop_time=$(date +%T)

    # расчет времени работы таймера
    time_works=$(( $stop - $start ))

    # вывод информации работы таймера
    echo "*************************"
    echo "start time script: $start_time"
    echo "stop time script: $stop_time"
    echo "time works script: $time_works sec"
    echo "*************************"

else
    echo "main.sh: Error1: Need to enter one parameter. Please, use numbers from 1 to 3"
    echo "main.sh: Example: ./main.sh 1 - by log file"
    echo "main.sh: Example: ./main.sh 2 - by creation date and time"
    echo "main.sh: Example: ./main.sh 3 - by name mask"
fi
