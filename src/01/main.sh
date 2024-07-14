#!/bin/bash

# подключение библиотеки
source ./lib

echo "main.sh: Start main.sh"
# если количество параметров = 6, то запускается скрипт проверки параметров
# иначе выводится сообщение об ошибке
if [[ $# -eq 6 ]]
then
    # проверка параметров
    ./check.sh $1 $2 $3 $4 $5 $6
    
    # если предыдущая операция выполнилась успешно, то запускается скрипт создания папок и файлов
    # иначе выводится сообщение об ошибке
    if [[ $? -eq 0 ]]
    then
        # информация о системе до создания папок и файлов
        system_info_f

        # переменные для таймера старт
        start=$(date +%s)
        start_time=$(date +%T)

        # скрипт создания папок и файлов
        ./run.sh $1 $2 $3 $4 $5 $6

        # переменные для таймера стоп
        stop=$(date +%s)
        stop_time=$(date +%T)

        # расчет времени работы таймера
        time_works=$(( $stop - $start ))

        # информация о системе после создания папок и файлов
        system_info_f

        # запись информации работы таймера
        echo "start time script: $start_time" >> 01.log
        echo "stop time script: $stop_time" >> 01.log
        echo "time works script: $time_works sec" >> 01.log

        # вывод информации работы таймера
        echo "start time script: $start_time"
        echo "stop time script: $stop_time"
        echo "time works script: $time_works sec"
        echo "*************************"

        echo "main.sh: Stop main.sh successfully"
        
    else
        echo "*************************"
        echo "main.sh: Error2: check.sh exit error"
        echo "main.sh: Need to enter six parameters"
        echo "main.sh: Example: ./main.sh /opt/test 4 az 5 az.az 3kb"
    fi

else
    echo "*************************"
    echo "main.sh: Error1: Need to enter six parameters"
    echo "main.sh: Example: ./main.sh /opt/test 4 az 5 az.az 3kb"
fi
