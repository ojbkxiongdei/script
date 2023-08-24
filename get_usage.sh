#!/bin/bash
# 每分钟记录linux主机cpu 内存 磁盘使用率 for临时测试

while true; do
    # 获取当前时间
    timestamp=$(date +"%Y-%m-%d %T")

    # 获取内存使用率
    mem_usage=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')

    # 获取 CPU 使用率
    cpu_usage=$(top -bn1 | awk '/Cpu/{printf("%.2f"), $2}')

    # 获取磁盘使用率
    disk_usage=$(df -h | awk '$NF=="/"{printf("%.2f"), $5}')

    # 写入日志文件
    echo "$timestamp Memory Usage: $mem_usage% CPU Usage: $cpu_usage% Disk Usage: $disk_usage% $network_usage" >> 1.log

    # 等待一分钟
    sleep 60
done
