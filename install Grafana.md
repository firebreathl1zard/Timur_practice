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


