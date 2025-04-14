# Установка Prometheus

## Шаг 1: Скачивание и распаковка Prometheus

1. **Скачайте последнюю версию Prometheus для вашей платформы:**
```terminall
wget https://github.com/prometheus/prometheus/releases/download/v3.3.0-rc.1/prometheus-3.3.0-rc.1.linux-amd64.tar.gz 
```
2.**Распакуйте архив**
```terminall
tar xvfz prometheus-*.tar.gz
```

3.**Перейдите в каталог с распакованными файлами:**
```terminall
cd prometheus-3.3.0-rc.1.linux-amd64/
```

## Шаг 2: Установка (копирование файлов)

1.**Создайте каталоги для Prometheus:**
```
mkdir /etc/prometheus /var/lib/prometheus
```

2.**Распакуйте архив (если еще не распаковали):**
``` 
tar -zxf prometheus-*.linux-amd64.tar.gz
```
3.**Перейдите в каталог с распакованными файлами:**
```
cd prometheus-*.linux-amd64
```

4.**Распределите файлы по каталогам:**
```
cp prometheus promtool /usr/local/bin/
cp prometheus.yml /etc/prometheus
```

## Шаг 3: Назначение прав

1.**Создайте пользователя для Prometheus:**
```
useradd --no-create-home --shell /bin/false prometheus
```
2.**Задайте владельца для каталогов:**
```
chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
```
3**Задайте владельца для скопированных файлов:**
```
chown prometheus:prometheus /usr/local/bin/{prometheus,promtool}
```
## Шаг 4: Создание службы systemd для Prometheus
1.**Создайте новый сервис unit для systemd:**
```
sudo nano /etc/systemd/system/prometheus.service
```
2.**Добавьте следующее содержимое в файл:**
```
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
```
3.**Перезагрузите systemd, чтобы применить изменения:**
```
sudo systemctl daemon-reload
```
4.**Запустите Prometheus:**
```
sudo systemctl restart prometheus
``` 
5.**Включите Prometheus для автоматического запуска при загрузке:**
```
sudo systemctl enable prometheus
```
6.**Проверьте статус службы Prometheus:**
```
sudo systemctl status prometheus
```
## Мои ошибки : Устранение проблем с портом 9090
#### Если у вас возникли проблемы с портом 9090, выполните следующие действия:

1.**Проверьте статус службы для выявления ошибок:**
```
sudo systemctl status prometheus
```
2.**Чтобы узнать PID процесса, использующего порт, выполните:**
```
ps aux | grep prometheus
```
3.**Найдите нужный PID и завершите процесс:**
```
kill -9 <PID>
```
4.**Перезапустите Prometheus:**
```
sudo systemctl start prometheus
```
__Теперь Prometheus должен работать без проблем на порту 9090.__










