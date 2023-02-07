# Домашнее задание к занятию "Сетевое взаимодействие в K8S. Часть 1"

### Цель задания

В тестовой среде Kubernetes необходимо обеспечить доступ к приложению, установленному в предыдущем ДЗ и состоящему из двух контейнеров, по разным портам в разные контейнеры как внутри кластера, так и снаружи.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S)
2. Установленный локальный kubectl
3. Редактор YAML-файлов с подключенным git-репозиторием

------

### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов
2. [Описание](https://kubernetes.io/docs/concepts/services-networking/service/) Описание Service
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool

------

### Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod'а внутри кластера

1. Создать Deployment приложения, состоящего из двух контейнеров - nginx и multitool с кол-вом реплик 3шт.
2. Создать Service, который обеспечит доступ внутри кластера до контейнеров приложения из п.1 по порту 9001 - nginx 80, по 9002 - multitool 8080.
3. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложения из п.1 по разным портам в разные контейнеры
4. Продемонстрировать доступ с помощью `curl` по доменному имени сервиса.
5. Предоставить манифесты Deployment'а и Service в решении, а также скриншоты или вывод команды п.4

------

#### Ответ:  

Создан Deployment и отдельный pod multitool.
[Манифест](https://github.com/le0lex/devops-netology/blob/8f2bfd7630ee7718a0902b918816898e98b074eb/HW_12.4/hw_12.4.1.1-2.yaml)

![hw12.4_1.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.4_1.1.png)

![hw12.4_1.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.4_1.2.png)

Доступ с помощью curl:

![hw12.4_1.3.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.4_1.3.png)
  
### Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера

1. Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx используя тип NodePort.
2. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
3. Предоставить манифест и Service в решении, а также скриншоты или вывод команды п.2.

------

#### Ответ: 

Создан отдельный service:  
[Манифест](https://github.com/le0lex/devops-netology/blob/60dfb450cb92b78961ee0e177507e7d119b73b9a/HW_12.4/hw_12.4.1.svc.yaml)

![hw12.4_2.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.4_2.1.png)

`curl` с локального компьютера: 
  
![hw12.4_2.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.4_2.2.png)
  
![hw12.4_2.3.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.4_2.3.png)

------
