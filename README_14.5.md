# Домашнее задание к занятию "Troubleshooting"

### Цель задания

Устранить неисправности при деплое приложения.

### Чеклист готовности к домашнему заданию

1. Кластер k8s.  
  
![HW_14.5_t1_001.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_14.5_t1_001.png)
  
### Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить.

1. Установить приложение по команде:
```shell
kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
```
2. Выявить проблему и описать.
3. Исправить проблему, описать, что сделано.
4. Продемонстрировать, что проблема решена.
  
### Ответ  
Попытка запуска приложения неуспешна.  

![HW_14.5_t1_002.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_14.5_t1_002.png)
  
Проблема в отсутствии namespace web  и data. Добавим их.  
  
![HW_14.5_t1_0031.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_14.5_t1_0031.png)
  
Теперь, приложение запустилось успешно  
  
![HW_14.5_t1_003.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_14.5_t1_003.png)
  
Проверим логи подов  
  
![HW_14.5_t2_001.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_14.5_t2_001.png)
  
![HW_14.5_t2_002.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_14.5_t2_002.png)
  
Замечаю, что auth-db и web находятся в разных namespace, при том, что web обращается к auth-db в своем namespace  
  
![HW_14.5_t3_001.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_14.5_t3_001.png)
  
Исправляю на `auth-db.data`, используя команду `kubectl edit -n web deployments.apps web-consumer`  
  
![HW_14.5_t3_002.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_14.5_t3_002.png)
  
После того, как поды успешно пересоздались, проверяем логи  
  
![HW_14.5_t4_001.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_14.5_t4_001.png)
![HW_14.5_t4_002.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_14.5_t4_002.png)
  
---