#!/bin/bash

echo "run_mask.sh: Start run_mask.sh script"

# echo -n "Enter mask in the format <<NAME_DDMMYY>>: "
# read mask

# задать маску (т.е. символы, нижнее подчёркивание и дата)
mask='[[:alpha:]]+_[0-9]{6}(\.[[:alpha:]]{1,3})?'

# получить путь до лог файла
log_path=$(pwd)
log_file=${log_path/%03/02}/02.log

# проверка существует лог файл или нет
if [ -f $log_file ]
then
   
    # удаление файлов
    echo "*************"
    echo "Search files"
    while read -r line; do
        find_file=$(echo $line | grep File) # поиск строк только где файлы
        if [[ $find_file =~ $mask ]]; then # поиск подстроки в строке, то есть поиск маски
            file_delete=$(echo $find_file | awk '{print $2}') # переменная хранения пути к файлу
            if [ -f $file_delete ]; then # проверяем существует файл или нет
                sudo rm -rf $file_delete
                echo "The file $file_delete is deleted"
            else
                echo "The file $file_delete does not exist"
            fi
        fi
    done <$log_file

    # удаление папок
    echo "*************"
    echo "Search dirs"
    while read -r line; do
        find_dir=$(echo $line | grep Dir) # поиск строк только где папки
        if [[ $find_dir =~ $mask ]]; then # поиск подстроки в строке, то есть поиск маски
            dir_delete=$(echo $find_dir | awk '{print $2}') # переменная хранения пути к папке
            if [ -d $dir_delete ]; then # проверяем существует папка или нет
                sudo rm -rf $dir_delete
                echo "The folder $dir_delete is deleted"
            else
                echo "The foder $dir_delete does not exist"
            fi
        fi
    done <$log_file

    echo "*************"
    echo "run_mask.sh: Stop run_mask.sh script"
else
    echo "run_mask.sh: Error1: Incorrect path to log file or file doesn't exist"
    exit 1
fi