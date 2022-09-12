### Домашнее задание №8 (Systemd)
#### Предварительный тюнинг:
* Создан Vagrantfile на основе __almalinux/8__;
* Настроен запуск виртуальной машины с правами root;
* В виртуальной машине установлен VirtualBox Guest Addition, на ВМ расшарена папка /vagrant;
* Написан скрипт __systemd.sh__  в целях автоматизации выполнения домашнего задания;
* В Vagrantfile прописан автозапуск скрипта;
#### 1. Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова. Файл и слово должен задаваться в /etc/sysconfig.
* Создал файл с конфигурацией для сервиса в директории [/etc/sysconfig/watchlog](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/watchlog);
* Создал лог файл [/var/log/watchlog.log](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/watchlog.log). Слово, корое будет искать сервис: "ALERT";
* Написан скрипт [watchlog.sh](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/watchlog.sh), который будет искать необходимое слово в логе;
* Созданы юниты для [сервиса](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/watchlog.service) и [таймера](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/watchlog.timer) в папке __/usr/lib/systemd/system/__;
* Запустим сервис __wachlog.timer__ и убедимся в том, что сервис запущен, а также в логах __/var/log/messages__ скидываются результаты по работе сервиса каждые 30 секунд;
```console
```
____

#### 2. Из epel установить spawn-fcgi и переписать init-скрипт на unit-файл. Имя сервиса должно называться также.
* Установлен __spawn-fcgi__ и необходимые для него пакеты;
* Расскоментируем строки в файле [/etc/sysconfig/spawn-fcgi](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/spawn-fcgi);
* Создадим init файл в [/etc/systemd/system/spawn-fcgi.service](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/spawn-fcgi.service);
* Убедимся, что сервис успешно работает:
```console
● spawn-fcgi.service - Spawn-fcgi startup service by Otus
   Loaded: loaded (/etc/systemd/system/spawn-fcgi.service; disabled; vendor pre>
   Active: active (running) since Mon 2022-09-12 10:19:45 UTC; 1h 55min ago
 Main PID: 3157 (php-cgi)
    Tasks: 33 (limit: 5952)
   Memory: 18.8M
   CGroup: /system.slice/spawn-fcgi.service
           ├─3157 /usr/bin/php-cgi
           ├─3158 /usr/bin/php-cgi
           ├─3159 /usr/bin/php-cgi
           ├─3160 /usr/bin/php-cgi
           ├─3161 /usr/bin/php-cgi
           ├─3162 /usr/bin/php-cgi
           ├─3163 /usr/bin/php-cgi
           ├─3164 /usr/bin/php-cgi
           ├─3165 /usr/bin/php-cgi
           ├─3166 /usr/bin/php-cgi
           ├─3167 /usr/bin/php-cgi
           ├─3168 /usr/bin/php-cgi
           ├─3169 /usr/bin/php-cgi
           ├─3170 /usr/bin/php-cgi
           ├─3171 /usr/bin/php-cgi
           ├─3172 /usr/bin/php-cgi

```
____

#### 3. Дополнить юнит-файл apache httpd возможностью запустить несколько инстансов сервера с разными конфигами.
* Внесем правки в инит файл[/usr/lib/systemd/system/httpd.service](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/httpd.service);
* В файлах окружения [httpd-first](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/httpd-first), [httpd-second](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/httpd-second) задаем опции для запуска веб-сервера необходимыми конфигурационными файлами;
* В директории с конфигурационными файлами httpd создаем два конфигурационных файла [first.conf](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/first.conf), [second.conf](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/second.conf) с необходимыми изменениями для успешного запуска двух процессов;
* Запустил процессы и убедился, что каждый экземпляр слушает свой порт (80 и 8080 соответственно):
```console
[root@otus-home-work /]# systemctl start httpd@first
[root@otus-home-work /]# systemctl start httpd@second
● httpd@first.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd@.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2022-09-12 10:55:07 UTC; 2h 6min ago
     Docs: man:httpd@.service(8)
  Process: 3702 ExecStartPre=/bin/chown root.apache /run/httpd/instance-first (code=exited, status=0/SUCCESS)
  Process: 3701 ExecStartPre=/bin/mkdir -m 710 -p /run/httpd/instance-first (code=exited, status=0/SUCCESS)
 Main PID: 3704 (httpd)
   Status: "Running, listening on: port 80"
    Tasks: 214 (limit: 5952)
   Memory: 27.5M
   CGroup: /system.slice/system-httpd.slice/httpd@first.service
           ├─3704 /usr/sbin/httpd -DFOREGROUND -f conf/first.conf
           ├─3706 /usr/sbin/httpd -DFOREGROUND -f conf/first.conf
           ├─3707 /usr/sbin/httpd -DFOREGROUND -f conf/first.conf
           ├─3708 /usr/sbin/httpd -DFOREGROUND -f conf/first.conf
           ├─3709 /usr/sbin/httpd -DFOREGROUND -f conf/first.conf
           └─3710 /usr/sbin/httpd -DFOREGROUND -f conf/first.conf

Sep 12 10:55:07 otus-home-work systemd[1]: Starting The Apache HTTP Server...
Sep 12 10:55:07 otus-home-work httpd[3704]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this>
Sep 12 10:55:07 otus-home-work systemd[1]: Started The Apache HTTP Server.
Sep 12 10:55:07 otus-home-work httpd[3704]: Server configured, listening on: port 80
[root@otus-home-work /]#
[root@otus-home-work /]# systemctl status httpd@second
● httpd@second.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd@.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2022-09-12 10:55:01 UTC; 2h 7min ago
     Docs: man:httpd@.service(8)
  Process: 3479 ExecStartPre=/bin/chown root.apache /run/httpd/instance-second (code=exited, status=0/SUCCESS)
  Process: 3478 ExecStartPre=/bin/mkdir -m 710 -p /run/httpd/instance-second (code=exited, status=0/SUCCESS)
 Main PID: 3481 (httpd)
   Status: "Running, listening on: port 8080"
    Tasks: 214 (limit: 5952)
   Memory: 28.2M
   CGroup: /system.slice/system-httpd.slice/httpd@second.service
           ├─3481 /usr/sbin/httpd -DFOREGROUND -f conf/second.conf
           ├─3483 /usr/sbin/httpd -DFOREGROUND -f conf/second.conf
           ├─3484 /usr/sbin/httpd -DFOREGROUND -f conf/second.conf
           ├─3485 /usr/sbin/httpd -DFOREGROUND -f conf/second.conf
           ├─3486 /usr/sbin/httpd -DFOREGROUND -f conf/second.conf
           └─3487 /usr/sbin/httpd -DFOREGROUND -f conf/second.conf

Sep 12 10:55:01 otus-home-work systemd[1]: Starting The Apache HTTP Server...
Sep 12 10:55:01 otus-home-work httpd[3481]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this>
Sep 12 10:55:01 otus-home-work systemd[1]: Started The Apache HTTP Server.
Sep 12 10:55:01 otus-home-work httpd[3481]: Server configured, listening on: port 8080
[root@otus-home-work /]#
[root@otus-home-work /]#
[root@otus-home-work /]#ss -tnulp | grep httpd
tcp   LISTEN 0      128                *:80              *:*    users:(("httpd",pid=3710,fd=4),("httpd",pid=3709,fd=4),("httpd",pid=3708,fd=4),("httpd",pid=3707,fd=4),("httpd",pid=3704,fd=4))
tcp   LISTEN 0      128                *:8080            *:*    users:(("httpd",pid=3487,fd=4),("httpd",pid=3486,fd=4),("httpd",pid=3485,fd=4),("httpd",pid=3484,fd=4),("httpd",pid=3481,fd=4))
[root@otus-home-work /]# 
[root@otus-home-work /]#
```
____
