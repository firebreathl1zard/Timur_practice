установка Prometheus 
Скачайте последнюю версию Prometheus для своей платформы, затем распакуйте и запустите её
wget https://github.com/prometheus/prometheus/releases/download/v3.3.0-rc.1/prometheus-3.3.0-rc.1.linux-amd64.tar.gz
tar xvfz prometheus-*.tar.gz
cd prometheus-3.3.0-rc.1.linux-amd64/
Запуск " Прометея "
./prometheus --config.file=prometheus.yml
чтобы зайти на Prometheus используйте (ip-adress на котором установлена Prometheus :9090)   

Установка (копирование файлов)

Для начала создаем каталоги, в которые скопируем файлы для prometheus:

mkdir /etc/prometheus /var/lib/prometheus

Распакуем наш архив:

tar -zxf prometheus-*.linux-amd64.tar.gz

... и перейдем в каталог с распакованными файлами:

cd prometheus-*.linux-amd64

Распределяем файлы по каталогам:

cp prometheus promtool /usr/local/bin/
cp prometheus.yml /etc/prometheus


Выходим из каталога и удаляем исходник:

cd .. && rm -rf prometheus-*.linux-amd64/ && rm -f prometheus-*.linux-amd64.tar.gz

НАЗНАЧЕНИЯ ПРАВ 

Создаем пользователя, от которого будем запускать систему мониторинга:

useradd --no-create-home --shell /bin/false prometheus

* мы создали пользователя prometheus без домашней директории и без возможности входа в консоль сервера.


Задаем владельца для каталогов, которые мы создали на предыдущем шаге:

chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus

Задаем владельца для скопированных файлов:

chown prometheus:prometheus /usr/local/bin/{prometheus,promtool}


Step 4. Create Prometheus Systemd Service.

Create a new systemd unit file for Prometheus:

sudo nano /etc/systemd/system/prometheus.service
Add the following content to the unit file:

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

Reload systemd to apply the changes and start Prometheus:

sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
You can check the status of the Prometheus service to ensure it’s running without issues:

sudo systemctl status prometheus

у меня возникли пробемы с портом 9090 
для устранения делаем следующие действия 
смотрим статус ошибок для этого используем команду 
sudo systemctl status prometheus

чтобы узнать PID я использовал команду ps aux 
далее нашел нужный мне пид и отключил данный пид командой 
kill -9 (PID)  
далее я использовал команду 
 sudo systemctl куstart prometheus






