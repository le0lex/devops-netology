# Домашнее задание к занятию "Хранение в K8s. Часть 1"

### Цель задания

В тестовой среде Kubernetes необходимо обеспечить обмен файлами между контейнерам пода и доступ к логам ноды.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S)
2. Установленный локальный kubectl
3. Редактор YAML-файлов с подключенным github-репозиторием

------

### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://microk8s.io/docs/getting-started) по установке MicroK8S
2. [Описание](https://kubernetes.io/docs/concepts/storage/volumes/) Volumes
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool

------

### Задание 1. Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Сделать так, чтобы busybox писал каждые 5 секунд в некий файл в общей директории.
3. Обеспечить возможность чтения файла контейнером multitool.
4. Продемонстрировать, что multitool может читать файл, который периодоически обновляется.
5. Предоставить манифесты Deployment'а в решении, а также скриншоты или вывод команды п.4
  
#### Ответ:  
Создан Deployment приложения:   
  
![hw13.1_1.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.1_1.png)
  
[Манифест](https://github.com/le0lex/devops-netology/blob/873fc175c7865ee3d79f5cdaa787edfb1a240d59/HW_13.1/hw13.1_1.yaml) 

Multitool читает из файла:   
  
![hw13.1_2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.1_2.png)

Busybox пишет в файл output.log: 
  
![hw13.1_3.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.1_3.png)
  
------

### Задание 2. Создать DaemonSet приложения, которое может прочитать логи ноды

1. Создать DaemonSet приложения состоящего из multitool.
2. Обеспечить возможность чтения файла `/var/log/syslog` кластера microK8S.
3. Продемонстрировать возможность чтения файла изнутри пода.
4. Предоставить манифесты Deployment, а также скриншоты или вывод команды п.2
  
#### Ответ:  
  
Создан DaemonSet приложения состоящего из multitool:  
  
![hw13.1_4.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.1_4.png)
  
[Манифест](https://github.com/le0lex/devops-netology/blob/873fc175c7865ee3d79f5cdaa787edfb1a240d59/HW_13.1/hw13.2_1.yaml)  
  
возможность чтения файла `/var/log/syslog` кластера microK8S:  
  
![hw13.1_5.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.1_5.png)  
  

------
