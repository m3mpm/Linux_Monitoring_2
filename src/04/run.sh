#!/bin/bash

echo "*************************"
echo "run.sh: Start run.sh script"

# объявление массивов данных для генерации
codes_arr=(200 201 400 401 403 404 500 501 502 503) #10
methods_arr=(GET POST PUT PATCH DELETE) #5
agents_arr=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool") #8

# объявление массивов данных для генерации url
ulr_domuplevel_arr=(com de cn net org info ru su edu gov biz dev sa nz) #14
url_domen_arr=(yandex vk mail ok habr google yahoo facebook twitter mi samsung apple porn chatgpt telegram youtube amazon wikipedia 2gis) #19
url_page_arr=(goodzoom suncast signtime betastar zooline primepoint treephase java php goland js goldway aurabar aurabar wondermobile lemonbite gorillawater joypoly) #18
ulr_protocol_arr=(http https) #2

# функция получения даты для первого лог файла
function get_first_date_f {
    # 630720000 - 20 лет в секундах
    # выбор рандомное число
    date_shift=$(shuf -i 1-630720000 -n 1)

    # получения рандомной даты от 2000-01-01
    date=$(date -d "2000-01-01 + $date_shift sec" +'%Y-%m-%d')
    echo $date
}

# функция получения времени для записи в лог файле
# на вход приходи date: дата и record_time_shift: временной сдвиг
# каждый раз временной сдвиг увеличивается, тем самым получаем новое время для записи в лог файле 
function get_record_time_f {
    echo $(date --date "$1 + $2 sec" +'%d/%b/%Y:%T %z')
}

# функция получения временного сдвига для каждой записи
function get_random_shift_f {
    echo $(shuf -i $1-$(($1 + $(shuf -i 1-300 -n 1))) -n 1)
}

# функция генерация ip address для записи в лог файле
function get_ip_f {
    ip="$(shuf -i 1-255 -n 1).$(shuf -i 0-255 -n 1).$(shuf -i 0-255 -n 1).$(shuf -i 0-255 -n 1)"
    echo $ip
}

# функция рандомного выбора метода запроса для записи в лог файле
function get_method_f {
    arr_size=$((${#methods_arr[@]} - 1))
    indx_method=$(shuf -i 0-$arr_size -n 1)
    random_method=${methods_arr[indx_method]}
    echo $random_method
}

# функция рандомного выбора домена верхнего уровня url для записи в лог файле
function get_updomen_f {
    arr_size=$((${#ulr_domuplevel_arr[@]} - 1))
    indx_updome=$(shuf -i 0-$arr_size -n 1)
    rand_updome=${ulr_domuplevel_arr[indx_updome]}
    echo $rand_updome
}

# функция рандомного выбора страницы url для записи в лог файле
function get_page_f {
    arr_size=$((${#url_page_arr[@]} - 1))
    indx_page=$(shuf -i 0-$arr_size -n 1)
    rand_page=${url_page_arr[indx_page]}
    echo $rand_page
}

# функция рандомного выбора кода ответа для записи в лог файле
function get_code_f {
    arr_size=$((${#codes_arr[@]} - 1))
    indx_code=$(shuf -i 0-$arr_size -n 1)
    rand_code=${codes_arr[indx_code]}
    echo $rand_code
}

# функция генерации размера объекта, возвращаемого клиенту, не включая заголовки ответа
function get_bytes_f {
    if (($1 == 200 || $1 == 201)); then
        echo $(($RANDOM))
    elif (($1 >= 400 && $1 <= 404)); then
        echo $((1 + RANDOM % 404))
    else
        echo "-"
    fi
}

# функция рандомного выбора протокола для записи в лог файле
function get_protocol_f {
    arr_size=$((${#ulr_protocol_arr[@]} - 1))
    indx_protocol=$(shuf -i 0-$arr_size -n 1)
    rand_protocol=${ulr_protocol_arr[indx_protocol]}
    echo $rand_protocol
}

# функция рандомного выбора домена url для записи в лог файле
function get_domen_f {
    arr_size=$((${#url_domen_arr[@]} - 1))
    indx_domen=$(shuf -i 0-$arr_size -n 1)
    rand_dome=${url_domen_arr[indx_domen]}
    echo $rand_dome
}

# функция рандомного выбора агента для записи в лог файле
function get_agent_f {
    arr_size=$((${#agents_arr[@]} - 1))
    indx_agent=$(shuf -i 0-$arr_size -n 1)
    rand_agent=${agents_arr[indx_agent]}
    echo $rand_agent
}

# ********************** Main Function **********************

# ввод количество лог файлов пользователем
echo -n "Enter a number of log files: "
read log_number

log_path=$(pwd) # переменная для хранения пути до лог файлов
date=$(get_first_date_f) # переменная для хранения даты лог файлов

if [[ $log_number -gt 0 ]]
then
    # цикл для создания лог файлов
    for (( i=1; i <= $log_number; i++ ))
    do
        # получение первого рандомного временного сдвига для записи в лог файл
        record_time_shift=$(shuf -i 1-300 -n 1)
        
        # получение рандомное количество записей в лог файле, от 100 до 1000
        records_number=$(shuf -i 100-1000 -n 1)

        # цикл создания записей в каждом лог файле
        for (( j=1; j <= $records_number; j++ ))
        do
            ip=$(get_ip_f) # ip address
            record_date_time=$(get_record_time_f $date $record_time_shift) # дата и время записи в лог файле
            method=$(get_method_f) # метод запроса
            updome=$(get_updomen_f) # домена верхнего уровня url
            page=$(get_page_f) # страница url
            code=$(get_code_f) # код состояния, который сервер отправляет обратно клиенту
            bytes=$(get_bytes_f $code) # размер объекта, возвращаемого клиенту
            protocol=$(get_protocol_f) # протокол передачи данных в интернете
            domen=$(get_domen_f) # домен url
            agent=$(get_agent_f) # клиентский браузер
            
            # формирование записи в лог файле
            record="$ip - - [$record_date_time] \"$method /$updome/$page HTTP/1.1\" $code $bytes \"$protocol://$domen.$updome/$page\" \"$agent\""
            
            # запись в лог файл
            echo $record >> $log_path/$date.log

            # увеличение временного сдвига, чтобы увеличить время записи в лог файле
            record_time_shift=$(shuf -i $record_time_shift-$(($record_time_shift + $(shuf -i 1-300 -n 1))) -n 1)
            
            # реализация увеличение временного сдвига через функцию get_random_shift_f
            # record_time_shift=$(get_random_shift_f $record_time_shift)
        done
        # получение следующей даты лог файла с шагом в 1 день
        date=$(date --date "$date + 1 day" +'%Y-%m-%d')
    done
else
    echo "run.sh: Stop run.sh script"
    echo "run.sh: Error2: Enter a number greater than zero "
fi

echo "run.sh: Stop run.sh script"
echo "*************************"


# 200 OK — успешный запрос. Если клиентом были запрошены какие-либо данные, то они находятся в заголовке и/или теле сообщения

# 201 Created — в результате успешного выполнения запроса был создан новый ресурс. Новый ресурс эффективно создаётся до отправки этого ответа. И новый ресурс возвращается в теле сообщения, его местоположение представляет собой либо URL-адрес запроса, либо содержимое заголовка Location.

# 400 Bad Request — сервер обнаружил в запросе клиента синтаксическую ошибку.

# 401 Unauthorized — для доступа к запрашиваемому ресурсу требуется аутентификация. Иными словами, для доступа к запрашиваемому ресурсу клиент должен представиться, послав запрос, включив при этом в заголовок сообщения поле Authorization с требуемыми для аутентификации данными. Если запрос уже включает данные для авторизации, ответ 401 означает, что в авторизации с ними отказано.

# 403 Forbidden — сервер понял запрос, но он отказывается его выполнять из-за ограничений в доступе для клиента к указанному ресурсу. Иными словами, клиент не уполномочен совершать операции с запрошенным ресурсом. Если для доступа к ресурсу требуется аутентификация средствами HTTP, то сервер вернёт ответ 401, или 407 при использовании прокси. В противном случае ограничения были заданы администратором сервера или разработчиком веб-приложения и могут быть любыми в зависимости от возможностей используемого программного обеспечения. В любом случае серверу следует сообщить причины отказа в обработке запроса. Наиболее вероятными причинами ограничения может послужить попытка доступа к системным ресурсам веб-сервера (например, файлам .htaccess или .htpasswd) или к файлам, доступ к которым был закрыт с помощью конфигурационных файлов

# 404 Not Found[24] — самая распространённая ошибка при пользовании Интернетом, основная причина — ошибка в написании адреса Web-страницы. Сервер понял запрос, но не нашёл соответствующего ресурса по указанному URL. Если серверу известно, что по этому адресу был документ, то ему желательно использовать код 410. Ответ 404 может использоваться вместо 403, если требуется тщательно скрыть от посторонних глаз определённые ресурсы. Появился в HTTP/1.0.

# 500 Internal Server Error — любая внутренняя ошибка сервера, которая не входит в рамки остальных ошибок класса.

# 501 Not Implemented — сервер не поддерживает возможностей, необходимых для обработки запроса. Типичный ответ для случаев, когда сервер не понимает указанный в запросе метод. Если же метод серверу известен, но он не применим к данному ресурсу, то нужно вернуть ответ 405

# 502 Bad Gateway — сервер, выступая в роли шлюза или прокси-сервера, получил недействительное ответное сообщение от вышестоящего сервера.

# 503 Service Unavailable — сервер временно не имеет возможности обрабатывать запросы по техническим причинам (обслуживание, перегрузка и прочее). В поле Retry-After заголовка сервер может указать время, через которое клиенту рекомендуется повторить запрос. 