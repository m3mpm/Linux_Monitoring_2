#!/bin/bash

echo "*************************"
echo "check.sh: Start check.sh script"

# проверка списка букв английского алфавита, используемый в названии папок
if ! [[ $1 =~ ^[[:alpha:]]{1,7}$ ]]
then
    echo "check.sh \$1: Wrong folder name, no more than 7 Eglish characters for the name"
    exit 1
else
    echo "check.sh \$2: Correct letters for folders names"
fi

# проверка списка букв английского алфавита, используемый в имени файла и расширении
if ! [[ $2 =~ ^[[:alpha:]]{1,7}\.[[:alpha:]]{1,3}$ ]]
then
    echo "check.sh \$2: Wrong file name, no more than 7 Eglish characters for the name, no more than 3 characters for the extension"
    exit 1
else
    echo "check.sh \$2: Correct pattern for files names"
fi

# проверка размера файлов (в Мегабайтах, но не более 100).
# возможне ввод чисел от 0.01Mb до 100Mb[100|1-9|10-99|0.01-0.99|1.00-9.99|10.00-99.99]
if ! [[ $3 =~ ^(100|[1-9]{1}|[1-9]{1}[0-9]{1}|[0]{1}\.[0-9]{1,2}|[1-9]{1}\.[0-9]{1,2}|[1-9]{1}[0-9]{1}\.[0-9]{1,2})Mb$ ]]
then
    echo "check.sh \$3: Wrong files size"
    echo "check.sh \$3: File size must be between 0.01Mb and 100Mb"
    exit 1
else 
    echo "check.sh \$3: Correct files size"
fi

echo "check.sh: Stop check.sh script"