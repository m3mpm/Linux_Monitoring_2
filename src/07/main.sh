#!/bin/bash

# Источники
# https://cloud.vk.com/docs/dbs/dbaas/how-to-guides/case-node-exporter
# https://www.linode.com/docs/guides/how-to-install-prometheus-and-grafana-on-ubuntu/
# https://losst.pro/ustanovka-i-nastrojka-prometheus#ustanovka-i-nastroyka-prometheus

# https://losst.pro/ustanovka-i-nastrojka-grafana#nastroyka-grafana
# https://grafana.com/grafana/download?edition=enterprise


# ****** Установка Prometheus ******
# 1. Обновление Ubuntu
sudo apt update

# 2. Скачайте Prometheus и распакуйте скачанный архив
export VERSION="2.53.1"
sudo wget https://github.com/prometheus/prometheus/releases/download/v$VERSION/prometheus-$VERSION.linux-amd64.tar.gz -O - | sudo tar -xzv -C /tmp


# 3. Создайте два новых каталога для использования Prometheus.
# /etc/prometheus - Каталог хранит файлы конфигурации Prometheus.
# /var/lib/prometheus - Каталог хранит данные приложения.
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

# 4. Скопируйте содержимое репозитория prometheus-2.53.1.linux-amd64:

# 4.1 Копировать каталоги prometheusи promtoolв /usr/local/bin/каталог. Это сделает Prometheus доступным для всех пользователей.
sudo cp /tmp/prometheus-$VERSION.linux-amd64/prometheus /usr/local/bin
sudo cp /tmp/prometheus-$VERSION.linux-amd64/promtool /usr/local/bin

# 4.2 Каталоги consolesи console_libraries содержат ресурсы, необходимые для создания настраиваемых консолей
# Эта функция более продвинутая
# Однако эти папки также следует переместить в каталог etc/prometheusна случай, если они когда-либо понадобятся.
sudo cp -r /tmp/prometheus-$VERSION.linux-amd64/consoles /etc/prometheus
sudo cp -r /tmp/prometheus-$VERSION.linux-amd64/console_libraries /etc/prometheus

# 4.3 Переместите/создайте prometheus.yml файл конфигурации YAML в /etc/prometheusкаталог.
sudo cp /tmp/prometheus-$VERSION.linux-amd64/prometheus.yml /etc/prometheus/

# ИЛИ

# 4.3 Или создайте prometheus.yml файл конфигурации YAML в /etc/prometheus каталог.
echo -e "global:
  scrape_interval:  10s
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']" > prometheus.yml

sudo cp prometheus.yml /etc/prometheus/

# 5. (Опционально) Удалите файлы из временной директории:
sudo rm -rf /tmp/prometheus-$VERSION.linux-amd64   

# 6. Убедитесь, что Prometheus успешно установлен, с помощью следующей команды:
prometheus --version

# 7. Создайте группу и пользователя prometheus, назначьте ему права на связанные репозитории:
sudo groupadd --system prometheus
sudo useradd --system -g prometheus -s /bin/false prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus /etc/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool

# 8. Чтобы разрешить Prometheus работать как служба, создайте prometheus.service файл с помощью следующей команды:
echo -e "[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries
ExecReload=/bin/kill -HUP $MAINPID
[Install]
WantedBy=default.target" > prometheus.service

sudo cp prometheus.service /etc/systemd/system/

# 9. Перезагрузите systemctl демон
sudo systemctl daemon-reload

# 10. Запустите Prometheus:
sudo systemctl enable prometheus.service
sudo systemctl start prometheus.service

# 11. Убедитесь, что Prometheus работает корректно:
sudo systemctl status prometheus.service


# ****** Установка Grafana ******
# 1. Установите некоторые необходимые утилиты с помощью apt
sudo apt-get install -y apt-transport-https software-properties-common

# 2. Установить её из официального репозитория самой программы. Чтобы добавить репозиторий, выполните такие команды
sudo curl https://packagecloud.io/gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

# 3. Затем нужно обновить список пакетов:
sudo apt-get update

# 4. Установка Grafana Ubuntu:
sudo apt-get install grafana

# !!!!Все инструкции выше не работают, нашел пакет grafana-enterprise_10.0.3_amd64.deb, забросил на виртуалку и установил его через:
sudo dpkg -i grafana-enterprise_10.0.3_amd64.deb

# 5. Перезагрузите systemctlдемон.
sudo systemctl daemon-reload

# 6. Включить и запустить сервер Grafana
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

# 7. Проверьте статус сервера Grafana и убедитесь, что он находится в activeсостоянии.
sudo systemctl status grafana-server

# ****** Установка Node Exporter ******
# Прежде чем удаленную систему можно будет контролировать, она должна иметь какой-либо тип клиента для сбора статистики. Доступно несколько сторонних клиентов. Однако для простоты использования Prometheus рекомендует клиент Node Exporter. После установки Node Exporter на клиенте клиент можно добавить в список серверов для сбора данных prometheus.yml.

# 1. Скачайте Node Exporter и распакуйте скачанный архив
export VERSION="1.3.1"
sudo wget  https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz -O - | sudo tar -xzv -C /tmp

# 2. Скопируйте содержимое репозитория node_exporter-1.3.1.linux-amd64:
sudo cp /tmp/node_exporter-$VERSION.linux-amd64/node_exporter /usr/local/bin

# 3. Установитль владельца папки /usr/local/bin/node_exporter, пользователя prometheus
sudo chown -R prometheus:prometheus /usr/local/bin/node_exporter

# 4. Создать файл node_exporter.service и внести в него данные
###
echo -e "[Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
Type=simple
Restart=always
User=prometheus
Group=prometheus
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target" > node_exporter.service
###

# 5. Копировать файл node_exporter.service в папку /etc/systemd/system/
sudo cp node_exporter.service /etc/systemd/system/

# 6. (Опционально) Удалите файлы из временной директории:
sudo rm -r /tmp/node_exporter-$VERSION.linux-amd64*

# 7. Перезагрузите systemctl демон
sudo systemctl daemon-reload

# 8. Запустите Node Exporter:
sudo systemctl enable node_exporter.service
sudo systemctl start node_exporter
sudo systemctl status node_exporter

# 9. Убедитесь, что Node Exporter работает корректно:
sudo systemctl status node_exporter.service


# 10. В файле /etc/prometheus/prometheus.yml добавьте содержимое в блок scrape_configs:

###
echo -e "  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9100']" >> /etc/prometheus/prometheus.yml
###

# 11. Проведите перезагрузку сервиса Prometheus
sudo systemctl reload prometheus.service