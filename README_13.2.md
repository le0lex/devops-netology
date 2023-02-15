# Домашнее задание к занятию "Хранение в K8s. Часть 2"

### Цель задания

В тестовой среде Kubernetes необходимо создать PV и продемострировать запись и хранение файлов.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S)
2. Установленный локальный kubectl
3. Редактор YAML-файлов с подключенным github-репозиторием

------

### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://microk8s.io/docs/nfs) по установке NFS в MicroK8S
2. [Описание](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) Persistent Volumes
3. [Описание](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) динамического провижининга
4. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool

------

### Задание 1. Создать Deployment приложения, использующего локальный PV, созданный вручную

1. Создать Deployment приложения состоящего из контейнеров busybox и multitool.
2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.
3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые 5 секунд в общей директории. 
4. Продемонстрировать, что файл сохранился на локальном диске ноды, а также что произойдет с файлом после удаления пода и deployment'а. Почему?
5. Предоставить манифесты, а также скриншоты и/или вывод необходимых команд.
  
#### Ответ:  
  
Создан [Deployment](https://github.com/le0lex/devops-netology/blob/f0c4f9d2ff3873a5d6357973c6335462875194bb/HW_13.2/hw13.2_1.yaml):  
  
![hw13.2_1.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.2_1.1.png)
  
Как видим, контейнеры не поднялись. Создаём [PV](https://github.com/le0lex/devops-netology/blob/f0c4f9d2ff3873a5d6357973c6335462875194bb/HW_13.2/hw13.2_1_pv.yaml) и [PVC](https://github.com/le0lex/devops-netology/blob/f0c4f9d2ff3873a5d6357973c6335462875194bb/HW_13.2/hw13.2_1_pvc.yaml):
  
![hw13.2_1.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.2_1.2.png)
![hw13.2_1.2.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.2_1.2.1.png)
  
Теперь контейнеры работают:  
  
![hw13.2_1.2.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.2_1.2.2.png)
  
Проверяем запись и чтение из файла:  
  
![hw13.2_1.3.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.2_1.3.png) 
  
Удаляем Deployment, но файл при этом остаётся, потому что он пишется на ноду в persistent-volume, который при удалении пода не удаляется, а при восстановлении пода автоматически подключается к нему.  
  
![hw13.2_1.4.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.2_1.4.png)
  
------

### Задание 2. Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV

1. Включить и настроить NFS-сервер на microK8S.
2. Создать Deployment приложения состоящего из multitool и подключить к нему PV, созданный автоматически на сервере NFS
3. Продемонстрировать возможность чтения и записи файла изнутри пода. 
4. Предоставить манифесты, а также скриншоты и/или вывод необходимых команд.
  
#### Ответ:  
  
Включен и настроен NFS-сервер на microK8S  
  
![hw13.2_2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.2_2.png)
  
Создан [Deployment](https://github.com/le0lex/devops-netology/blob/384c3c9c74483a54e17f954e0be7812de270392a/HW_13.2/hw13.2_2.yaml)  
  
![hw13.2_2.1.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.2_2.1.png)
  
Созданы [PVC](https://github.com/le0lex/devops-netology/blob/384c3c9c74483a54e17f954e0be7812de270392a/HW_13.2/hw13.2_2_pvc.yaml) и [SC](https://github.com/le0lex/devops-netology/blob/384c3c9c74483a54e17f954e0be7812de270392a/HW_13.2/hw13.2_2_sc.yaml)   
  
![hw13.2_2.2.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.2_2.2.png)
  
PV не создались, соответственно контейнер не поднялся. Судя по всему некорректно настроен NFS-сервер на microK8S либо в чём-то другом причина, не смог разобраться самостоятельно.   
  
![hw13.2_2.3.png](https://github.com/le0lex/devops-netology/blob/main/screen/hw13.2_2.3.png)  
  

------
