#!/bin/bash
mkdir -p /data/gost && cd /data/gost && rm -rf gost
wget https://github.com/go-gost/gost/releases/download/v3.0.0-rc8/gost_3.0.0-rc8_linux_amd64.tar.gz
tar -zxvf gost_3.0.0-rc8_linux_amd64.tar.gz

cat > gost.yml <<EOF
services:
- name: service-0
  addr: :31400
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-0
      addr: 10.8.0.2:31400
- name: service-1
  addr: :31401
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-1
      addr: 10.8.0.2:31401
- name: service-2
  addr: :31402
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-2
      addr: 10.8.0.2:31402
- name: service-3
  addr: :31403
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-3
      addr: 10.8.0.2:31403
- name: service-4
  addr: :31404
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-4
      addr: 10.8.0.2:31404
- name: service-5
  addr: :31405
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-5
      addr: 10.8.0.2:31405
- name: service-6
  addr: :31406
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-6
      addr: 10.8.0.2:31406
- name: service-7
  addr: :31407
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-7
      addr: 10.8.0.2:31407
- name: service-8
  addr: :31408
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-8
      addr: 10.8.0.2:31408
- name: service-9
  addr: :31409
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-9
      addr: 10.8.0.2:31409
- name: service-10
  addr: :31410
  handler:
    type: tcp
  listener:
    type: tcp
  forwarder:
    nodes:
    - name: target-10
      addr: 10.8.0.2:31410
EOF      

cat > start.sh <<EOF
#!/bin/bash
cd /data/gost && nohup ./gost -C gost.yml >> /dev/null 2>&1
EOF

bash start.sh
