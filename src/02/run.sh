#!/bin/bash

# подключение библиотеки
source ./lib

echo "run.sh: Start run.sh script"

# переменные
folder_name=$1
file_name=${2%.*}
file_ext=${2#*.}
file_size=$3
date_run_script=$(date +%d%m%y)
loop_stop=0

# вызов функции проверки длины имени папок и файлов
folder_name=$(name_length_f $folder_name)
file_name=$(name_length_f $file_name)


# проверка и создания файла для логов
# если файла нет, то создание файла
if [ ! -f 02.log ]
then
    > 02.log
fi

# запуск цикла на создания папок и файлов
while [[ $loop_stop -eq 0 ]]
do
    # вызов функции проверки свободно пространства в разделе /
    check_free_space_f
    if [[ $? -eq 1 ]]
    then
        loop_stop=1
    else
        # получения пути до папки где будут создаваться папки и файлы
        path=$(get_random_path_f)

        # получения рандомного количества папок
        folder_number=$(shuf -i 1-100 -n1)

        # создание папок и файлов
        for (( i=1; i <= $folder_number && loop_stop == 0; i++ ))
        do
            # вызов функции проверки свободно пространства в разделе /
            check_free_space_f
            if [[ $? -eq 1 ]]
            then
                loop_stop=1
            else
                # путь до папки
                dir_name="$path/$folder_name""_$date_run_script"
                
                # проверяем существует папка с таким именем или нет
                # если нет, то создаем папку
                # если да, то переходим к увеличению имени папки
                if [ ! -d $dir_name ]
                then
                    # создание папки
                    mkdir $dir_name

                    # проверка кода выполнения команды создания папки
                    if [[ $? -eq 0 ]]
                    then
                        # если создалась, то:

                        # переменная даты и времени создания папки
                        date_creation_dir=$(date +%Y.%m.%d\ %H:%M)
                        # делаем запись в лог файл 02.log
                        echo "Dir#$i: $dir_name $date_creation_dir" >> 02.log

                        # получения рандомного количества папок для каждой папки свое значение
                        file_number=$(shuf -i 1-100 -n1)

                        # создание файлов
                        fname=$file_name
                        for (( j = 1; j <= $file_number && loop_stop == 0; j++ ))
                        do
                            # вызов функции проверки свободно пространства в разделе /
                            check_free_space_f
                            if [[ $? -eq 1 ]]
                            then
                                loop_stop=1
                            else
                                # создание папки нужно размера
                                fallocate -l $file_size "$dir_name/$fname""_$date_run_script.$file_ext" 2> /dev/null

                                # переменная для проверки создания файла
                                check_file="$dir_name/$fname""_$date_run_script.$file_ext"
                                if [ -f $check_file  ]
                                then
                                    # если файл создался, то записываем данные в логи
                                    # переменная даты и времени создания файла
                                    date_creation_file=$(date +%Y.%m.%d\ %H:%M)
                                    echo -e "\tFile#$j: $dir_name/$fname""_$date_run_script.$file_ext"" $date_creation_file $file_size" >> 02.log
                                else
                                    # информируем если файл не создался
                                    echo "Can't create file $check_file"
                                fi
                                # увеличение имени файла
                                fname+=${fname:${#fname}-1:1}
                            fi 
                        done
                    else
                        # информируем если папка не создалась
                        echo "Can't create folder $dir_name"
                    fi
                fi
                # увеличение имени папки
                folder_name+=${folder_name:${#folder_name}-1:1} 
            fi
        done
    fi
done

echo "run.sh: Stop run.sh script"