# Установка Node Exporter 

## 1. Создание системного пользователя
Для начала создадим системного пользователя для Node Exporter:

```
sudo useradd \
--system \
--no-create-home \
--shell /bin/false node_exporter
```

## 2. Скачивание Node Exporter
Загрузите последнюю версию Node Exporter:
```
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
```
вместо версии 1.9.1 впишите свою версию в данном случае у меня 1.9.1

## 3. Извлечение файлов
Извлеките содержимое архива:

```
tar -xvf node_exporter-1.9.1.linux-amd64.tar.gz
```
## 4. Перемещение бинарного файла
Переместите бинарный файл в папку /usr/local/bin:
```
sudo mv node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/
```
## 5. Очистка
Удалите архив и папку:
```
rm -rf node_exporter*
```
## 6. Проверка установки
Убедитесь, что Node Exporter установлен правильно:
```
node_exporter --version
```
## 7. Создание файла службы Systemd
Создайте файл службы для Node Exporter:
```
sudo nano /etc/systemd/system/node_exporter.service
```
Вставьте следующий код:

```
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
```
## 8. Активация службы
Включите автоматический запуск Node Exporter после перезагрузки:
```
sudo systemctl enable node_exporter
```
## 9. Запуск Node Exporter
Запустите Node Exporter:
```
sudo systemctl start node_exporter
```
## 10. Проверка состояния
Проверьте состояние Node Exporter:

sudo systemctl status node_exporter
## 11. Проверка логов
Если возникли проблемы, проверьте логи:
```
journalctl -u node_exporter -f --no-pager
```
# Добавление Node Exporter в Prometheus
##1. Редактирование конфигурации Prometheus
Откройте файл конфигурации Prometheus:
```
sudo nano /etc/prometheus/prometheus.yml
```
Добавьте следующую конфигурацию:
```
- job_name: node_export
  static_configs:
    - targets: ["localhost:9100"]
```
## 2. Проверка конфигурации
Проверьте корректность конфигурации:
```
promtool check config /etc/prometheus/prometheus.yml
```
## 3. Перезагрузка Prometheus
Перезагрузите конфигурацию Prometheus:
```
sudo systemctl restart node_exporter
```
## 4. Проверка целей
Убедитесь, что Node Exporter добавлен в список целей:
```
http://<ip>:9090/targets
```
**Теперь Node Exporter успешно установлен и интегрирован с Prometheus!**

