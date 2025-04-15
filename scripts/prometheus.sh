#!/bin/bash
echo "скачиваю prometheus"
wget https://github.com/prometheus/prometheus/releases/download/v3.3.0-rc.1/prometheus-3.3.0-rc.1.lin>echo "расспаковка архива"
tar xvfz prometheus-*.tar.gz
echo "переход в каталог с расспакованными файлами"
cd prometheus-3.3.0-rc.1.linux-amd64/
echo "создаю коталог для Prometheus"
mkdir /etc/prometheus /var/lib/prometheus
echo "расспределяю файлы по каталогам"
cp prometheus promtool /usr/local/bin/
cp prometheus.yml /etc/prometheus
echo "переход в родительскую дирикторию"
cd ..
echo "удоляю копию"
rm -rf prometheus-*
echo "создаю пользователя для prometheus"
useradd --no-create-home --shell /bin/false prometheus
echo "обозначаю владельца для котталогов"
chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
echo "Задаю владельца для скопированных файлов"
chown prometheus:prometheus /usr/local/bin/{prometheus,promtool}
echo "создаю юнит сервис для systemd"
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
echo "Перезагружа systemd, чтобы применить изменения"
systemctl daemon-reload
echo "перезагружаю prometheus"
systemctl restart prometheus
echo "включаю prometheus для автоматического запуска"
systemctl enable prometheus
echo "проверяю статус сервера"
systemctl status prometheus
echo "проверяю статус сервера"
systemctl status node_exporter
