#!/bin/bash

# подключение библиотеки
source ./lib

echo "run_log.sh: Start run_log.sh script"

# echo -n "Enter path to log file: "
# read logfile

# получить путь до лог файла
log_path=$(pwd)
log_file=${log_path/%03/02}/02.log

# проверка существует лог файл или нет
if [ -f $log_file ]
then
    # удаляем файлы
    # list_path хранит путь до всех файлов из лог файла
    list_path="$(cat $log_file | grep File | awk '{print $2}')"
    remove_dir_file_f

    # удаляем папки
    # list_path хранит путь до всех папок из лог файла
    list_path="$(cat $log_file | grep Dir | awk '{print $2}')"
    remove_dir_file_f
    echo "run_log.sh: Stop run_log.sh script"
else
    echo "run_log.sh: Error1: Incorrect path to log file or file doesn't exist"
    exit 1
fi