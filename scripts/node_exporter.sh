#!/bin/bash
echo "этап 1 создаем системного пользователя для Node Exporter"
sudo useradd \
--system \
--no-create-home \
--shell /bin/false node_exporter
echo "Э-2 Загрузка последнюю версию Node Exporte"
wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz
echo "Э-3 Извлекаем содержимое архива"
tar -xvf node_exporter-1.9.1.linux-amd64.tar.gz
echo "Э-4 Перемещаем бинарный файл в папку /usr/local/bin"
sudo mv node_exporter-1.9.1.linux-amd64/node_exporter /usr/local/bin/
echo "Э-5 Удаляем архив и папку"
rm -rf node_exporter-*
echo  "Э-6 Убеждаемся, что Node Exporter установлен правильно"
node_exporter --version
echo "Э-7 Создайте файл службы для Node Exporter"
cat << EOF > /etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target
StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User =node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter --collector.logind

[Install]
WantedBy=multi-user.target

EOF
echo "Э-8 Включаем автоматический запуск Node Exporter после перезагрузки"
systemctl enable node_exporter
echo "Э-9 Запускаем Node Exporter"
systemctl start node_exporter
echo "Э-10 Проверяем состояние Node Exporter"
#journalctl -u node_exporter -f --no-pager
echo "Э-11 Редактирование конфигурации Prometheus"
cat << EOF >> /etc/prometheus/prometheus.yml

  - job_name: node_export
    static_configs:
      - targets: ["localhost:9100"]

EOF
echo "Э-12 перезапускаем node_exporter"
systemctl restart node_exporter
echo "перезапускаем prometheus"
systemctl restart prometheus
