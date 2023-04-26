#!/bin/bash

# 二进制部署categraf监控主机

## 停止已有的categraf
sudo systemctl stop categraf.service
rm -rf /opt/service/categraf

## 下载安装包
mkdir -p  /opt/service/categraf && cd /opt/service/categraf
yum install -y wget
wget https://github.com/flashcatcloud/categraf/releases/download/v0.3.0/categraf-v0.3.0-linux-amd64.tar.gz
tar -zxvf categraf-v0.3.0-linux-amd64.tar.gz
cd categraf-v0.3.0-linux-amd64/conf

## 修改categraf配置
cat > config.toml << EOF
[global]
print_configs = false
hostname = ""
omit_hostname = false
precision = "ms"
interval = 15
providers = ["local"]
disable_usage_report = true
[global.labels]
[log]
file_name = "stdout"
max_size = 100
max_age = 1
max_backups = 1
local_time = true
compress = false
[writer_opt]
batch = 1000
chan_size = 1000000
[[writers]]
url = "http://10.202.0.17:30010/prometheus/v1/write"
basic_auth_user = ""
basic_auth_pass = ""
timeout = 5000
dial_timeout = 2500
max_idle_conns_per_host = 100
[http]
enable = false
address = ":9100"
print_access = false
run_mode = "release"
[ibex]
enable = false
interval = "1000ms"
servers = ["127.0.0.1:20090"]
meta_dir = "./meta"
[heartbeat]
enable = true
url = "http://10.202.0.17:30010/v1/n9e/heartbeat"
interval = 10
basic_auth_user = ""
basic_auth_pass = ""
timeout = 5000
dial_timeout = 2500
max_idle_conns_per_host = 100
EOF

## 配置system管理categraf
cat > /etc/systemd/system/categraf.service << EOF
[Unit]
Description="Categraf"
After=network.target

[Service]
Type=simple

ExecStart=/opt/service/categraf/categraf-v0.3.0-linux-amd64/categraf
WorkingDirectory=/opt/service/categraf/categraf-v0.3.0-linux-amd64

Restart=on-failure
SuccessExitStatus=0
LimitNOFILE=65536
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=categraf

[Install]
WantedBy=multi-user.target
EOF

## 启动categraf
sudo systemctl daemon-reload
sudo systemctl start categraf.service
sudo systemctl enable categraf.service
sudo systemctl status categraf.service

## 故障排除命令
# sudo systemctl status categraf.service
# sudo journalctl -u categraf.service --no-pager
# ./categraf --test --inputs mem:system
# ./categraf --test --debug
# 查看n9e基础设施->对象列表，看能否查看到刚加入的主机。
