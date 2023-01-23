# Домашнее задание к занятию "Базовые объекты K8S"

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Pod с приложением и подключиться к нему со своего локального компьютера. 

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S)
2. Установленный локальный kubectl
3. Редактор YAML-файлов с подключенным github-репозиторием

------

### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. Описание [Pod](https://kubernetes.io/docs/concepts/workloads/pods/) и примеры манифестов
2. Описание [Service](https://kubernetes.io/docs/concepts/services-networking/service/)

------

### Задание 1. Создать Pod с именем "hello-world"

1. Создать манифест (yaml-конфигурацию) Pod
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2
3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере)

------

### Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем "netology-web"
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2
3. Создать Service с именем "netology-svc" и подключить к "netology-web"
4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере)

------

### Правила приема работы

1. Домашняя работа оформляется в Github в своем репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода команд `kubectl get pods`, а также скриншот результата подключения
3. Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md

------

### Ответ:  
  
## Задание 1. Создать Pod с именем "hello-world"  

Созданы две VM
![hw_12.2.1.vm.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw_12.2.1.vm.png)
  
  
Манифест для hello-world:
```
apiVersion: v1
kind: Pod
metadata:
   name: hello-world
spec:
   containers:
     - name: hello-world
       image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
       ports:
       - containerPort: 8080
         name: echo
         protocol: TCP
```

Создан pod и проброшен порт:  
![hw_12.2.1.pf2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw_12.2.1.pf2.png)
![hw_12.2.1.pf.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw_12.2.1.pf.png)
  
  
## Задание 2. Создать Service и подключить его к Pod

Создан pod с именем "netology-web"  
![hw_12.2.1.pf3.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw_12.2.1.pf3.png)

Создан сервис с именем "netology-svc" и подключен к "netology-web"  
![hw_12.2.3.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw_12.2.3.png)

Манифест
```
apiVersion: v1
kind: Service
metadata:
  name: web-svc
spec:
  ports:
    - name: echo
      port: 80
  selector: 
    app: echo
```

Результат проброса порта на первой картинке в ответе к заданию 2.

---
