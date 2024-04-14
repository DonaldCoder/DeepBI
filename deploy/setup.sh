#!/usr/bin/env bash
apt update
apt-get install python3 python3-pip nginx python3-tk python3-psycopg2 python3-dev default-libmysqlclient-dev build-essential pkg-config -y
# 设置Nginx
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
cp -f bin/nginx.conf /etc/nginx/nginx.conf

# 设置Python环境
pip install --upgrade pip
pip install --no-cache-dir --upgrade -r /code/requirements.txt

cp -f bin/supervisord.conf /etc/supervisord.conf
mkdir -p /var/log/supervisor/
mkdir -p logs
mkdir -p .data
mkdir -p /code/.data
