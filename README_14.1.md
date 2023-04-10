# Домашнее задание к занятию "Архитектура кластера k8s"

### Цель задания

Рассчитать требования к кластеру под проект   

------

### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

- [Considerations for large clusters](https://kubernetes.io/docs/setup/best-practices/cluster-large/)
- [Architecting Kubernetes clusters — choosing a worker node size](https://learnk8s.io/kubernetes-node-size)

------

### Задание. Необходимо определить требуемые ресурсы. 
Известно, что проекту нужны база данных, система кеширования, а само приложение состоит из бекенда и фронтенда. Опишите, какие ресурсы нужны, если известно:

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
3. Кэш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
4. Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий. 
5. Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.

----

### Правила приема работы

1. Домашняя работа оформляется в своем Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Сначала сделайте расчет всех необходимых ресурсов 
3. Затем прикиньте количество рабочих нод, которые справятся с такой нагрузкой. 
4. Добавьте к полученным цифрам запас, который учитывает выход из строя как минимум одной ноды. 
5. Добавьте служебные ресурсы к нодам. Помните, что для разных типов нод требовния к ресурсам разные. 
6. В результате должно быть указано количество нод и их параметры.


----

#### Ответ

1. Для БД необходимо минимум 4х3=12 ГБ ОЗУ, 1х3=3 ядра CPU. Для кэша 4х3=12 ГБ ОЗУ, 3 ядра CPU. Для фронтенда 5х50=250 МБ ОЗУ, 0,2х5=1 ядро CPU. Бекенд требует 600х10 = 6ГБ ОЗУ, 1х10=10 ядер CPU. В итоге получается 30250 МБ ОЗУ, 17 ядер CPU. 
2. Поскольку кластер должен быть отказоустойчивый, то я бы разворачивал его как минмум на 3х отдельных нодах. Одна нода это master нода, а также может выполнять функции резервной воркер ноды. Мастер ноды лучше взять три для отказоустойчиваости. И две, а лучше три воркер ноды для приложений, по одной для приложения. При этом надо сделать запас по ресурсам на случай отказа одной из нод.
3.С учетом отказоустойчивости получается 6 нод - три для мастер нод и три для приложений.
4. По служебным ресурсам к мастер нодам добавим  по 2 CPU и 4 ГБ ОЗУ. Для Worker ноды добавим 2 ядра CPU и по 2 GB ОЗУ.
5. В итоге целевая конфигурация требует 3 мастер ноды с ресурсами по 4 CPU и 8ГБ ОЗУ, с двукратным запасом, и три воркер ноды с ресурсами по 16 ядер CPU и 16 ГБ ОЗУ, с небольшим запасом.
  
Оптимальная конфигурация:  

| Тип ноды | Количество | CPU | RAM |
|---------|---|---| ---|
| Master | 3 | 4 | 8 |
| Worker | 3 | 16 | 16 |
  
Минимальная конфигурация:  

| Тип ноды | Количество | CPU | RAM |
|---------|---|---| ---|
| Master | 1 | 8 | 16 |
| Worker | 2 | 16 | 32 |