#!/bin/bash

# подключение библиотеки
source ./lib
echo "run_date.sh: Start run_date.sh script"

# получение данных от пользователя
echo -n "Enter date to delete files in the format <<YYYY.MM.DD>>: "
read date
echo -n "Enter start time to delete files in the format <<HH:MM>>: "
read time1
echo -n "Enter end time to delete files in the format <<HH:MM>>: "
read time2

# проверка полученных данных от пользователя
check_date_time_f $date $time1 $time2

# если проверка прошла успешно, то выполняется основной скрипт
# иначе выводится сообщение об ошибке
if [[ $? -eq 0 ]] # 
then
    # получить путь до лог файла
    log_path=$(pwd)
    log_file=${log_path/%03/02}/02.log

    # проверка существует лог файл или нет
    if [ -f $log_file ]
    then
        
        # получения значения времени в формате 1123
        # а не как ввел пользователь 11:23
        time_from=${time1//:/}
        time_to=${time2//:/}

        # удаление файлов
        echo "*************"
        echo "Search files"
        while read -r line; do # читаем каждую строчку в лог-файле
            find_file=$(echo $line | grep File) # выбока строчки, содержащую запись File
            file_date=$(echo $find_file | awk '{print $3}') # переменная даты
            file_time=$(echo $find_file | awk '{print $4}') # переменная времени
            file_time=${file_time//:/} # время создания файла в формате 1123, а не 11:23
              
            if [[ "$file_date" = "$date" ]]; then # если даты совпали, то проверка времени
                if [[ $((10#$file_time)) -ge $((10#$time_from)) && $((10#$file_time)) -le $((10#$time_to)) ]]; then
                    file_delete=$(echo $find_file | awk '{print $2}') # переменная хранения пути к файлу
                    if [ -f $file_delete ]; then # проверяем существует файл или нет
                        sudo rm -rf $file_delete
                        echo "The file $file_delete is deleted"
                    else
                        echo "The file $file_delete does not exist"
                    fi
                fi
            fi
        done <$log_file

        # удаление папок
        echo "*************"
        echo "Search dirs"
        while read -r line; do # читаем каждую строчку в лог-файле
            find_dir=$(echo $line | grep Dir)  # выбока строчки, содержащую запись Dir
            dir_date=$(echo $find_dir | awk '{print $3}') # переменная даты
            dir_time=$(echo $find_dir | awk '{print $4}') # переменная времени
            dir_time=${dir_time//:/} # время создания папки в формате 1123, а не 11:23

            if [[ "$dir_date" = "$date" ]]; then # если даты совпали, то проверка времени
                if [[ $((10#$dir_time)) -ge $((10#$time_from)) && $((10#$dir_time)) -le $((10#$time_to)) ]]; then
                    dir_delete=$(echo $find_dir | awk '{print $2}') # переменная хранения пути к папке
                    if [ -d $dir_delete ]; then # проверяем существует папка или нет
                        if [ "$(ls -A $dir_delete)" ]; then  # проверяем пустая папка или нет
                            echo "The folder $dir_delete is not Empty"
                            echo "The folder $dir_delete is not deleted"
                        else
                            echo "The folder $dir_delete is Empty"
                            sudo rm -rf $dir_delete
                            echo "The folder $dir_delete is deleted"
                        fi
                    else
                        echo "The folder $dir_delete does not exist"
                    fi
                fi
            fi
        done <$log_file

    echo "*************"
    echo "run_date.sh: Stop run_date.sh script"
    else
        echo "run_date.sh: Error2: Incorrect path to log file or file doesn't exist"
        exit 1
    fi
else
    echo "run_date.sh: Error1: Stop run_date.sh with error"
fi