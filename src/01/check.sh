#!/bin/bash

echo "*************************"
echo "check.sh: Start check.sh script"

# проверка абсолютный пути
if ! [[ -d $1 ]]
then
    echo "check.sh \$1: Wrong path."
    exit 1
else
    echo "check.sh \$1: Correct path"
fi

# проверка количество вложенных папок
if ! [[ $2 =~ ^[[:digit:]]+$ && $2 -ge 1  ]]
then
    echo "check.sh \$2: Wrong number of folders"
    exit 1
else
    echo "check.sh \$2: Correct number of folders"
fi

# проверка списка букв английского алфавита, используемый в названии папок
if ! [[ $3 =~ ^[[:alpha:]]{1,7}$ ]]
then
    echo "check.sh \$3: Wrong folder name, no more than 7 Eglish characters for the name"
    exit 1
else
    echo "check.sh \$3: Correct letters for folders names"
fi

# проверка количество файлов в каждой созданной папке
if ! [[ $4 =~ ^[[:digit:]]+$ && $4 -ge 1 ]]
then
    echo "check.sh \$4: Wrong number of files in each folder"
    exit 1
else
    echo "check.sh \$4: Correct number of files in each folder"
fi

# проверка список букв английского алфавита, используемый в имени файла и расширении
if ! [[ $5 =~ ^[[:alpha:]]{1,7}\.[[:alpha:]]{1,3}$ ]]
then
    echo "check.sh \$5: Wrong file name, no more than 7 Eglish characters for the name, no more than 3 characters for the extension"
    exit 1
else
    echo "check.sh \$5: Correct pattern for files names"
fi

# Проверка размера файлов (в килобайтах, но не более 100).
# возможно ввод чисел от 0.01kb до 100kb
if ! [[ $6 =~ ^(100|[1-9]{1}|[1-9]{1}[0-9]{1}|[0]{1}\.[0-9]{1,2}|[1-9]{1}\.[0-9]{1,2}|[1-9]{1}[0-9]{1}\.[0-9]{1,2})kb$ ]]
then
    echo "check.sh \$6: Wrong files size"
    echo "check.sh \$6: File size must be between 0.01kb and 100kb"
    exit 1
else 
     echo "check.sh \$6: Correct files size"
fi

echo "check.sh: Stop check.sh script"