## Задача 8. Готовый дашборд

##### Установить готовый дашборд _Node Exporter Quickstart and Dashboard_ с официального сайта **Grafana Labs**.

- После регистрации на официальном сайте **Grafana Labs** находим _Node Exporter Quickstart and Dashboard_ и копируем ID dashboard или скачиваем JSON файл

![grafana_labs](./img/01.png)

- Далее заходим в **Grafana** на локальной машине, выбираем пункт Manage в Dashboards и нажимаем на кнопку `Import`

![grafana](./img/02.png)

- Переходим в окно загрузки готового дашборда

![grafana](./img/03.png)

- Вводим ID dashboard или загружаем JSON файл. Даем имя для данного дашборда и выбираем папку где будет данный дашборд в **Grafana** находиться. Нажимаем на кнопку `Import`

![grafana](./img/04.png)

- Получаем готовый дашборд _Node Exporter Quickstart and Dashboard_

![grafana](./img/05.png)

##### Провести те же тесты, что и в `Части 7`

- Запусти свой bash-скрипт из `Части 2`

![task02-terminal](./img/06.png)

- Посмотри на нагрузку жесткого диска (место на диске и операции чтения/записи)

![grafana-result-5m](./img/07.png)

![grafana-result-15m](./img/08.png)

- Очистка диска

![task03-terminal](./img/09.png)

![grafana-result](./img/10.png)

- Используя утилиту **stress** и запустить команду `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s`

![stress-terminal](./img/11.png)

- Посмотреть на нагрузку жесткого диска, оперативной памяти и ЦПУ

![grafana-result-5m](./img/12.png)

![grafana-result-15m](./img/13.png)

##### Запустить ещё одну виртуальную машину, находящуюся в одной сети с текущей.

![virtual-box-all](./img/14.png)

- Проверка соединения между двумя машинами

![ping-from-1](./img/15.png)

![ping-from-2](./img/16.png)

##### Запустить тест нагрузки сети с помощью утилиты **iperf3**.

- Запуск утилиты **iperf3** на сервере, IP сервера: 10.10.0.1

![iperf3-server](./img/17.png)

- Запуск утилиты **iperf3** на клиенте, IP клиента: 10.10.0.2

![iperf3-client](./img/18.png)

##### Посмотреть на нагрузку сетевого интерфейса.

![grafana-network-result](./img/19.png)
