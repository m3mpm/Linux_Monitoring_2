## Задача 9. Свой _node_exporter_

- Напишем bash-скрипта `main.sh` для запуска bash-скрипта `run.sh` каждые 3 секунды и формирования html страницы, в которой будут храниться метрика системы

  ![main](./img/01.png)

- Bash-скрипта `run.sh` собирает метрику сисемы(ЦПУ, оперативная память, жесткий диск (объем))

  ![run](./img/02.png)

- Для того, **nginx** отдавал страницу необходимо для начала установку nginx на виртуальную машину:

  - `sudo apt update`
  - `sudo apt install nginx`

- После завершения установки служба Nginx запустится автоматически. Можно проверить это, запустив:

  - `sudo systemctl status nginx`

  ![nginx-status](./img/03.png)

- Внесем изменения в файл `/etc/nginx/nginx.conf`, чтобы сервер работал на порту `81` и отдавал страницу `index.html` по адресу `localhost:81/metrics`. `/metrics` нужен так как **Prometheus** по умолчанию берет данные с этого адреса

  ![nginx-conf](./img/04.png)

- Проведем перезапуск **nginx**:

  - `sudo systemctl restart nginx`

- Проведем проброс порта 81 в виртуальной машине

  ![vb-port](./img/05.png)

- Проверим статус **nginx**

  ![nginx-status](./img/06.png)

- Убедимся, что **nginx** отдает страницу с метрикой системы

  ![nginx-html-data](./img/07.png)

##### Поменяй конфигурационный файл **Prometheus**, чтобы он собирал информацию с созданной тобой странички.

- Внесем изменения в файл `/etc/prometheus/prometheus.yml`, чтобы он собирал информацию с созданной мной странички по адресу `localhost:81`

![prometheus-yml](./img/08.png)

- Проведите перезагрузку сервиса **Prometheus**:

  - `sudo systemctl reload prometheus.service`

- Поверим, что **Prometheus** работает корректно:

  - `sudo systemctl status prometheus.service`

![prometheus-status](./img/09.png)

- Проверим, что **Prometheus** принимает данные со странички:

![prometheus-targets](./img/10.png)

- Создадим в **Grafana** новый дашбор `My Node`

![grafana-my-nod](./img/11.png)

- В дашбор `My Node` добавим первые данные: `cpu_load_1m`.

  - При добавление панели на дашбор в поле `Query` выбираем `Prometheus` как источник данных

  - В поле `Metrics` выбираем `cpu`, далее `cpu_load_1m` - как название поля на страничке `index.html`, которую отдает **nginx**

![cpu-load-1m](./img/12.png)

- Получим панель с данными `cpu_load_1m`

![cpu-load-1m](./img/13.png)

- Добавим таким же образом остальные данные в дашбор `My Node`

![my-node-dashboard](./img/14.png)

##### Проведи те же тесты, что и в `Части 7`

- Запусти свой bash-скрипт из `Части 2`

![task02-terminal](./img/15.png)

- Посмотрим на нагрузку жесткого диска (место на диске)

- Резльтат в интервале 5 минут

![grafana-task02-result-5m](./img/16.png)

- Резльтат в интервале 15 минут

![grafana-task02-result-15m](./img/17.png)

- Очистка диска

![task03-terminal](./img/18.png)

- Резльтат в интервале 5 минут

![grafana-task03-result-5m](./img/19.png)

- Резльтат в интервале 15 минут

![grafana-task03-result-15m](./img/20.png)

- Используя утилиту **stress** и запусти команду `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s`

![stress-terminal](./img/21.png)

- Посмотрим на нагрузку жесткого диска, оперативной памяти и ЦПУ.

- Резльтат в интервале 5 минут

![grafana-result](./img/22.png)

- Резльтат в интервале 15 минут

![grafana-result](./img/23.png)

- Резльтат в интервале 30 минут

![grafana-result](./img/24.png)

- Резльтат в интервале 1 часа

![grafana-result](./img/25.png)
