#!/bin/bash

# подключение библиотеки
source ./lib

echo "run.sh: Start run.sh script"

# переменные
date_run_script=$(date +%d%m%y)
path=$1
folder_number=$2
folder_name=$3
file_number=$4
file_name=${5%.*}
file_ext=${5#*.}
file_size=$6

# вызов функции проверки пути поставили /: path/ или path
path=$(check_path_f $path)

# вызов функции увеличение длины имени папок и файлов
folder_name=$(name_length_f $folder_name)
file_name=$(name_length_f $file_name)

# проверка и создания файла для логов
# если файла нет, то создание файла
# если файл есть, то очищает файл
# if [ ! -f 01.log ]
# then
#     > 01.log 
# else
#     sudo cat /dev/null > 01.log
# fi

# проверка и создания файла для логов
# если файла нет, то создание файла
if [ ! -f 01.log ]
then
    > 01.log
fi

# создание папок и файлов
for (( i=1; i <= $folder_number; i++ ))
do
    # вызов функции проверки свободно пространства в разделе /
    check_free_space_f

    # создание папок
    dir_name="$path/$folder_name""_$date_run_script"
    mkdir $dir_name 2> /dev/null
    # если папка создалась, то записываем данные в логи
    # или если папка уже существует, возможно будут другое имя файлов для создания в этой папке
    if [ -d $dir_name ]
    then
        # переменная даты и времени создания папки
        date_creation_dir=$(date +%Y.%m.%d\ %H:%M)
        echo "Dir#$i: $dir_name $date_creation_dir" >> 01.log

        # создание файлов
        fname=$file_name
        for (( j = 1; j <= $file_number; j++ ))
        do
            # вызов функции проверки свободно пространства в разделе /
            check_free_space_f

            # создание папки нужно размера
            fallocate -l $file_size "$dir_name/$fname""_$date_run_script.$file_ext" 2> /dev/null

            # переменная для проверки создания файла
            check_file="$dir_name/$fname""_$date_run_script.$file_ext"
            if [ -f $check_file ]
            then
                # если файл создался, то записываем данные в логи
                # переменная даты и времени создания файла
                date_creation_file=$(date +%Y.%m.%d\ %H:%M)
                echo -e "\tFile#$j: $dir_name/$fname""_$date_run_script.$file_ext"" $date_creation_file $file_size" >> 01.log    
            fi
            # увеличение имени файла
            fname+=${fname:${#fname}-1:1}
        done
    fi
    # увеличение имени папки
    folder_name+=${folder_name:${#folder_name}-1:1}
done

echo "run.sh: Stop run.sh script"