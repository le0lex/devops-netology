5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера

Задача 1
Сценарий выполения задачи:  

создайте свой репозиторий на https://hub.docker.com;  
выберете любой образ, который содержит веб-сервер Nginx;  
создайте свой fork образа;  
реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:  
<html>  
<head>  
Hey, Netology  
</head>  
<body>  
<h1>I’m DevOps Engineer!</h1>  
</body>  
</html>  
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.  
  
Ответ:  
    
root@leolex-VirtualBox:/home/leolex/www# docker login -u leolex  
Password:   
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.  
Configure a credential helper to remove this warning. See  
https://docs.docker.com/engine/reference/commandline/login/#credentials-store  
  
Login Succeeded  
  
root@leolex-VirtualBox:/# docker run --name docker-nginx -d -p 81:80  nginx  
3c32e4e1e8f5085145fdc7d49bde729b368590ee7afc51181e3c81530ad1978e  
  
root@leolex-VirtualBox:/# docker ps  
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                               NAMES  
3c32e4e1e8f5   nginx     "/docker-entrypoint.…"   7 seconds ago   Up 6 seconds   0.0.0.0:81->80/tcp, :::81->80/tcp   docker-nginx  
  
root@leolex-VirtualBox:/# docker exec -it docker-nginx bash  
root@3c32e4e1e8f5:/# cd /usr/share/nginx  
root@3c32e4e1e8f5:/usr/share/nginx# ls -la  
total 12  
drwxr-xr-x 3 root root 4096 Jun 23 04:13 .  
drwxr-xr-x 1 root root 4096 Jun 23 04:13 ..  
drwxr-xr-x 2 root root 4096 Jun 23 04:13 html  
root@3c32e4e1e8f5:/usr/share/nginx# cd html  
root@3c32e4e1e8f5:/usr/share/nginx/html# ls -la  
total 16  
drwxr-xr-x 2 root root 4096 Jun 23 04:13 .  
drwxr-xr-x 3 root root 4096 Jun 23 04:13 ..  
-rw-r--r-- 1 root root  497 Jun 21 14:25 50x.html  
-rw-r--r-- 1 root root  615 Jun 21 14:25 index.html  
root@3c32e4e1e8f5:/usr/share/nginx/html# exit  
exit  
  
root@leolex-VirtualBox:/# cd /home/leolex/www  
root@leolex-VirtualBox:/home/leolex/www# ls -la  
total 12  
drwxr-xr-x  2 root   root   4096 июл  5 17:27 .  
drwxr-xr-x 27 leolex leolex 4096 июл  5 17:26 ..  
-rw-r--r--  1 root   root     91 июл  5 17:27 index.html  
  
root@leolex-VirtualBox:/home/leolex/www# docker cp index.html docker-nginx:/usr/share/nginx/html  
  
root@leolex-VirtualBox:/home/leolex/www# docker exec -it docker-nginx bash  
root@3c32e4e1e8f5:/# cd usr/share/nginx/html  
root@3c32e4e1e8f5:/usr/share/nginx/html# ls  
50x.html  index.html  
root@3c32e4e1e8f5:/usr/share/nginx/html# cat index.html  
<html>  
<head>  
Hey, Netology  
</head>  
<body>  
<h1>I’m DevOps Engineer!</h1>  
</body>  
</html>  
  
root@3c32e4e1e8f5:/usr/share/nginx/html# exit  
exit  
  
root@leolex-VirtualBox:/home/leolex/www# docker ps  
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                               NAMES  
3c32e4e1e8f5   nginx     "/docker-entrypoint.…"   7 minutes ago   Up 7 minutes   0.0.0.0:81->80/tcp, :::81->80/tcp   docker-nginx  
  
root@leolex-VirtualBox:/home/leolex/www#  docker commit -m "modifyed index.html" -a leolex 3c32e4e1e8f5 leolex/nginx:v1  
sha256:a77dffe3cd6ff1644e67a337d67d431885db6fe8ba02727b00961133b480b44d  
  
root@leolex-VirtualBox:/home/leolex/www# docker image list  
REPOSITORY     TAG       IMAGE ID       CREATED          SIZE  
leolex/nginx   v1        a77dffe3cd6f   12 seconds ago   142MB  
nginx          latest    55f4b40fe486   12 days ago      142MB  
  
root@leolex-VirtualBox:/home/leolex/www# docker push leolex/nginx:v1  
The push refers to repository [docker.io/leolex/nginx]  
c1c95133598c: Pushed   
e7344f8a29a3: Mounted from library/nginx   
44193d3f4ea2: Mounted from library/nginx   
41451f050aa8: Mounted from library/nginx   
b2f82de68e0d: Mounted from library/nginx   
d5b40e80384b: Mounted from library/nginx   
08249ce7456a: Mounted from library/nginx   
v1: digest: sha256:78f354c4a78a465c481c5ae17c8e473caff68d0cd35b3e8832d32dd164f4c57b size: 1778  
root@leolex-VirtualBox:/home/leolex/www#   
  
root@leolex-VirtualBox:/home/leolex/www# docker stop docker-nginx  
docker-nginx  
root@leolex-VirtualBox:/home/leolex/www# docker rm docker-nginx  
docker-nginx  
  
root@leolex-VirtualBox:/home/leolex/www# docker image list  
REPOSITORY     TAG       IMAGE ID       CREATED          SIZE  
leolex/nginx   v1        a77dffe3cd6f   13 minutes ago   142MB  
nginx          latest    55f4b40fe486   12 days ago      142MB  
root@leolex-VirtualBox:/home/leolex/www# docker rmi a77dffe3cd6f  
Untagged: leolex/nginx:v1  
Untagged: leolex/nginx@sha256:78f354c4a78a465c481c5ae17c8e473caff68d0cd35b3e8832d32dd164f4c57b  
Deleted: sha256:a77dffe3cd6ff1644e67a337d67d431885db6fe8ba02727b00961133b480b44d  
Deleted: sha256:10ca78320030b059b18653f870d07b20b7f95a1196e885b09b225ab6344523db  
root@leolex-VirtualBox:/home/leolex/www# docker image list  
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE  
nginx        latest    55f4b40fe486   12 days ago   142MB  
root@leolex-VirtualBox:/home/leolex/www# docker rmi 55f4b40fe486  
Untagged: nginx:latest  
Untagged: nginx@sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea  
Deleted: sha256:55f4b40fe486a5b734b46bb7bf28f52fa31426bf23be068c8e7b19e58d9b8deb  
Deleted: sha256:5f58fed9b4d8e6c09cdc42eed6de6df7a7e35b40d92c98f30f8ecad4960fb7a0  
Deleted: sha256:8bb72c1d014292ebf1ae348a77624c536e766757356c6dbb0de75122a94b445d  
Deleted: sha256:cc9ac0adbded956d924bcf6c26ffbc93ea070019be1437d204b530a033ff4b16  
Deleted: sha256:30f210588f35917f0edb5a2465db7ad60e4ef3b6ac74fe155474e14e6f0995c5  
Deleted: sha256:5ecd5431cf49a2a11115844de1e7b23b9535be8789add9ab50973867db5f7d36  
Deleted: sha256:08249ce7456a1c0613eafe868aed936a284ed9f1d6144f7d2d08c514974a2af9  
  
root@leolex-VirtualBox:/home/leolex/www# docker image list  
REPOSITORY     TAG       IMAGE ID       CREATED          SIZE  
leolex/nginx   v1        a77dffe3cd6f   18 minutes ago   142MB  
  
root@leolex-VirtualBox:/home/leolex/www# docker run --name docker-nginx -d -p 81:80  leolex/nginx:v1  
d1d254ff6e64994506f71fab51e3dc94bdb7b61c1312997dddd5bc6dabf72add  
  
https://hub.docker.com/r/leolex/nginx  
  
![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW5.3_Task1.png)  
  
  
  
Задача 2  
Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"  

Детально опишите и обоснуйте свой выбор.  
  
--  

Сценарий:  
  
Высоконагруженное монолитное java веб-приложение;  
Nodejs веб-приложение;  
Мобильное приложение c версиями для Android и iOS;  
Шина данных на базе Apache Kafka;  
Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;  
Мониторинг-стек на базе Prometheus и Grafana;  
MongoDB, как основное хранилище данных для java-приложения;  
Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.  
  
  
Высоконагруженное монолитное java веб-приложение;  
Физический сервер, так как монолитное приложение не предполагает изменение кода, все компоненты находятся в одном месте, требуется максимальная утилизация аппаратных ресурсов.  
  
Nodejs веб-приложение;  
Лучше всего подойдёт использование Docker контейнеров, так как node.js является компонентом (сервисом), работающим с javascript, поэтому данный модуль можно легко разместить в контейнере, он отлично вписывается в концепцию микросервисной архитектуры.  
  
Мобильное приложение c версиями для Android и iOS;  
Виртуальные машины, так как разные ОС, а также данные приложения предполагают свои для каждого случая интерфейсы в сторону пользователя.  
  
Шина данных на базе Apache Kafka;  
Docker Контейнеры. Шина данных предполагает использование микросервисной архитектуры. Кроме того Apache Kafka, на сколько я понимаю, это сервис, поэтому лучше всего запускать данный сервис в контейнере. Исключением может быть случай связанный с высокой важностью передаваемых данных. В этом случае нужно позаботиться о резервировании или ипользовать ВМ.   
  
Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;  
Docker контейнер. На Docker hub уже есть готовые образы, с помощью которых можно запустить три разных контейнера. Их можно соединить в кластер, при необхдимости. Если речь идет о тестовой среде, то однозначно удобнее использовать контейнеры. Если о продакшн, то компоненты, в особенности elasticsearch, можно поднять на виртуалках, чтобы повысить отказоустойчивость.  
  
Мониторинг-стек на базе prometheus и grafana;  
Docker контейнер. Так как данные приложения не хранят данные, то лучше использовать контейнеры. Использование контейнеров такжже дает преимущество с точки зрения модификации системы мониторинга.  
  
MongoDB, как основное хранилище данных для java-приложения;  
Для хранения данных БД лучше подходит виртуальная машина. К тому же не указано, что система высоконагруженная, поэтому оптимальны вариантом будет ВМ.  
  
Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.  
ВМ или физический сервер, так как требуется хранение данных. С точки зрения масштабирования лучше будет использовать ВМ.   
  
  
  
Задача 3  
Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку "/data" из текущей рабочей директории на хостовой машине в "/data: контейнера;
Запустите второй контейнер из образа debian в фоновом режиме, подключив папку "/data" из текущей рабочей директории на хостовой машине в "/data" контейнера;
Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в "/data";
Добавьте еще один файл в папку "/data" на хостовой машине;
Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.

Запускаем контейнер centos с именем docker-centos в фоне и пробрасываем сразу tty, а также подключаем папку "/data"  
  
root@leolex-VirtualBox:/home/leolex/www/data# docker run --name docker-centos -d -t  -v /data:/data centos  
9fefb93152055fd92916debb166192270c154820d5bb634ab97511dab8cf2059  
root@leolex-VirtualBox:/home/leolex/www/data# docker ps  
CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS                               NAMES  
9fefb9315205   centos            "/bin/bash"              5 seconds ago   Up 5 seconds                                       docker-centos  

Запускаем контейнер debian с именем docker-debian в фоне и пробрасываем сразу tty, а также подключаем папку /data  
root@leolex-VirtualBox:/home/leolex/www/data# docker run --name docker-debian -d -t  -v /data:/data debian  
Unable to find image 'debian:latest' locally  
latest: Pulling from library/debian  
1339eaac5b67: Pull complete  
Digest: sha256:859ea45db307402ee024b153c7a63ad4888eb4751921abbef68679fc73c4c739  
Status: Downloaded newer image for debian:latest  
2ddc9a826f1c0a306b6e9530a6a60c40e6d5df16ccf955f134ccb5f1aff551b  
root@leolex-VirtualBox:/home/leolex/www/data# docker ps  
CONTAINER ID   IMAGE             COMMAND                  CREATED              STATUS              PORTS                               NAMES  
e2ddc9a826f1   debian            "bash"                   5 seconds ago        Up 4 seconds                                            docker-debian  
9fefb9315205   centos            "/bin/bash"              About a minute ago   Up About a minute                                       docker-centos  
  
Заходим в контейнер centos и создаем файл  
root@leolex-VirtualBox:/home/leolex/www/data# docker exec -ti 9fefb9315205 bash  
[root@9fefb9315205 /]# cd data  
[root@9fefb9315205 data]# touch centos_file  
[root@9fefb9315205 data]# echo 'test'  > /data/centos_file  
[root@9fefb9315205 data]# cat centos_file  
test  
[root@9fefb9315205 data]# exit  
exit  
  
Создаём файл на хостовой машине  
root@leolex-VirtualBox:/home/leolex/www/data# cd /data  
root@leolex-VirtualBox:/data# touch host_file  
root@leolex-VirtualBox:/data# echo test_host > /data/host_file  
  
Проверяем файл на контейнере debian   
root@leolex-VirtualBox:/data# docker exec -ti e2ddc9a826f1 bash  
root@e2ddc9a826f1:/# cd /data  
root@e2ddc9a826f1:/data# ls -la  
total 16  
drwxr-xr-x 2 root root 4096 Jul  6 12:37 .  
drwxr-xr-x 1 root root 4096 Jul  6 12:33 ..  
-rw-r--r-- 1 root root    5 Jul  6 12:37 centos_file  
-rw-r--r-- 1 root root   10 Jul  6 12:38 host_file  
root@e2ddc9a826f1:/data# cat centos_file   
test  
root@e2ddc9a826f1:/data# cat host_file   
test_host  
root@e2ddc9a826f1:/data#   
  
  
  
  
Задача 4 (*)
Воспроизвести практическую часть лекции самостоятельно.
Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

root@leolex-VirtualBox:/home/leolex/www/data# docker build -t leolex/ansible:1.0.0 .
Sending build context to Docker daemon  4.096kB
Step 1/5 : FROM alpine:3.14
3.14: Pulling from library/alpine
8663204ce13b: Pull complete 
Digest: sha256:06b5d462c92fc39303e6363c65e074559f8d6b1363250027ed5053557e3398c5
Status: Downloaded newer image for alpine:3.14
 ---> e04c818066af
..................

root@leolex-VirtualBox:/home/leolex/www/data# docker image list
REPOSITORY       TAG       IMAGE ID       CREATED              SIZE
leolex/ansible   1.0.0     9ef80d6b84a1   About a minute ago   380MB
leolex/nginx     v1        a77dffe3cd6f   22 hours ago         142MB
nginx            latest    55f4b40fe486   13 days ago          142MB
debian           latest    d2780094a226   13 days ago          124MB
alpine           3.14      e04c818066af   3 months ago         5.59MB
centos           latest    5d0da3dc9764   9 months ago         231MB
root@leolex-VirtualBox:/home/leolex/www/data# docker push leolex/ansible:1.0.0
The push refers to repository [docker.io/leolex/ansible]
24b5fb0278c2: Pushed 
b8d957d45378: Pushed 
b541d28bf3b4: Mounted from library/alpine 
1.0.0: digest: sha256:1aaaeaf59f8239358b2c2c1d98ed96b3d4009eb99afffbf8398fadccd4e39308 size: 947

http://hub.docker.com/r/leolex/ansible






***************************************************************************************************************************************************************************************************************************

5.2. Применение принципов IaaC в работе с виртуальными машинами

Задача 1

Опишите своими словами основные преимущества применения на практике IaaC паттернов.
Какой из принципов IaaC является основополагающим?

Преимуществом применения IaaC являтся автоматизация процесов разработки и развертывания, что приводит к значительному сокращению времени выхода приложения в коммерческое использование. IaaC подход обьясняет как правильно писать код, структурировать, документировать и т.д. В следствие чего IaaC помогает существенно сократить количество ошибок в конфигурации и проблем связанными с использованием различных сред для разработки, тестирования и развертывания. Самое главное преимущество применения IaaC это идемпотентность, то есть стабильное качество и результат работы кода раз за разом. Обеспечение идемпотентности является ключевым принципом IaaC.


Задача 2

Чем Ansible выгодно отличается от других систем управление конфигурациями?
Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

Ansible не требует установки клиента на целевую инфраструктуру все функции производятся по SSH. Также он прост в использовании по сравнению с другими системами управления конфигурациями. Легко расширяется за счет модулей. Написан на python. Для простых задач ansible может быть заущен из командной строки. 
Push, на мой взгляд, является более надёжным потому что в этом случае администратор контролирует сам многие процессы, такие как установка необходимых ресурсов на управляемый сервер  и на ПК, откуда передаются конфигурации. В режиме pull действия автоматизированы в большей степени и инициируются сервером, что может привести к непредскажуемым результатам и ошибкам. Также режим push не требует установки агентов, что также упрощает работу и повышает надежность.


Задача 3
Установить на личный компьютер:

VirtualBox
Vagrant
Ansible
Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.

leolex@leolex-VirtualBox:~$ vboxmanage --version
6.1.32_Ubuntur149290

leolex@leolex-VirtualBox:~$ vagrant --version
Vagrant 2.2.6

leolex@leolex-VirtualBox:~$ ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/leolex/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Mar 15 2022, 12:22:08) [GCC 9.4.0]


Задача 4 (*)
Воспроизвести практическую часть лекции самостоятельно.

Создать виртуальную машину.
Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
docker ps

leolex@leolex-VirtualBox:~/.vagrant.d$ vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202206.03.0' is up to date...
==> server1.netology: Setting the name of the VM: server1.netology
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key

Зависает на данном шаге. 

Timed out while waiting for the machine to boot. This means that
Vagrant was unable to communicate with the guest machine within
the configured ("config.vm.boot_timeout" value) time period.

If you look above, you should be able to see the error(s) that
Vagrant had when attempting to connect to the machine. These errors
are usually good hints as to what may be wrong.

If you're using a custom box, make sure that networking is properly
working and you're able to connect to the machine. It is a common
problem that networking isn't setup properly in these boxes.
Verify that authentication configurations are also setup properly,
as well.

If the box appears to be booting properly, you may want to increase
the timeout ("config.vm.boot_timeout") value.

Задача со звездочкой не получилась, по причине приведенной выше ошибки. Пытался гуглить в интернете, но решение не нашел.


*****************************************************************************************************

5.1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения.

Задача 1
Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

Ответ:

Паравиртуализация - ядро гостевой ОС модифицируется для работы с гипервизором. Гостевой ОС известно, что она гостевая система и есть хостовая ОС, куда передаются соответствующие команды. То есть Каждой виртуальной машине выделяется ровно столько ресурсов, сколько определено гипервизором, который является неким посредником между аппаратной частью и гостевой ОС.

Аппаратная виртуализация - гипервизор сам является по сути операционной системой, то есть дополнительно хостовая ОС не требуется. Это полная виртуализация. Гостевая ОС передает напрямую аппаратной части инструкции, которые должны поддерживаться этой аппаратной чстью. 

Виртуализация на основе ОС - гостевая ОС не знает, что она находится в виртуальной среде. Аппаратное обеспечение виртуализируется хостовой ОС, то есть аппаратное обеспечение имитируется. Такой тип виртуализации использует контейнеры. Их суть в том, что несклько контейнеров используют ресурсы одной и той же хостовой ОС, при этом ресурсы изолированы для каждого контейнера.



Задача 2
Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:

физические сервера,
паравиртуализация,
виртуализация уровня ОС.
Условия использования:

Высоконагруженная база данных, чувствительная к отказу.
Различные web-приложения.
Windows системы для использования бухгалтерским отделом.
Системы, выполняющие высокопроизводительные расчеты на GPU.
Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

Ответ:
физические сервера - Системы, выполняющие высокопроизводительные расчеты на GPU, высоконагруженная база данных, чувствительная к отказу. Так как у приложений есть прямой доступ к аппаратным ресурсам, на виртуализацию ресурсы не тратятся. Кроме того отсутствуют дополительные точки отказа в виде гипервизора. Более отказоустойчивым решением тут будет использование полной аппаратной виртуализации и объединение серверов в кластер.

паравиртуализация - Windows системы для использования бухгалтерским отделом. Если используется гипервизор от Microsoft, то особенно актуально. В данном случае присутствует гибкость с точки зрения масштабирования, ресурсы для каждой VM определяются заранее, удобно администрировать парк виртуальных машин, которые изолированы друг от друга.  

виртуализация уровня ОС. - Различные web-приложения. Контейнеры дают гибкость при масштабировании и высокий уровень отказоустойчивости. Предполагается, что web приложения требуют меньше ресурсов, чем, например, высокопроизводительные рассчеты на GPU. Также использование контейнеров удобнее с точки зрения администрирования.



Задача 3
Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
Для такого сценария, на мой взгляд, лучше всего подходит решение от VmWare vSphere, так как данное решение обладает богатым функционалом с точки зрения резервирования и балансировки нагрузки. 

Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
KVM - open source решение, поддерживает и Linux и Windows, хорошая производительность.

Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.
Hyper-V - является бесплатным гипервизором от Microsoft, также встроен в некоторые ОС от Microsoft, поэтому для сценария с использованием Windows машин подходит лучше всего.

Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.
Xen - поддерживает разные дистрибутивы linux. Позволяет создавать шаблоны и быстро запускать виртуальные машины linux. Xen обладает хорошей стабильностью и производительностью.

Задача 4
Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

Гетерогенная среда виртуализации предполагает повышенные требования к компетенции инженеров, более сложное обслуживание, проблемы с автоматизацией, риски связанные с совместимостью и, поскольку отсутствует общий стандарт, низкая эффективность. Гетерогенная среда виртуализации должна использоваться в исключительнах случаях, например, когда есть привязка к определенному вендору для определенного сервиса. Также минусом гетерогенной виртуализации является более дорогая техническая поддержка.

Минимизацией рисков при ипользовании гетерогенной среды виртуализации является грамотное планирование и проектирование. Необходимо понимать в какую сторону раззвивается инфраструктура, чтобы не загнать себя в угол и оказаться в сложной ситуации из-за несовместимости продуктов или сервисов. Правильнее, на мой взгляд, как минимум разделять среды виртуализации  и сервисы на низх по какому-либо принципу, чтобы они не интегрировались между собой в значительной степени.

Плюс гетерогенной среды виртуализации может быть в отвязке от какого-то одного вендора, а также в увеличении производительности для определенных сервисов оптимизированных под определенную среду виртуализации. Например, VmWare может не поддерживать некоторые виды аппаратного обеспечения, поэтому вместе с VmWare можно использовать альтернативную среду виртуализации. Другой пример, когда есть парк VM под Windows и под Lunux, то можно использовать hyper-v для Windows систем, а для linux Xen или KVM, если это дает ощутимый прирост производительности и функцональности и упрощает администрирование.

Я бы не стал использовать гетерогенную среду виртуализации без особой необходимости.




