# Установка Grafana с использованием Docker
1. ## Установка Docker
```
apt install docker.io
```
2. ## Выбор образа Grafana
в данном случае наш выбор 
**Grafana Enterprise: grafana/grafana-enterprise**

3. ## Запуск Grafana через Docker CLI
3.1. **Запуск последней стабильной версии**
Для запуска последней стабильной версии Grafana выполните следующую команду:
```
docker run -d -p 3000:3000 --name=grafana grafana/grafana-enterprise
```
4. ## Остановка контейнера Grafana
Чтобы остановить контейнер Grafana, выполните следующую команду:
```
docker stop grafana
```


![{30DF4D01-154C-4537-AE18-61FDA17D69D9}](https://github.com/user-attachments/assets/1f26fa3d-964a-4a60-8e5e-3bc3aea90078)
