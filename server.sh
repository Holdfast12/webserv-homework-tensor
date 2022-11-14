#!/bin/bash
sudo yum install -y epel-release && sudo yum install -y nginx
sudo mkdir /usr/share/nginx/kalyujniy-s1.ru /usr/share/nginx/kalyujniy-s2.ru
for i in {1,2}; do echo "kalyujniy-s$i test suite" | sudo tee /usr/share/nginx/kalyujniy-s$i.ru/index.html; done
sudo echo -en "server {\n        listen 80;\n        root /usr/share/nginx/kalyujniy-s1.ru;\n        index index.html index.htm;\n        server_name kalyujniy-s1.ru;\n        try_files \$uri \$uri/ = 404;\n}\n" | sudo tee /etc/nginx/conf.d/kalyujniy-s1.ru.conf
sudo echo -en "server {\n        listen 80;\n        root /usr/share/nginx/kalyujniy-s1.ru;\n        index index.html index.htm;\n        server_name kalyujniy-s2.ru;\n        try_files \$uri \$uri/ = 404;\n}\n" | sudo tee /etc/nginx/conf.d/kalyujniy-s2.ru.conf
sudo systemctl enable nginx --now