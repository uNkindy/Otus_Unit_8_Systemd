### Домашнее задание №8 (Systemd)
#### Предварительный тюнинг:
* Создан Vagrantfile на основе __almalinux/8__;
* Прописан запуск скриптов в целях автоматизации выполнения домашнего задания;
#### 1. Написать сервис, которýй будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова. Файл и слово должен задаваться в /etc/sysconfig.
* Создал файл с конфигурацией для сервиса в директории [/etc/sysconfig/watchlog](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/watchlog);
* Создал лог файл [/var/log/watchlog.log](https://github.com/uNkindy/Otus_Unit_8_Systemd/blob/main/watchlog.log). Слово, корое будет искать сервис: "ALERT";
*
