
# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

```
Ответ:

Вывод списка БД:
\l[+]   [PATTERN]      list databases
 
Подключение к БД
\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "postgres")

Вывод списка таблиц
\dt[S+] [PATTERN]      list tables

Описание содержимого таблиц
\d[S+]  NAME           describe table, view, sequence, or index

Выход из psql
\q                     quit psql
```
  
  
## Задача 2  
  
Используя `psql` создайте БД `test_database`.  
Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).  
Восстановите бэкап БД в `test_database`.  
Перейдите в управляющую консоль `psql` внутри контейнера.  
Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.  
Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders`   
с наибольшим средним значением размера элементов в байтах.  
**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.  
  
```
Ответ:

postgres=# CREATE DATABASE test_database;
CREATE DATABASE
postgres=# \q

root@leolex-VirtualBox:/# cd /var/lib/postgresql/data
root@leolex-VirtualBox:/var/lib/postgresql/data# psql -U postgres -f test_dump.sql test_database
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval 
--------
      8
(1 row)

ALTER TABLE

postgres=# \c test_database 
You are now connected to database "test_database" as user "postgres".
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner   
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE

test_database=# SELECT avg_width FROM pg_stats WHERE TABLENAME='orders';
 avg_width 
-----------
         4
        16
         4
(3 rows)

```
  
    
## Задача 3  
  
Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).  
Предложите SQL-транзакцию для проведения данной операции.  
Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?    
  
```
Ответ:

test_database=# alter table orders rename to orders_old;
ALTER TABLE
test_database=# create table orders (id integer, title varchar(80), price integer) partition by range(price);
CREATE TABLE
test_database=# create table orders_less499 partition of orders for values from (0) to (498);
CREATE TABLE
test_database=# create table orders_more499 partition of orders for values from (499) to (999999999);
CREATE TABLE
test_database=# insert into orders (id, title, price) select * from orders_old;
INSERT 0 8

Можно было изначально сделать таблицу секционной, тогда не пришлось бы переименовывать исходную таблицу и переносить данные в новую. То есть необходимо было определить тип на моменте проектирования и создания - partitioned table.

```  
  
  
## Задача 4  
  
Используя утилиту `pg_dump` создайте бекап БД `test_database`.  
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?  
  
```
root@leolex-VirtualBox:/# mkdir db_backup
root@leolex-VirtualBox:/# cd db_backup/
root@leolex-VirtualBox:/db_backup# pg_dump -U postgres -d test_database > test_database_bckp.sql
root@leolex-VirtualBox:/db_backup# ls -la
total 12
drwxr-xr-x 2 root root 4096 Jul 29 15:31 .
drwxr-xr-x 1 root root 4096 Jul 29 15:30 ..
-rw-r--r-- 1 root root 3543 Jul 29 15:31 test_database_bckp.sql

Для уникальности можно создать индекс или первчный ключ, например
create index on orders ((lower(title)));
```  


  

*****************************************************************************************************************************
  
# Домашнее задание к занятию "6.3. MySQL"

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с данным контейнером.
  
  
```
ysql> \s
--------------
mysql  Ver 8.0.30 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		25
Current database:	
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.30 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			1 hour 2 min 7 sec

Threads: 2  Questions: 80  Slow queries: 0  Opens: 140  Flush tables: 3  Open tables: 58  Queries per second avg: 0.021
--------------


mysql> use test_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> \s
--------------
mysql  Ver 8.0.30 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		25
Current database:	test_db
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.30 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			1 hour 3 min 52 sec

Threads: 2  Questions: 91  Slow queries: 0  Opens: 162  Flush tables: 3  Open tables: 80  Queries per second avg: 0.023
--------------

mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)


mysql> select count(*) from orders where price >300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```
  
Число записей 1  
    
	  
	    
## Задача 2  
  
Создайте пользователя test в БД c паролем test-pass, используя:  
- плагин авторизации mysql_native_password  
- срок истечения пароля - 180 дней  
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100  
- аттрибуты пользователя:  
    - Фамилия "Pretty"  
    - Имя "James"  

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.  
     
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.   

```
mysql> CREATE USER 'test'@'localhost' IDENTIFIED BY 'test-pass' WITH 
    -> MAX_QUERIES_PER_HOUR 100
    -> PASSWORD EXPIRE INTERVAL 180 DAY
    -> FAILED_LOGIN_ATTEMPTS 3
    -> ATTRIBUTE '{"fname": "James","lname": "Pretty"}';
Query OK, 0 rows affected (0.02 sec)

mysql> GRANT SELECT ON test_db.orders TO 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.00 sec)

```
  
  
    
## Задача 3  
   
Установите профилирование `SET profiling = 1`.  
Изучите вывод профилирования команд `SHOW PROFILES;`.  
Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.  
Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:  
- на `MyISAM`  
- на `InnoDB`  
  
```  
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SHOW PROFILES;
Empty set, 1 warning (0.00 sec)

mysql> SHOW TABLE STATUS WHERE NAME = 'orders';
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| Name   | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time         | Check_time | Collation          | Checksum | Create_options | Comment |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| orders | InnoDB |      10 | Dynamic    |    5 |           3276 |       16384 |               0 |            0 |         0 |              6 | 2022-07-28 17:19:44 | 2022-07-28 16:21:07 | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
1 row in set (0.00 sec)

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+-----------------------------------------+
| Query_ID | Duration   | Query                                   |
+----------+------------+-----------------------------------------+
|        1 | 0.00138900 | SHOW TABLE STATUS WHERE NAME = 'orders' |
|        2 | 0.03288375 | ALTER TABLE orders ENGINE = InnoDB      |
|        3 | 0.02444700 | ALTER TABLE orders ENGINE = MyISAM      |
+----------+------------+-----------------------------------------+
3 rows in set, 1 warning (0.00 sec)

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.04 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+-----------------------------------------+
| Query_ID | Duration   | Query                                   |
+----------+------------+-----------------------------------------+
|        1 | 0.00138900 | SHOW TABLE STATUS WHERE NAME = 'orders' |
|        2 | 0.03288375 | ALTER TABLE orders ENGINE = InnoDB      |
|        3 | 0.02444700 | ALTER TABLE orders ENGINE = MyISAM      |
|        4 | 0.03495125 | ALTER TABLE orders ENGINE = InnoDB      |
+----------+------------+-----------------------------------------+
4 rows in set, 1 warning (0.00 sec)
```     
	    
		   
		   
## Задача 4  
  
Изучите файл `my.cnf` в директории /etc/mysql.  
  
Измените его согласно ТЗ (движок InnoDB):  
- Скорость IO важнее сохранности данных  
- Нужна компрессия таблиц для экономии места на диске  
- Размер буффера с незакомиченными транзакциями 1 Мб  
- Буффер кеширования 30% от ОЗУ  
- Размер файла логов операций 100 Мб  
  
Приведите в ответе измененный файл `my.cnf`.  
  
Ответ:  
```
[mysqld]  
pid-file        = /var/run/mysqld/mysqld.pid  
socket          = /var/run/mysqld/mysqld.sock  
datadir         = /var/lib/mysql  
secure-file-priv= NULL 
   
#IO speed, для приоритета скорости ставим "0"  
innodb_flush_log_at_trx_commit = 0  
    
#Включаем компрессию  
innodb_file_format=Barracuda   

#Размер буффера с незакомиченными транзакциями 1 Мб  
innodb_log_buffer_size	= 1M  
  
#Буффер кеширования 30% от ОЗУ     
innodb_buffer_pool_size = 700М   
  
#Размер файла логов операций 100 Мб  
max_binlog_size	= 100M  
```
  



*******************************************************************************************************************************
  
# 6.2. SQL #  

## Задание 1    
  
Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы. Приведите получившуюся команду или docker-compose манифест.  
  
docker run --name pstgre-docker -e POSTGRES_PASSWORD=postgre -it -p 5432:5432 -v volume1:/home/leolex/postgresql/data -v   volume2:/home/leolex/lib/postgresql postgres:12  
  
leolex@leolex-VirtualBox:~/packer$ sudo docker ps   
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS                                                   NAMES  
4ff81d707cd5   postgres:12   "docker-entrypoint.s…"   8 minutes ago   Up 8 minutes   0.0.0.0:5431->5431/tcp, :::5431->5431/tcp, 5432/tcp     pstgre-docker  
  
leolex@leolex-VirtualBox:~/packer$ sudo docker exec -ti 4ff81d707cd5 psql -U postgres  
psql (12.11 (Debian 12.11-1.pgdg110+1))  
Type "help" for help.  

postgres=# \l  
                                 List of databases  
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges     
-----------+----------+----------+------------+------------+-----------------------  
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |   
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +  
           |          |          |            |            | postgres=CTc/postgres  
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +  
           |          |          |            |            | postgres=CTc/postgres  
(3 rows)  
    
    
      
    
## Задание 2  
  
![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW6.2_task2q.png)
    
CREATE DATABASE test_db;  
CREATE ROLE "test-admin-user" SUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;  
  
CREATE TABLE orders (id integer, name text, price integer, PRIMARY KEY (id));  
  
CREATE TABLE clients (id integer PRIMARY KEY, lastname text, country text, booking integer,	FOREIGN KEY (booking) REFERENCES orders (Id));  
  
CREATE ROLE "test-simple-user" NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;  
GRANT SELECT ON TABLE public.clients TO "test-simple-user";  
GRANT INSERT ON TABLE public.clients TO "test-simple-user";  
GRANT UPDATE ON TABLE public.clients TO "test-simple-user";  
GRANT DELETE ON TABLE public.clients TO "test-simple-user";  
GRANT SELECT ON TABLE public.orders TO "test-simple-user";  
GRANT INSERT ON TABLE public.orders TO "test-simple-user";  
GRANT UPDATE ON TABLE public.orders TO "test-simple-user";  
GRANT DELETE ON TABLE public.orders TO "test-simple-user";   
  
![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW6.2_task2.png)

    
## Задание 3  
  
![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW6.2_task3q.png)
```
postgres=# insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
INSERT 0 5  
postgres=# SELECT COUNT(*) FROM orders;  
 count   
-------  
     5  
(1 row)  
  
postgres=# insert into clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');  
INSERT 0 5  
postgres=# SELECT COUNT(*) FROM clients;  
 count   
-------  
     5  
(1 row)  
```

![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW6.2_task3.png)

    
## Задача 4  
  
![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW6.2_task4q.png)

```  
postgres=# update  clients set booking = 3 where id = 1;  
UPDATE 1  
postgres=# update  clients set booking = 4 where id = 2;  
UPDATE 1  
postgres=# update  clients set booking = 5 where id = 3;  
UPDATE 1  
  
postgres=# SELECT * FROM clients WHERE booking is not null;  
```
  
![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW6.2_task4.png)

  
## Задача 5  
  
Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).  
Приведите получившийся результат и объясните что значат полученные значения.  

```
postgres=# EXPLAIN SELECT * FROM clients WHERE booking IS NOT NULL;  
                        QUERY PLAN                           
-----------------------------------------------------------  
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)  
   Filter: (booking IS NOT NULL)  
(2 rows)  
```
  
Пример показывает как работает EXPLAIN. ВИдно. что в выводе команды получаем служебную информацию - фильтре по полю booking и нагрузку (стоимость) исполнения запроса.  
  
    
  	  
## Задача 6  
  
Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).  
Остановите контейнер с PostgreSQL (но не удаляйте volumes).  
Поднимите новый пустой контейнер с PostgreSQL.  
Восстановите БД test_db в новом контейнере.  
Приведите список операций, который вы применяли для бэкапа данных и восстановления.	  
  
```
leolex@leolex-VirtualBox:~/packer$ sudo docker exec -t pstgre-docker pg_dump -U postgres test_db -f /home/leolex/lib/postgresql/db_dump.sql   

leolex@leolex-VirtualBox:~/packer$ sudo docker exec -i pstgre-docker3 psql -U postgres -d test_db -f /home/leolex/lib/postgresql/db_dump.sql  
SET   
SET  
SET  
SET  
SET  
 set_config   
------------  
   
(1 row)  
  
SET  
SET  
SET  
SET  
SET  
SET  
CREATE TABLE  
ALTER TABLE  
CREATE TABLE  
ALTER TABLE  
COPY 5  
COPY 5  
ALTER TABLE  
ALTER TABLE  
ALTER TABLE  
GRANT  
GRANT  
```
  
![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW6.2_task6.png)

  
  
  
**************************************************************************************************************************    
    
# 6.1. Типы и структура СУБД #

##Задача 1##  
Архитектор ПО решил проконсультироваться у вас, какой тип БД лучше выбрать для хранения определенных данных.  

Он вам предоставил следующие типы сущностей, которые нужно будет хранить в БД:  

Электронные чеки в json виде - чек это финансовый документ, потому наиболее подходящий тип БД это документо-оринетированная БД.  
  
Склады и автомобильные дороги для логистической компании - лучше всего подойдут графовые БД, так как структура графов используется там, где описываются связи между объектами. В даннмоу случае склады это вершины(узлы), а дороги это ребра, которые описывают отношения между складами.  
  
Генеалогические деревья - Иерархичекая БД подходит лучше всего, так как генеалогическое дерево это по сути иерархия.  
  
Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации - для обеспечения быстрого доступа и идентификации лучше всего подойдет БД типа ключ-значение.   

Отношения клиент-покупка для интернет-магазина - лучше всего подойдет реляционная БД. В случае с интернет магазином, может быть множество взаимосвязанных таблиц, содержащие данные о том, что клиент покупал, сколько раз, по какой стоимости и т.д. С обработкой таких данных, для получения аналитики, например, лучше всего подойдет реляционная БД. Также тут можно использовать документо-ориентированные БД, но это будет менее удобно.  

Выберите подходящие типы СУБД для каждой сущности и объясните свой выбор.  
  
  
  
##Задача 2  ##
Вы создали распределенное высоконагруженное приложение и хотите классифицировать его согласно CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если (каждый пункт - это отдельная реализация вашей системы и для каждого пункта надо привести классификацию):  
  
Данные записываются на все узлы с задержкой до часа (асинхронная запись) - CA | PC/EL   
При сетевых сбоях, система может разделиться на 2 раздельных кластера  - PA | PA/EL  
Система может не прислать корректный ответ или сбросить соединение - PC | PA/EC  
А согласно PACELC-теореме, как бы вы классифицировали данные реализации?  
  
  
  
##Задача 3##  
Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?  

Принципы BASE и ACID противоположны по смыслу, поэтому в простых системах они сочетаться не могут. Если же говорить о сложных системах, где используются несколько БД и микросервисов, то для одной БД может быть использован BASE, а для другой ACID.  
  
   
     
##Задача 4  ##
Вам дали задачу написать системное решение, основой которого бы послужили:  
фиксация некоторых значений с временем жизни  
реакция на истечение таймаута  
Вы слышали о key-value хранилище, которое имеет механизм Pub/Sub. Что это за система? Какие минусы выбора данной системы?  

Redis - БД с высокой производительностью, за счет хранения данных в памяти. Также есть возможность присваивать данным время жизни TTL.
Минусы Redis:  
1) Высокие  требования к RAM  
2) Не поддерживает SQL  
3) Поскольку данные хранятся в RAM, то они могут быть потеряны при отключении сервера    
  
Redis может использоваться в качестве кэша. С точки зрения sub/pub системы, то БД не хранит у себя сообщения, отправляет потребителям и затем удаляет. Это может быть и плюсом и минусом в завсимости от сценария использования.  
Pub/sub это publisher-subscriber система, то есть Redis может используется как брокер сообщений. Он слушает, что опубликовано, и если находит то забирает и производит какие-либо действия.    
  
  
  
  
# 5.5. Оркестрация кластером Docker контейнеров на примере Docker Swarm  #

 Дайте письменые ответы на следующие вопросы: В чём отличие режимов работы сервисов в Docker Swarm кластере:   replication и global? Какой алгоритм выбора лидера используется в Docker Swarm кластере? Что такое Overlay Network?  
 
 Ответ:  
 
 Global - режим, в котором сервис по умолчанию равертывается на каждой ноде.  
 Replication - режим, при котором сервис развертывается только на части нод, указанных в файлах конфигурации.  
 
 В Docker Swarm используется алгоритм RAFT для выбора лидера. Его суть в том, что спустя определенный таймаут, каждая нода посылает запрос соседям (их количество заранее известно, как я понял), и при получении ответа от большинства соседей, становится лидером. Кто первый запрос послал, тот лидером и стал. Если две ноды одновременно посылают запрос и количество ответов недостаточно, чтобы чтобы стать лидером, то процесс выбора лидера повторяется. После того, как лидер определен, он посылает постоянные апдейты или хартбит, чтобы уведомить соседей, что он доступен. Если сосдеди не получают апдейт, то для них начинается таймаут и процесс выбора лидера.
 
 Overlay Network - тип логической сети, работает на основе технологии vxlan и поддерживает шифрование. Данная технология используется для решение проблем масшабируемости сетей. VXLAN — это технология или протокол туннелирования, который инкапсулирует L2 кадры внутри UDP-пакетов, обычно отправляемых на порт 4789. В случае с микросервисной архитекрурой, такой тип сети позволяет свободно общаться контейнерам между собой на разных нодах, не смотря на то, что они могут находиться в разных сегментах сети, но это не проблема так как vxlan предполагает применение l2 поверх l3, то есть с точки зрения контейнеров, это получается один и тот же сссегмент. Маршрутизацией в данном случае занимается сам docker.
  
  
   
Задача 2  
Создать ваш первый Docker Swarm кластер в Яндекс.Облаке  
Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:  
docker node ls  

![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW_5.5_task2.png)  

  

  
Задача 3  
Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.  
Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:  
docker service ls  
  
![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW_5.5_task3.png)
  


  Задача 4 (*)  
>Выполнить на лидере Docker Swarm кластера команду (указанную ниже) и дать письменное описание её функционала, что она делает и зачем она нужна:  
  
>см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/  
>docker swarm update --autolock=true  


>[centos@node01 ~]$ sudo docker swarm update --autolock=true  
>Swarm updated.  
>To unlock a swarm manager after it restarts, run the `docker swarm unlock`  
>command and provide the following key:  
  
    SWMKEY-1-AAxjVgi29gx3HiLV08o58/49MpDzfWY1eE8kpkLgt3A  
  
>Please remember to store this key in a password manager, since without it you  
>will not be able to restart the manager.  
  
>[centos@node01 ]$ sudo shutdown -r now  
>Connection to 51.250.84.237 closed by remote host.  
>Connection to 51.250.84.237 closed.  
>leolex@leolex-VirtualBox:~/terraform$ ssh centos@51.250.84.237  
>[centos@node01 ]$ sudo docker node list  
>Error response from daemon: Swarm is encrypted and needs to be unlocked before it can be used. Please use "docker   swarm unlock" to unlock it.  
  
>[centos@node01 ]$ sudo docker swarm unlock  
>Please enter unlock key:   
  
>[centos@node01 ]$ sudo docker node list  
>ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION  
>s7dpftfz6y3bpt10kn5uc7nl2 *   node01.netology.yc   Ready     Active         Reachable        20.10.17  
>vlriujpm5qaigcy2ctlggywux     node02.netology.yc   Ready     Active         Reachable        20.10.17  
>67943ijv8hgj1ypymp6m9rx3b     node03.netology.yc   Ready     Active         Leader           20.10.17  
>lxrbux4ey7s4ifn5cequh7zkv     node04.netology.yc   Ready     Active                          20.10.17  
>gauq228q4ar4inmj33chj7pdu     node05.netology.yc   Ready     Active                          20.10.17  
>e05xgkfbrhime5cb15pbywf6o     node06.netology.yc   Ready     Active                          20.10.17

В Docker 1.13 и выше журналы Raft, используемые менеджерами роя, по умолчанию шифруются на диске. Это шифрование в состоянии покоя защищает конфигурацию и данные вашей службы от злоумышленников, которые получают доступ к зашифрованным журналам Raft. Одна из причин, по которой эта функция была введена, заключалась в поддержке новой функции секретов Docker.  
  
Когда Docker перезапускается, и ключ TLS, используемый для шифрования связи между узлами роя, и ключ, используемый для шифрования и дешифрования журналов Raft на диске, загружаются в память каждого узла менеджера. В Docker 1.13 появилась возможность защитить ключ взаимного шифрования TLS и ключ, используемый для шифрования и дешифрования журналов Raft в состоянии покоя, что позволяет вам вступать во владение этими ключами и требовать ручную разблокировку ваших менеджеров. Эта функция называется автоматической блокировкой.  
То есть после перезапуска swarm надо сначала его разблокировать, используя ключ шифрования ключа.  
  
  
  
  
# 5.4. Оркестрация группой Docker контейнеров на примере Docker Compose #

Задача 1 

Создать собственный образ операционной системы с помощью Packer.   

Для получения зачета, вам необходимо предоставить:   

Скриншот страницы, как на слайде из презентации (слайд 37).   
   

Ответ:   

[C:\Users\ealekza\OneDrive - Ericsson AB\Личное\Нетология\packer_1.8.0_windows_amd64]$ yc vpc network create --name net --labels my-label=netology --description "my first netwrok via yc"
id: enp0qou84vddvhel3pua
folder_id: b1g0gv9upgikeuveglj5
created_at: "2022-07-11T09:44:41Z"
name: net
description: my first netwrok via yc
labels:
  my-label: netology


[C:\Users\ealekza\OneDrive - Ericsson AB\Личное\Нетология\packer_1.8.0_windows_amd64]$ yc vpc subnet create --name my-subnet-a --zone ru-central1-a --range 10.1.2.0/24 --network-name net --description "my first subnet via yc"
id: e9buv9hkhv0nt8mljqei
folder_id: b1g0gv9upgikeuveglj5
created_at: "2022-07-11T09:47:31Z"
name: my-subnet-a
description: my first subnet via yc
network_id: enp0qou84vddvhel3pua
zone_id: ru-central1-a
v4_cidr_blocks:
  - 10.1.2.0/24

[C:\Users\ealekza\OneDrive - Ericsson AB\Личное\Нетология\packer_1.8.0_windows_amd64]$ yc config list
token: AQAAAAAMsX6fAATuwWHveRAUZEVammXEyQQ7Ves
cloud-id: b1ge7enf5de1k75hpn8d
folder-id: b1g0gv9upgikeuveglj5
compute-default-zone: ru-central1-a

![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW_5.4_task1.PNG)  


[C:\Users\ealekza\OneDrive - Ericsson AB\Личное\Нетология\packer_1.8.0_windows_amd64]$ yc compute image list  
+----------------------+---------------+--------+----------------------+--------+  
|          ID          |     NAME      | FAMILY |     PRODUCT IDS      | STATUS |  
+----------------------+---------------+--------+----------------------+--------+  
| fd81bag6mifcp4m29jrn | centos-7-base | centos | f2euv1kekdgvc0jrpaet | READY  |  
+----------------------+---------------+--------+----------------------+--------+  



Задача 2  
Создать вашу первую виртуальную машину в Яндекс.Облаке.  
  
Ответ:  

[C:\Users\ealekza\OneDrive - Ericsson AB\Личное\Нетология\packer_1.8.0_windows_amd64]$ yc compute instance create --name my-yc-instance --network-interface subnet-name=my-subnet-a --zone ru-central1-a  

![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW_5.4_task2.PNG)

![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW_5.4_task2_3.png)
with terraform



Задача 3  
Создать ваш первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов.  
  
Для получения зачета, вам необходимо предоставить:  
  
Скриншот работающего веб-интерфейса Grafana с текущими метриками, как на примере ниже  

Ответ:

![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW_5.4_task3_1.png)
![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW_5.4_task3_2.png)

  
  



  

***********************************************************************************************************

5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера

Задача 1
Сценарий выполения задачи:  

создайте свой репозиторий на https://hub.docker.com;  
выберете любой образ, который содержит веб-сервер Nginx;  
создайте свой fork образа;  
реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:  
<html>  
<head>  
Hey, Netology  
</head>  
<body>  
<h1>I’m DevOps Engineer!</h1>  
</body>  
</html>  
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.  
  
Ответ:  
    
root@leolex-VirtualBox:/home/leolex/www# docker login -u leolex  
Password:   
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.  
Configure a credential helper to remove this warning. See  
https://docs.docker.com/engine/reference/commandline/login/#credentials-store  
  
Login Succeeded  
  
root@leolex-VirtualBox:/# docker run --name docker-nginx -d -p 81:80  nginx  
3c32e4e1e8f5085145fdc7d49bde729b368590ee7afc51181e3c81530ad1978e  
  
root@leolex-VirtualBox:/# docker ps  
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                               NAMES  
3c32e4e1e8f5   nginx     "/docker-entrypoint.…"   7 seconds ago   Up 6 seconds   0.0.0.0:81->80/tcp, :::81->80/tcp   docker-nginx  
  
root@leolex-VirtualBox:/# docker exec -it docker-nginx bash  
root@3c32e4e1e8f5:/# cd /usr/share/nginx  
root@3c32e4e1e8f5:/usr/share/nginx# ls -la  
total 12  
drwxr-xr-x 3 root root 4096 Jun 23 04:13 .  
drwxr-xr-x 1 root root 4096 Jun 23 04:13 ..  
drwxr-xr-x 2 root root 4096 Jun 23 04:13 html  
root@3c32e4e1e8f5:/usr/share/nginx# cd html  
root@3c32e4e1e8f5:/usr/share/nginx/html# ls -la  
total 16  
drwxr-xr-x 2 root root 4096 Jun 23 04:13 .  
drwxr-xr-x 3 root root 4096 Jun 23 04:13 ..  
-rw-r--r-- 1 root root  497 Jun 21 14:25 50x.html  
-rw-r--r-- 1 root root  615 Jun 21 14:25 index.html  
root@3c32e4e1e8f5:/usr/share/nginx/html# exit  
exit  
  
root@leolex-VirtualBox:/# cd /home/leolex/www  
root@leolex-VirtualBox:/home/leolex/www# ls -la  
total 12  
drwxr-xr-x  2 root   root   4096 июл  5 17:27 .  
drwxr-xr-x 27 leolex leolex 4096 июл  5 17:26 ..  
-rw-r--r--  1 root   root     91 июл  5 17:27 index.html  
  
root@leolex-VirtualBox:/home/leolex/www# docker cp index.html docker-nginx:/usr/share/nginx/html  
  
root@leolex-VirtualBox:/home/leolex/www# docker exec -it docker-nginx bash  
root@3c32e4e1e8f5:/# cd usr/share/nginx/html  
root@3c32e4e1e8f5:/usr/share/nginx/html# ls  
50x.html  index.html  
root@3c32e4e1e8f5:/usr/share/nginx/html# cat index.html  
<html>  
<head>  
Hey, Netology  
</head>  
<body>  
<h1>I’m DevOps Engineer!</h1>  
</body>  
</html>  
  
root@3c32e4e1e8f5:/usr/share/nginx/html# exit  
exit  
  
root@leolex-VirtualBox:/home/leolex/www# docker ps  
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                               NAMES  
3c32e4e1e8f5   nginx     "/docker-entrypoint.…"   7 minutes ago   Up 7 minutes   0.0.0.0:81->80/tcp, :::81->80/tcp   docker-nginx  
  
root@leolex-VirtualBox:/home/leolex/www#  docker commit -m "modifyed index.html" -a leolex 3c32e4e1e8f5 leolex/nginx:v1  
sha256:a77dffe3cd6ff1644e67a337d67d431885db6fe8ba02727b00961133b480b44d  
  
root@leolex-VirtualBox:/home/leolex/www# docker image list  
REPOSITORY     TAG       IMAGE ID       CREATED          SIZE  
leolex/nginx   v1        a77dffe3cd6f   12 seconds ago   142MB  
nginx          latest    55f4b40fe486   12 days ago      142MB  
  
root@leolex-VirtualBox:/home/leolex/www# docker push leolex/nginx:v1  
The push refers to repository [docker.io/leolex/nginx]  
c1c95133598c: Pushed   
e7344f8a29a3: Mounted from library/nginx   
44193d3f4ea2: Mounted from library/nginx   
41451f050aa8: Mounted from library/nginx   
b2f82de68e0d: Mounted from library/nginx   
d5b40e80384b: Mounted from library/nginx   
08249ce7456a: Mounted from library/nginx   
v1: digest: sha256:78f354c4a78a465c481c5ae17c8e473caff68d0cd35b3e8832d32dd164f4c57b size: 1778  
root@leolex-VirtualBox:/home/leolex/www#   
  
root@leolex-VirtualBox:/home/leolex/www# docker stop docker-nginx  
docker-nginx  
root@leolex-VirtualBox:/home/leolex/www# docker rm docker-nginx  
docker-nginx  
  
root@leolex-VirtualBox:/home/leolex/www# docker image list  
REPOSITORY     TAG       IMAGE ID       CREATED          SIZE  
leolex/nginx   v1        a77dffe3cd6f   13 minutes ago   142MB  
nginx          latest    55f4b40fe486   12 days ago      142MB  
root@leolex-VirtualBox:/home/leolex/www# docker rmi a77dffe3cd6f  
Untagged: leolex/nginx:v1  
Untagged: leolex/nginx@sha256:78f354c4a78a465c481c5ae17c8e473caff68d0cd35b3e8832d32dd164f4c57b  
Deleted: sha256:a77dffe3cd6ff1644e67a337d67d431885db6fe8ba02727b00961133b480b44d  
Deleted: sha256:10ca78320030b059b18653f870d07b20b7f95a1196e885b09b225ab6344523db  
root@leolex-VirtualBox:/home/leolex/www# docker image list  
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE  
nginx        latest    55f4b40fe486   12 days ago   142MB  
root@leolex-VirtualBox:/home/leolex/www# docker rmi 55f4b40fe486  
Untagged: nginx:latest  
Untagged: nginx@sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea  
Deleted: sha256:55f4b40fe486a5b734b46bb7bf28f52fa31426bf23be068c8e7b19e58d9b8deb  
Deleted: sha256:5f58fed9b4d8e6c09cdc42eed6de6df7a7e35b40d92c98f30f8ecad4960fb7a0  
Deleted: sha256:8bb72c1d014292ebf1ae348a77624c536e766757356c6dbb0de75122a94b445d  
Deleted: sha256:cc9ac0adbded956d924bcf6c26ffbc93ea070019be1437d204b530a033ff4b16  
Deleted: sha256:30f210588f35917f0edb5a2465db7ad60e4ef3b6ac74fe155474e14e6f0995c5  
Deleted: sha256:5ecd5431cf49a2a11115844de1e7b23b9535be8789add9ab50973867db5f7d36  
Deleted: sha256:08249ce7456a1c0613eafe868aed936a284ed9f1d6144f7d2d08c514974a2af9  
  
root@leolex-VirtualBox:/home/leolex/www# docker image list  
REPOSITORY     TAG       IMAGE ID       CREATED          SIZE  
leolex/nginx   v1        a77dffe3cd6f   18 minutes ago   142MB  
  
root@leolex-VirtualBox:/home/leolex/www# docker run --name docker-nginx -d -p 81:80  leolex/nginx:v1  
d1d254ff6e64994506f71fab51e3dc94bdb7b61c1312997dddd5bc6dabf72add  
  
https://hub.docker.com/r/leolex/nginx  
  
![Screenshot](https://github.com/le0lex/devops-netology/blob/main/screen/HW5.3_Task1.png)  
  

Замечание  
Задание 1  
Подмену стартовой страницы нужно произвести в докерфайле. Попробуете?  
  
root@leolex-VirtualBox:/home/leolex/www# cat Dockerfile     
FROM nginx  
COPY . ./usr/share/nginx/html  
  
root@leolex-VirtualBox:/home/leolex/www# docker build -t leolex/nginx:2.0.0 .  
Sending build context to Docker daemon  6.656kB  
Step 1/2 : FROM nginx  
 ---> 55f4b40fe486    
Step 2/2 : COPY . ./usr/share/nginx/html    
 ---> 211632d11463   
Successfully built 211632d11463    
Successfully tagged leolex/nginx:2.0.0    
  
root@leolex-VirtualBox:/home/leolex/www# docker image list   
REPOSITORY       TAG       IMAGE ID       CREATED          SIZE  
leolex/nginx     2.0.0     211632d11463   57 seconds ago   142MB  
leolex/ansible   1.0.0     9ef80d6b84a1   25 hours ago     380MB  
leolex/nginx     v1        a77dffe3cd6f   47 hours ago     142MB  
nginx            latest    55f4b40fe486   2 weeks ago      142MB  
debian           latest    d2780094a226   2 weeks ago      124MB  
alpine           3.14      e04c818066af   3 months ago     5.59MB  
centos           latest    5d0da3dc9764   9 months ago     231MB  
root@leolex-VirtualBox:/home/leolex/www# docker run --name docker-nginx-v2 -d -p 81:80 leolex/nginx:2.0.0  
df6093870603feac39a38ab169ab017a73d45e08910f585ad2e1c73ed7ffc54f  
root@leolex-VirtualBox:/home/leolex/www# docker ps  
CONTAINER ID   IMAGE                COMMAND                  CREATED         STATUS         PORTS                               NAMES  
df6093870603   leolex/nginx:2.0.0   "/docker-entrypoint.…"   6 seconds ago   Up 6 seconds   0.0.0.0:81->80/tcp, :::81->80/tcp   docker-nginx-v2  

Результат тот же, но теперь подмена стратовой страницы просиходит при сборке контейнера.   

https://hub.docker.com/r/leolex/nginx version 2.0.0  

  
Задача 2  
Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"  

Детально опишите и обоснуйте свой выбор.  
  
--  

Сценарий:  
  
Высоконагруженное монолитное java веб-приложение;  
Nodejs веб-приложение;  
Мобильное приложение c версиями для Android и iOS;  
Шина данных на базе Apache Kafka;  
Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;  
Мониторинг-стек на базе Prometheus и Grafana;  
MongoDB, как основное хранилище данных для java-приложения;  
Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.  
  
  
Высоконагруженное монолитное java веб-приложение;  
Физический сервер, так как монолитное приложение не предполагает изменение кода, все компоненты находятся в одном месте, требуется максимальная утилизация аппаратных ресурсов.  
  
Nodejs веб-приложение;  
Лучше всего подойдёт использование Docker контейнеров, так как node.js является компонентом (сервисом), работающим с javascript, поэтому данный модуль можно легко разместить в контейнере, он отлично вписывается в концепцию микросервисной архитектуры.  
  
Мобильное приложение c версиями для Android и iOS;  
Виртуальные машины, так как разные ОС, а также данные приложения предполагают свои для каждого случая интерфейсы в сторону пользователя.  
  
Шина данных на базе Apache Kafka;  
Docker Контейнеры. Шина данных предполагает использование микросервисной архитектуры. Кроме того Apache Kafka, на сколько я понимаю, это сервис, поэтому лучше всего запускать данный сервис в контейнере. Исключением может быть случай связанный с высокой важностью передаваемых данных. В этом случае нужно позаботиться о резервировании или ипользовать ВМ.   
  
Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;  
Docker контейнер. На Docker hub уже есть готовые образы, с помощью которых можно запустить три разных контейнера. Их можно соединить в кластер, при необхдимости. Если речь идет о тестовой среде, то однозначно удобнее использовать контейнеры. Если о продакшн, то компоненты, в особенности elasticsearch, можно поднять на виртуалках, чтобы повысить отказоустойчивость.  
  
Мониторинг-стек на базе prometheus и grafana;  
Docker контейнер. Так как данные приложения не хранят данные, то лучше использовать контейнеры. Использование контейнеров такжже дает преимущество с точки зрения модификации системы мониторинга.  
  
MongoDB, как основное хранилище данных для java-приложения;  
Для хранения данных БД лучше подходит виртуальная машина. К тому же не указано, что система высоконагруженная, поэтому оптимальны вариантом будет ВМ.  
  
Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.  
ВМ или физический сервер, так как требуется хранение данных. С точки зрения масштабирования лучше будет использовать ВМ.   
  
  
  
Задача 3  
Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку "/data" из текущей рабочей директории на хостовой машине в "/data: контейнера;
Запустите второй контейнер из образа debian в фоновом режиме, подключив папку "/data" из текущей рабочей директории на хостовой машине в "/data" контейнера;
Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в "/data";
Добавьте еще один файл в папку "/data" на хостовой машине;
Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.

Запускаем контейнер centos с именем docker-centos в фоне и пробрасываем сразу tty, а также подключаем папку "/data"  
  
root@leolex-VirtualBox:/home/leolex/www/data# docker run --name docker-centos -d -t  -v /data:/data centos  
9fefb93152055fd92916debb166192270c154820d5bb634ab97511dab8cf2059  
root@leolex-VirtualBox:/home/leolex/www/data# docker ps  
CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS                               NAMES  
9fefb9315205   centos            "/bin/bash"              5 seconds ago   Up 5 seconds                                       docker-centos  

Запускаем контейнер debian с именем docker-debian в фоне и пробрасываем сразу tty, а также подключаем папку /data  
root@leolex-VirtualBox:/home/leolex/www/data# docker run --name docker-debian -d -t  -v /data:/data debian  
Unable to find image 'debian:latest' locally  
latest: Pulling from library/debian  
1339eaac5b67: Pull complete  
Digest: sha256:859ea45db307402ee024b153c7a63ad4888eb4751921abbef68679fc73c4c739  
Status: Downloaded newer image for debian:latest  
2ddc9a826f1c0a306b6e9530a6a60c40e6d5df16ccf955f134ccb5f1aff551b  
root@leolex-VirtualBox:/home/leolex/www/data# docker ps  
CONTAINER ID   IMAGE             COMMAND                  CREATED              STATUS              PORTS                               NAMES  
e2ddc9a826f1   debian            "bash"                   5 seconds ago        Up 4 seconds                                            docker-debian  
9fefb9315205   centos            "/bin/bash"              About a minute ago   Up About a minute                                       docker-centos  
  
Заходим в контейнер centos и создаем файл  
root@leolex-VirtualBox:/home/leolex/www/data# docker exec -ti 9fefb9315205 bash  
[root@9fefb9315205 /]# cd data  
[root@9fefb9315205 data]# touch centos_file  
[root@9fefb9315205 data]# echo 'test'  > /data/centos_file  
[root@9fefb9315205 data]# cat centos_file  
test  
[root@9fefb9315205 data]# exit  
exit  
  
Создаём файл на хостовой машине  
root@leolex-VirtualBox:/home/leolex/www/data# cd /data  
root@leolex-VirtualBox:/data# touch host_file  
root@leolex-VirtualBox:/data# echo test_host > /data/host_file  
  
Проверяем файл на контейнере debian   
root@leolex-VirtualBox:/data# docker exec -ti e2ddc9a826f1 bash  
root@e2ddc9a826f1:/# cd /data  
root@e2ddc9a826f1:/data# ls -la  
total 16  
drwxr-xr-x 2 root root 4096 Jul  6 12:37 .  
drwxr-xr-x 1 root root 4096 Jul  6 12:33 ..  
-rw-r--r-- 1 root root    5 Jul  6 12:37 centos_file  
-rw-r--r-- 1 root root   10 Jul  6 12:38 host_file  
root@e2ddc9a826f1:/data# cat centos_file   
test  
root@e2ddc9a826f1:/data# cat host_file   
test_host  
root@e2ddc9a826f1:/data#   
  
  
  
  
Задача 4 (*)
Воспроизвести практическую часть лекции самостоятельно.
Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

root@leolex-VirtualBox:/home/leolex/www/data# docker build -t leolex/ansible:1.0.0 .
Sending build context to Docker daemon  4.096kB
Step 1/5 : FROM alpine:3.14
3.14: Pulling from library/alpine
8663204ce13b: Pull complete 
Digest: sha256:06b5d462c92fc39303e6363c65e074559f8d6b1363250027ed5053557e3398c5
Status: Downloaded newer image for alpine:3.14
 ---> e04c818066af
..................

root@leolex-VirtualBox:/home/leolex/www/data# docker image list
REPOSITORY       TAG       IMAGE ID       CREATED              SIZE
leolex/ansible   1.0.0     9ef80d6b84a1   About a minute ago   380MB
leolex/nginx     v1        a77dffe3cd6f   22 hours ago         142MB
nginx            latest    55f4b40fe486   13 days ago          142MB
debian           latest    d2780094a226   13 days ago          124MB
alpine           3.14      e04c818066af   3 months ago         5.59MB
centos           latest    5d0da3dc9764   9 months ago         231MB
root@leolex-VirtualBox:/home/leolex/www/data# docker push leolex/ansible:1.0.0
The push refers to repository [docker.io/leolex/ansible]
24b5fb0278c2: Pushed 
b8d957d45378: Pushed 
b541d28bf3b4: Mounted from library/alpine 
1.0.0: digest: sha256:1aaaeaf59f8239358b2c2c1d98ed96b3d4009eb99afffbf8398fadccd4e39308 size: 947

http://hub.docker.com/r/leolex/ansible






***************************************************************************************************************************************************************************************************************************

5.2. Применение принципов IaaC в работе с виртуальными машинами

Задача 1

Опишите своими словами основные преимущества применения на практике IaaC паттернов.
Какой из принципов IaaC является основополагающим?

Преимуществом применения IaaC являтся автоматизация процесов разработки и развертывания, что приводит к значительному сокращению времени выхода приложения в коммерческое использование. IaaC подход обьясняет как правильно писать код, структурировать, документировать и т.д. В следствие чего IaaC помогает существенно сократить количество ошибок в конфигурации и проблем связанными с использованием различных сред для разработки, тестирования и развертывания. Самое главное преимущество применения IaaC это идемпотентность, то есть стабильное качество и результат работы кода раз за разом. Обеспечение идемпотентности является ключевым принципом IaaC.


Задача 2

Чем Ansible выгодно отличается от других систем управление конфигурациями?
Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

Ansible не требует установки клиента на целевую инфраструктуру все функции производятся по SSH. Также он прост в использовании по сравнению с другими системами управления конфигурациями. Легко расширяется за счет модулей. Написан на python. Для простых задач ansible может быть заущен из командной строки. 
Push, на мой взгляд, является более надёжным потому что в этом случае администратор контролирует сам многие процессы, такие как установка необходимых ресурсов на управляемый сервер  и на ПК, откуда передаются конфигурации. В режиме pull действия автоматизированы в большей степени и инициируются сервером, что может привести к непредскажуемым результатам и ошибкам. Также режим push не требует установки агентов, что также упрощает работу и повышает надежность.


Задача 3
Установить на личный компьютер:

VirtualBox
Vagrant
Ansible
Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.

leolex@leolex-VirtualBox:~$ vboxmanage --version
6.1.32_Ubuntur149290

leolex@leolex-VirtualBox:~$ vagrant --version
Vagrant 2.2.6

leolex@leolex-VirtualBox:~$ ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/leolex/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Mar 15 2022, 12:22:08) [GCC 9.4.0]


Задача 4 (*)
Воспроизвести практическую часть лекции самостоятельно.

Создать виртуальную машину.
Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
docker ps

leolex@leolex-VirtualBox:~/.vagrant.d$ vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202206.03.0' is up to date...
==> server1.netology: Setting the name of the VM: server1.netology
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key

Зависает на данном шаге. 

Timed out while waiting for the machine to boot. This means that
Vagrant was unable to communicate with the guest machine within
the configured ("config.vm.boot_timeout" value) time period.

If you look above, you should be able to see the error(s) that
Vagrant had when attempting to connect to the machine. These errors
are usually good hints as to what may be wrong.

If you're using a custom box, make sure that networking is properly
working and you're able to connect to the machine. It is a common
problem that networking isn't setup properly in these boxes.
Verify that authentication configurations are also setup properly,
as well.

If the box appears to be booting properly, you may want to increase
the timeout ("config.vm.boot_timeout") value.

Задача со звездочкой не получилась, по причине приведенной выше ошибки. Пытался гуглить в интернете, но решение не нашел.


*****************************************************************************************************

5.1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения.

Задача 1
Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

Ответ:

Паравиртуализация - ядро гостевой ОС модифицируется для работы с гипервизором. Гостевой ОС известно, что она гостевая система и есть хостовая ОС, куда передаются соответствующие команды. То есть Каждой виртуальной машине выделяется ровно столько ресурсов, сколько определено гипервизором, который является неким посредником между аппаратной частью и гостевой ОС.

Аппаратная виртуализация - гипервизор сам является по сути операционной системой, то есть дополнительно хостовая ОС не требуется. Это полная виртуализация. Гостевая ОС передает напрямую аппаратной части инструкции, которые должны поддерживаться этой аппаратной чстью. 

Виртуализация на основе ОС - гостевая ОС не знает, что она находится в виртуальной среде. Аппаратное обеспечение виртуализируется хостовой ОС, то есть аппаратное обеспечение имитируется. Такой тип виртуализации использует контейнеры. Их суть в том, что несклько контейнеров используют ресурсы одной и той же хостовой ОС, при этом ресурсы изолированы для каждого контейнера.



Задача 2
Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:

физические сервера,
паравиртуализация,
виртуализация уровня ОС.
Условия использования:

Высоконагруженная база данных, чувствительная к отказу.
Различные web-приложения.
Windows системы для использования бухгалтерским отделом.
Системы, выполняющие высокопроизводительные расчеты на GPU.
Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

Ответ:
физические сервера - Системы, выполняющие высокопроизводительные расчеты на GPU, высоконагруженная база данных, чувствительная к отказу. Так как у приложений есть прямой доступ к аппаратным ресурсам, на виртуализацию ресурсы не тратятся. Кроме того отсутствуют дополительные точки отказа в виде гипервизора. Более отказоустойчивым решением тут будет использование полной аппаратной виртуализации и объединение серверов в кластер.

паравиртуализация - Windows системы для использования бухгалтерским отделом. Если используется гипервизор от Microsoft, то особенно актуально. В данном случае присутствует гибкость с точки зрения масштабирования, ресурсы для каждой VM определяются заранее, удобно администрировать парк виртуальных машин, которые изолированы друг от друга.  

виртуализация уровня ОС. - Различные web-приложения. Контейнеры дают гибкость при масштабировании и высокий уровень отказоустойчивости. Предполагается, что web приложения требуют меньше ресурсов, чем, например, высокопроизводительные рассчеты на GPU. Также использование контейнеров удобнее с точки зрения администрирования.



Задача 3
Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
Для такого сценария, на мой взгляд, лучше всего подходит решение от VmWare vSphere, так как данное решение обладает богатым функционалом с точки зрения резервирования и балансировки нагрузки. 

Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
KVM - open source решение, поддерживает и Linux и Windows, хорошая производительность.

Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.
Hyper-V - является бесплатным гипервизором от Microsoft, также встроен в некоторые ОС от Microsoft, поэтому для сценария с использованием Windows машин подходит лучше всего.

Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.
Xen - поддерживает разные дистрибутивы linux. Позволяет создавать шаблоны и быстро запускать виртуальные машины linux. Xen обладает хорошей стабильностью и производительностью.

Задача 4
Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

Гетерогенная среда виртуализации предполагает повышенные требования к компетенции инженеров, более сложное обслуживание, проблемы с автоматизацией, риски связанные с совместимостью и, поскольку отсутствует общий стандарт, низкая эффективность. Гетерогенная среда виртуализации должна использоваться в исключительнах случаях, например, когда есть привязка к определенному вендору для определенного сервиса. Также минусом гетерогенной виртуализации является более дорогая техническая поддержка.

Минимизацией рисков при ипользовании гетерогенной среды виртуализации является грамотное планирование и проектирование. Необходимо понимать в какую сторону раззвивается инфраструктура, чтобы не загнать себя в угол и оказаться в сложной ситуации из-за несовместимости продуктов или сервисов. Правильнее, на мой взгляд, как минимум разделять среды виртуализации  и сервисы на низх по какому-либо принципу, чтобы они не интегрировались между собой в значительной степени.

Плюс гетерогенной среды виртуализации может быть в отвязке от какого-то одного вендора, а также в увеличении производительности для определенных сервисов оптимизированных под определенную среду виртуализации. Например, VmWare может не поддерживать некоторые виды аппаратного обеспечения, поэтому вместе с VmWare можно использовать альтернативную среду виртуализации. Другой пример, когда есть парк VM под Windows и под Lunux, то можно использовать hyper-v для Windows систем, а для linux Xen или KVM, если это дает ощутимый прирост производительности и функцональности и упрощает администрирование.

Я бы не стал использовать гетерогенную среду виртуализации без особой необходимости.




