#!/bin/bash

# Собираем информацию о ЦПУ
cpu_load_1m=$(cat /proc/loadavg | awk '{print $1}')
cpu_load_5m=$(cat /proc/loadavg | awk '{print $2}')
cpu_load_15m=$(cat /proc/loadavg | awk '{print $3}')
cpu_info=$(mpstat | tail -1)
cpu_sys=$(echo $cpu_info | awk '{print $6}')

# Собираем информацию об оперативной памяти
ram_memory_free=$(free -m | awk 'NR==2 {print $7}')

# Собираем информацию о жестком диске
disk_capacity_free=$(df -m / | tail -n 1 | awk '{print $4}')


echo "cpu_load_1m $cpu_load_1m"
echo "cpu_load_5m $cpu_load_5m"
echo "cpu_load_15m $cpu_load_15m"
echo "cpu_sys $cpu_sys"
echo "ram_free $ram_memory_free"
echo "disk_free $disk_capacity_free"
