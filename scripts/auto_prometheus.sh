#!/bin/bash

wget https://github.com/prometheus/prometheus/releases/download/v3.3.0-rc.1/prometheus-3.3.0-rc.1.linux-amd64.tar.gz

tar xvfz prometheus-*.tar.gz

cd prometheus-3.3.0-rc.1.linux-amd64/

mkdir /etc/prometheus /var/lib/prometheus

cp prometheus promtool /usr/local/bin/
cp prometheus.yml /etc/prometheus

cd ..

rm -rf prometheus-*

useradd --no-create-home --shell /bin/false prometheus

chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus

chown prometheus:prometheus /usr/local/bin/{prometheus,promtool}

cat << EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
ExecStart=/usr/local/bin/prometheus \
 --config.file=/etc/prometheus/prometheus.yml \
 --storage.tsdb.path=/var/lib/prometheus/

[Install]
WantedBy=multi-user.target

EOF

systemctl daemon-reload

systemctl restart prometheus

systemctl enable prometheus

systemctl status prometheus
