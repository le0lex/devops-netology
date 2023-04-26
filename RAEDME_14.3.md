# Домашнее задание к занятию "Как работает сеть в K8S"

### Цель задания

Настроить сетевую политику доступа к подам.

### Чеклист готовности к домашнему заданию

1. Кластер k8s с установленным сетевым плагином calico

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Документация Calico](https://www.tigera.io/project-calico/)
2. [Network Policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
3. [About Network Policy](https://docs.projectcalico.org/about/about-network-policy)

-----

### Задание 1. Создать сетевую политику (или несколько политик) для обеспечения доступа

1. Создать deployment'ы приложений frontend, backend и cache и соответсвующие сервисы.
2. В качестве образа использовать network-multitool.
3. Разместить поды в namespace app.
4. Создать политики чтобы обеспечить доступ frontend -> backend -> cache. Другие виды подключений должны быть запрещены.
5. Продемонстрировать, что трафик разрешен и запрещен.

-----

### Ответ  
  
1. [Манифест](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/HW_14.3/app-namespace.yaml) для создания namespace app  
  
2. [Манифест](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/HW_14.3/frontend.yaml) для создания deployment frontend
     
3. [Манифест](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/HW_14.3/backend.yaml) для создания deployment backend  
  
4. [Манифест](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/HW_14.3/cache.yaml) для создания deployment cache  
  
5. Подготовка:  
  
![Get nodes](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/screen/HW_14.3_t001.png)
  
![Calicio installation](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/screen/HW_14.3_t002.png) 
  
6. Создание deployment:  
  
![namespace](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/screen/HW_14.3_t003.png)
  
![Rest deployments & results](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/screen/HW_14.3_t004.png)
  
7. Создание [политик](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/HW_14.3/net_policies.yaml)
  
![Policies](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/screen/HW_14.3_t005.png)
  
8. Проверка доступности frontend -> backend -> cache  
  
![Access](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/screen/HW_14.3_t006.png)
  
9. Проверка запрета доступа - cache-backend, cache-frontend, backend-frontend, frontend-cache:  
  
![Restrictions](https://github.com/le0lex/devops-netology/blob/15abeeaa33e32fdf0a3242b69662106bc8300ef0/screen/HW_14.3_t007.png)
  
  


  
