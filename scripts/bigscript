#!/bin/bash
# показывает  дату
date

# показывает ип адресс
hostname -I | awk '{print $1}'
# отображает пользователей просто по именам
compgen -u

# создает дириктории и в них файлы

for dir in dir1 dir2 dir3; do
    mkdir "$dir"
    for i in {1..5}; do
        touch "$dir/file$i.txt"
    done
done

# показывает дерево
tree /root/dir1 dir2 dir3

