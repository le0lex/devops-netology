# 8.2 описание Playbook по заданию

## GROUP VARS
clickhouse - имя пакета установки clickhouse  
vector - имя пакета установки vector    
vector_home - переменная домашнего каталога для vector  
vector_version - версия vector
clickhouse_version - версия clickhouse  
clickhouse-client - переменная для скачивания и установки компонента clickhouse
clickhouse-server - переменная для скачивания и установки компонента clickhouse
clickhouse-common-static - переменная для скачивания и установки компонента clickhouse

## Описание Play 

### Install clickhouse

### Install vector
 установлены тэги *vector* для дальнейшего использования и отладки 
 - загрузка установочного пакета 
 - создание рабочего каталога
 - распаковка в рабочий каталог из пакета
