#!/bin/bash

###Скрипт выполняющий автоматизацию выполнения ДЗ№8

#Часть 1

#копируем из расшаренной папки /vagrant необходимые конфигурационные файлы в виртуальную среду
cp /vagrant/watchlog /etc/sysconfig/
sleep 1

cp /vagrant/watchlog.log /var/log/
sleep 1

cp /vagrant/watchlog.sh /opt/
sleep 1
chmod +x /opt/watchlog.sh
ls -la /opt/watchlog.sh
sleep 1

cp /vagrant/watchlog.service /usr/lib/systemd/system/
cp /vagrant/watchlog.timer /usr/lib/systemd/system/

sleep 5

#запускаем таймер
systemctl start watchlog.timer

#Часть 2

#устанавливаем пакеты spawn-fcgi для 2 задания ДЗ
yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y
sleep 3

#копируем из расшаренной папки /vagrant необходимые конфигурационные файлы в виртуальную среду
cp /vagrant/spawn-fcgi /etc/sysconfig/
sleep 3

cp /vagrant/spawn-fcgi.service /etc/systemd/system/

#запускаем spawn-fcgi
systemctl start spawn-fcgi

#часть 3

rm -f /usr/lib/systemd/system/httpd.service
cp /vagrant/httpd.service /usr/lib/systemd/system/

cp /vagrant/httpd-first /etc/sysconfig/
cp /vagrant/httpd-second /etc/sysconfig/

rm -f /etc/httpd/conf/httpd.conf
cp /vagrant/first.conf /etc/httpd/conf/
cp /vagrant/second.conf /etc/httpd/conf/

#запускаем сервисы
systemctl start httpd@first
systemctl start httpd@second

ss -tnulp | grep httpd








