# Домашнее задание к занятию "Kubernetes. Причины появления. Команда kubectl"

### Цель задания

Для экспериментов и валидации ваших решений вам нужно подготовить тестовую среду для работы с Kubernetes. Оптимальное решение — развернуть на рабочей машине или на отдельной виртуальной машине MicroK8S.

------

### Чеклист готовности к домашнему заданию

1. Личный компьютер с ОС Linux или MacOS 

или

2. ВМ c ОС Linux в облаке либо ВМ на локальной машине для установки MicroK8S  

------

### Инструкция к заданию

1. Установка MicroK8S:
    - sudo apt update
    - sudo apt install snapd
    - sudo snap install microk8s --classic
    - добавить локального пользователя в группу `sudo usermod -a -G microk8s $USER`
    - изменить права на папку с конфигурацией `sudo chown -f -R $USER ~/.kube`

2. Полезные команды:
    - проверить статус `microk8s status --wait-ready`
    - подключиться к microK8s и получить информацию можно через команду `microk8s command`, например, `microk8s kubectl get nodes`
    - включить addon можно через команду `microk8s enable` 
    - список addon'ов `microk8s status`
    - вывод конфигурации `microk8s config`
    - проброс порта для подключения локально `microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443`

3. Настройка внешнего подключения:
    - Отредактировать файл /var/snap/microk8s/current/certs/csr.conf.template
    ```shell
    # [ alt_names ]
    # Add
    # IP.4 = 123.45.67.89
    ```
    - Обновить сертификаты `sudo microk8s refresh-certs --cert front-proxy-client.crt`

4. Установка kubectl:
    - curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
    - chmod +x ./kubectl
    - sudo mv ./kubectl /usr/local/bin/kubectl 
    - настройка автодополнения в текущую сессию `bash source <(kubectl completion bash)`
    - добавление автодополнения в командную оболочку bash `echo "source <(kubectl completion bash)" >> ~/.bashrc`

------

### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://microk8s.io/docs/getting-started) по установке MicroK8S
2. [Инструкция](https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/#bash) по установке автодополнения **kubectl**
3. [Шпаргалка](https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/) по **kubectl**

------

### Задание 1. Установка MicroK8S

1. Установить MicroK8S на локальную машину или на удаленную виртуальную машину
2. Установить dashboard
3. Сгенерировать сертификат для подключения к внешнему ip-адресу

------

### Задание 2. Установка и настройка локального kubectl
1. Установить на локальную машину kubectl
2. Настроить локально подключение к кластеру
3. Подключиться к дашборду с помощью port-forward

------

### Правила приема работы

1. Домашняя работа оформляется в Github в своем репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода команд `kubectl get nodes`, а также скриншот дашборда

------

### Ответ

Установлен MicroK8S и dashboard на локальную машину.  
![HW_12.1_t1.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_12.1_t1.1.png)
![HW_12.1_t1.2.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_12.1_t1.2.1.png)
  
Сгенерирован сертификат для подключения к внешнему ip-адресу  
![HW_12.1_t1.3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_12.1_t1.3.png)
  
Установлен на локальную машину kubectl 
![HW_12.1_t2.1.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_12.1_t2.1.1.png) 
![HW_12.1_t2.1.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_12.1_t2.1.2.png) 
  
Настроено локально подключение к кластеру  
![HW_12.1_t2.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_12.1_t2.2.png)

Подключиться к дашборду с помощью port-forward  
![HW_12.1_t2.3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_12.1_t2.3.png)
![HW_12.1_t1.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_12.1_t1.2.png)

Такжы в процессе установки и настройки была созадана директория ~/.kube и файл config при помощи команды 
```
microk8s config > config
```

Сам config  
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUREekNDQWZlZ0F3SUJBZ0lVTk1tMjc4ZWN2RzRtSUhqWW01eEQyVnlodWdzd0RRWUpLb1pJaHZjTkFRRUwKQlFBd0Z6RVZNQk1HQTFVRUF3d01NVEF1TVRVeUxqRTRNeTR4TUI0WERUSXpNREV4TWpFMk1UUTFNbG9YRFRNegpNREV3T1RFMk1UUTFNbG93RnpFVk1CTUdBMVVFQXd3TU1UQXVNVFV5TGpFNE15NHhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUF0U2xJT080WmdkOU92eFR0UUFGcHFDV1JBSE5vMXRUWFRpTkcKUUxFZFA3Z2kxUDhWcmNxb1pGMktRcFY4M29ZU2ZVU1hGYXNQT0tXVmlBNkhoZ1JBRlAycUR0SGdVUm5wclhIbwpCbHhkVjdTbDJ2MkxMYnNKdGhhOWlnY0FKMEM1WlpyUWJNaUMveWFNa1VjTFoyZ2lhTWtDQmZ5bkxMNi90U3N5ClpTL3ZoNmtyMEpnTFkvbUF2S0Y0ZXZ2MjBZWGpXZjdTaGZlaWhNMy9MeHVVbXB0K2NDZ3IxQW55RHduZUJMYkkKMGpXa1ZHVmhUUkF1ZE9CdlE0czNiU1RRS2NPWTRRYzBGNEI4anlHUlkyck9XdkxLQ2R3a25UOE1VS1BWNWJRegpCb29SZFJERDhmV2pQMHI3S2hjWXhNSXJ5V21pMUJVMUpUbXR3K3o1Ty9QbFJMQlBkUUlEQVFBQm8xTXdVVEFkCkJnTlZIUTRFRmdRVUtZMUZDQjh1bHJGZURZN0ZNekpFQzlicGV1SXdId1lEVlIwakJCZ3dGb0FVS1kxRkNCOHUKbHJGZURZN0ZNekpFQzlicGV1SXdEd1lEVlIwVEFRSC9CQVV3QXdFQi96QU5CZ2txaGtpRzl3MEJBUXNGQUFPQwpBUUVBQ1VhQi9ta2JheFFsMEJ1RVp3RkFsdnp5S0JXYy9vbzNDU3UwUE53MGY2MXA1UER1WlNCZ1NOWFQ4QmY0Cjh2T2N1ZTl6dVJ0aXFERmFUOG9acm1IWEdvRG1nazV3RGdubnpuQ0xtaFE0a1NqMm54T1ZMdUJhMVBhdVZwVEoKSEhHVHV0OVVkLzJabHNxNHh6cUJjclBHdGdYSkF0cWk5UHVUMkFlMXBIQVh5NGRzb1VmM1ZCWEFZbFk2bVZVMwo0NnJ4Q3lsWWVOVzNmNkFMWm5takowcjRqWG12MW85TnYwWEFVMWsxcmFGZWgyS3VOREhHcmJ4eHFsYkNGQVRVCmpjK0hFZGU1T3JlTjBJcGNYRkkrSDMxaXk0NkZVN3hYc0kwNyt6MFViN2t1ZEJCT2N0cWpKVmpCQzlQRW1GeG4Ka3JyY3A0SUE5dW1xOExIYmJBM3VocUlyNGc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://10.0.2.15:16443
  name: microk8s-cluster
contexts:
- context:
    cluster: microk8s-cluster
    user: admin
  name: microk8s
current-context: microk8s
kind: Config
preferences: {}
users:
- name: admin
  user:
    token: YUlpa2ZkSThYZkt0Q3dWQWc4emw5V2RyeDdHNEN0cE1KYWc1Z0YyZGR5bz0K
```
  

 

