# Домашнее задание к занятию "Запуск приложений в K8S"

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Deployment с приложением, состоящим из нескольких контейнеров и масштабировать его.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S)
2. Установленный локальный kubectl
3. Редактор YAML-файлов с подключенным git-репозиторием

------

### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов
2. [Описание](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) Init-контейнеров
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool

------

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod'а

1. Создать Deployment приложения состоящего из двух контейнеров - nginx и multitool. Решить возникшую ошибку
2. После запуска увеличить кол-во реплик работающего приложения до 2
3. Продемонстрировать кол-во подов до и после масштабирования
4. Создать Service, который обеспечит доступ до реплик приложений из п.1
5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl` что из пода есть доступ до приложений из п.1

------

#### Ответ:  
Создан Deployment, проблем не возникло.  
![hw12.3_1.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.3_1.1.png)

Увеличено количество реплик:  
![hw12.3_1.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.3_1.2.png)

[hw12.3_1](https://github.com/le0lex/devops-netology/blob/1069fb2000c8368defbed40bdb17a6f4547dac91/HW_12.3/hw12.3_1.yaml)  

Создан Service:  

![hw12.3_1.4.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.3_1.4.png)
![hw12.3_1.4.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.3_1.4.1.png)

Создан отдельный POD:  
[hw_12.3.1.5.yaml](https://github.com/le0lex/devops-netology/blob/1069fb2000c8368defbed40bdb17a6f4547dac91/HW_12.3/hw12.3_1.yaml)

![hw12.3_1.5.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.3_1.5.1.png)

![hw12.3_1.5.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.3_1.5.2.png)

------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения
2. Убедиться, что nginx не стартует. В качестве init-контейнера взять busybox
3. Создать и запустить Service. Убедиться, что nginx запустился
4. Продемонстрировать состояние пода до и после запуска сервиса

------

#### Ответ: 
Создан Deployment, nginx не стартует:  
![hw12.3_2.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.3_2.1.png)

[hw_12.3.2.yaml](https://github.com/le0lex/devops-netology/blob/1069fb2000c8368defbed40bdb17a6f4547dac91/HW_12.3/hw_12.3.2.yaml)

Создан и запущен Service, nginx стартовал:  
![hw12.3_2.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw12.3_2.2.png)

[hw_12.3.2.svc.yaml](https://github.com/le0lex/devops-netology/blob/1069fb2000c8368defbed40bdb17a6f4547dac91/HW_12.3/hw_12.3.2.svc.yaml)

-----
