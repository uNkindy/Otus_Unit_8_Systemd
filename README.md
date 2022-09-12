### Домашнее задание №8 (Systemd)
#### Предварительный тюнинг:
* Создан Vagrantfile на основе __almalinux/8__;
* Установлен nano для упро
* Прописан запуск скриптов в целях автоматизации выполнения домашнего задания;
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

#### 3. 
