#!/bin/bash

echo "main.sh: Start main.sh script"
if [[ $# -eq 0 ]];
then
    log_path=$(pwd)
    log_path=${log_path/%06/04}
    goaccess -f $log_path/*.log --log-format=COMBINED -o index.html
else
    echo "main.sh: Error1: No need parameters"
    echo "main.sh: Example: ./main.sh"
fi
echo "main.sh: Stop main.sh script"

# 1. На виртуальной машине: запустить команду в другом окне терминала в папке 06 "python3 -m http.server" - запуск модуля сервера
# 2. На локальной машине: в браузере ввести адрес: http://localhost:8000/
