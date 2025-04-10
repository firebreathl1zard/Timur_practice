#Установка Node Exporter на Ubuntu 22.04

##1. Создание системного пользователя
Для начала создадим системного пользователя для Node Exporter:

```bash
sudo useradd \
--system \
--no-create-home \
--shell /bin/false node_exporter

2. Скачивание Node Exporter
Загрузите последнюю версию Node Exporter:

bash
Run
Copy code
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
3. Извлечение файлов
Извлеките содержимое архива:

bash
Run
Copy code
tar -xvf node_exporter-1.6.1.linux-amd64.tar.gz
4. Перемещение бинарного файла
Переместите бинарный файл в папку /usr/local/bin:

bash
Run
Copy code
sudo mv node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/
5. Очистка
Удалите архив и папку:

bash
Run
Copy code
rm -rf node_exporter*
6. Проверка установки
Убедитесь, что Node Exporter установлен правильно:

bash
Run
Copy code
node_exporter --version
7. Создание файла службы Systemd
Создайте файл службы для Node Exporter:

bash
Run
Copy code
sudo vim /etc/systemd/system/node_exporter.service
Вставьте следующий код:

ini
Run
Copy code
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
8. Активация службы
Включите автоматический запуск Node Exporter после перезагрузки:

bash
Run
Copy code
sudo systemctl enable node_exporter
9. Запуск Node Exporter
Запустите Node Exporter:

bash
Run
Copy code
sudo systemctl start node_exporter
10. Проверка состояния
Проверьте состояние Node Exporter:

bash
Run
Copy code
sudo systemctl status node_exporter
11. Проверка логов
Если возникли проблемы, проверьте логи:

bash
Run
Copy code
journalctl -u node_exporter -f --no-pager
Добавление Node Exporter в Prometheus
1. Редактирование конфигурации Prometheus
Откройте файл конфигурации Prometheus:

bash
Run
Copy code
sudo vim /etc/prometheus/prometheus.yml
Добавьте следующую конфигурацию:

yaml
Run
Copy code
- job_name: node_export
  static_configs:
    - targets: ["localhost:9100"]
2. Проверка конфигурации
Проверьте корректность конфигурации:

bash
Run
Copy code
promtool check config /etc/prometheus/prometheus.yml
3. Перезагрузка Prometheus
Перезагрузите конфигурацию Prometheus:

bash
Run
Copy code
curl -X POST http://localhost:9090/-/reload
4. Проверка целей
Убедитесь, что Node Exporter добавлен в список целей:

bash
Run
Copy code
http://<ip>:9090/targets
**Теперь Node Exporter успешно установлен и интегрирован с Prometheus!**

