# Домашнее задание к занятию "09.01 Жизненный цикл ПО"

## Подготовка к выполнению
1. Получить бесплатную [JIRA](https://www.atlassian.com/ru/software/jira/free)
2. Настроить её для своей "команды разработки"
3. Создать доски kanban и scrum

## Основная часть
В рамках основной части необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить следующий жизненный цикл:
1. Open -> On reproduce
2. On reproduce -> Open, Done reproduce
3. Done reproduce -> On fix
4. On fix -> On reproduce, Done fix
5. Done fix -> On test
6. On test -> On fix, Done
7. Done -> Closed, Open
  
![Task_HW9.1_BUG_workflow](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.1_BUG_workflow.png) 

Остальные задачи должны проходить по упрощённому workflow:
1. Open -> On develop
2. On develop -> Open, Done develop
3. Done develop -> On test
4. On test -> On develop, Done
5. Done -> Closed, Open
  
![Task_HW9.1_all_task_workflow](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.1_all_task_workflow.png)
  
Создать задачу с типом bug, попытаться провести его по всему workflow до Done. Создать задачу с типом epic, к ней привязать несколько задач с типом task, провести их по всему workflow до Done. При проведении обеих задач по статусам использовать kanban. Вернуть задачи в статус Open.
Перейти в scrum, запланировать новый спринт, состоящий из задач эпика и одного бага, стартовать спринт, провести задачи до состояния Closed. Закрыть спринт.
  
![Task_HW9.1_Workflows](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.1_Workflows.png)
![Task_HW9.1_kanban](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.1_kanban.png)
![Task_HW9.1_scrum](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.1_scrum.png)

Если всё отработало в рамках ожидания - выгрузить схемы workflow для импорта в XML. Файлы с workflow приложить к решению задания.

![All_task_workflow](https://github.com/le0lex/devops-netology/blob/main/All_task_workflow.xml) 
![BUG_workflow](https://github.com/le0lex/devops-netology/blob/main/screen/BUG_workflow.xml) 


---
# Домашнее задание к занятию "08.02 Работа с Playbook"

## Подготовка к выполнению

1. (Необязательно) Изучите, что такое [clickhouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [vector](https://www.youtube.com/watch?v=CgEhyffisLY)
2. Создайте свой собственный (или используйте старый) публичный репозиторий на github с произвольным именем.
3. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

## Основная часть

1. Приготовьте свой собственный inventory файл `prod.yml`.
```
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_connection: docker
      
vector:
  hosts:
    vector-01:
      ansible_connection: docker
```
  
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).

3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
Сделано
4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, установить vector.
```
- name: Install vector
  hosts: vector-01
  tasks:
      - name: Upload tar.gz vector from remote URL
        get_url:
            url: "https://packages.timber.io/vector/{{ vector_version }}/vector-{{ vector_version }}-x86_64-unknown-linux-musl.tar.gz"
            dest: "/tmp/vector-{{ vector_version }}-x86_64-unknown-linux-gnu.tar.gz"
            mode: 0755
            timeout: 60
            force: true
            validate_certs: false
        register: get_vector
        until: get_vector is succeeded
        tags: vector
      - name: Create directrory for vector
        file:
          state: directory
          path: "{{ vector_home }}"
        tags: vector
      - name: Extract vector in the installation directory
        unarchive:
          copy: false
          src: "/tmp/vector-{{ vector_version }}-x86_64-unknown-linux-musl.tar.gz"
          dest: "{{ vector_home }}"
          extra_opts: [--strip-components=1]
          creates: "{{ vector_home }}/bin/vector"
        tags:
          - skip_ansible_lint
          - vector
```
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
Ошибки:
![Task_5_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.2_t5_1.png) 
```
В строке 31 вместо ansible.builtin.command: "clickhouse-client -q 'create database logs;'"
вставил
      ansible.builtin.command:
       cmd: "clickhouse-client -q 'create database logs;'"
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/ansible/playbook$ sudo ansible-playbook -i inventory/prod.yml site.yml --check
[WARNING]: Found both group and host with same name: clickhouse
[WARNING]: Found both group and host with same name: vector

PLAY [Install Clickhouse] ****************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************
[WARNING]: Platform linux on host clickhouse is using the discovered Python interpreter at /usr/bin/python, but future
installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
ok: [clickhouse]

TASK [Get clickhouse distrib] ************************************************************************************************
ok: [clickhouse] => (item=clickhouse-client)
ok: [clickhouse] => (item=clickhouse-server)
failed: [clickhouse] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0777", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ************************************************************************************************
ok: [clickhouse]

TASK [Install clickhouse packages] *******************************************************************************************
fatal: [clickhouse]: FAILED! => {"changed": false, "msg": ["Could not detect which major revision of yum is in use, which is required to determine module backend.", "You can manually specify use_backend to tell the module whether to use the yum (yum3) or dnf (yum4) backend})"]}

PLAY RECAP *******************************************************************************************************************
clickhouse                 : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0   


```
Пробовал менять ansible.builtin.yum на ansible.builtin.apt, и добавлять "mode: 0777" но все равно выходит ошибка  

```
leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/ansible/playbook$ sudo ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: Found both group and host with same name: vector
[WARNING]: Found both group and host with same name: clickhouse

PLAY [Install Clickhouse] ****************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************
[WARNING]: Platform linux on host clickhouse is using the discovered Python interpreter at /usr/bin/python, but future
installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
ok: [clickhouse]

TASK [Get clickhouse distrib] ************************************************************************************************
changed: [clickhouse] => (item=clickhouse-client)
changed: [clickhouse] => (item=clickhouse-server)
failed: [clickhouse] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ************************************************************************************************
changed: [clickhouse]

TASK [Install clickhouse packages] *******************************************************************************************
fatal: [clickhouse]: FAILED! => {"ansible_facts": {"pkg_mgr": "apt"}, "changed": false, "msg": "No package matching './clickhouse-common-static-22.3.3.44.rpm' is available"}

PLAY RECAP *******************************************************************************************************************
clickhouse                 : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0  
```

Сами .rpm скачиваются:

```
leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/ansible/playbook$ sudo docker exec -ti clickhouse bash
root@21e003fa3105:/# ls -la
total 240732
drwxr-xr-x   1 root root      4096 Oct 12 10:19 .
drwxr-xr-x   1 root root      4096 Oct 12 10:19 ..
-rwxr-xr-x   1 root root         0 Oct 10 16:07 .dockerenv
drwxr-xr-x   1 root root      4096 Oct 12 08:50 bin
drwxr-xr-x   2 root root      4096 Sep  3 12:00 boot
-rwxrwxrwx   1 root root     38090 Oct 12 10:12 clickhouse-client-22.3.3.44.rpm
-rwxrwxrwx   1 root root 246310036 Oct 12 10:19 clickhouse-common-static-22.3.3.44.rpm
-rwxrwxrwx   1 root root     61151 Oct 12 10:12 clickhouse-server-22.3.3.44.rpm
drwxr-xr-x   5 root root       360 Oct 12 09:12 dev
drwxr-xr-x   1 root root      4096 Oct 12 09:24 etc
drwxr-xr-x   2 root root      4096 Sep  3 12:00 home
drwxr-xr-x   1 root root      4096 Oct 12 09:24 lib
drwxr-xr-x   2 root root      4096 Oct  4 00:00 lib64
drwxr-xr-x   2 root root      4096 Oct  4 00:00 media
drwxr-xr-x   2 root root      4096 Oct  4 00:00 mnt
drwxr-xr-x   2 root root      4096 Oct  4 00:00 opt
dr-xr-xr-x 326 root root         0 Oct 12 09:12 proc
drwx------   1 root root      4096 Oct 12 08:54 root
drwxr-xr-x   1 root root      4096 Oct 12 09:55 run
drwxr-xr-x   2 root root      4096 Oct  4 00:00 sbin
drwxr-xr-x   2 root root      4096 Oct  4 00:00 srv
dr-xr-xr-x  13 root root         0 Oct 12 09:12 sys
drwxrwxrwt   1 root root      4096 Oct 12 10:25 tmp
drwxr-xr-x   1 root root      4096 Oct  4 00:00 usr
drwxr-xr-x   1 root root      4096 Oct  4 00:00 var

```


7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---


# Домашнее задание к занятию "08.01 Введение в Ansible"

## Подготовка к выполнению
1. Установите ansible версии 2.10 или выше.
2. Создайте свой собственный публичный репозиторий на github с произвольным именем.
3. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть
1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте какое значение имеет факт `some_fact` для указанного хоста при выполнении playbook'a.
```
leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/ansible/playbook$ ansible-playbook -i inventory/test.yml site.yml
 
PLAY [Print os facts] *************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************
ok: [localhost]

TASK [Print OS] *******************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *****************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP ************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  

`some_fact` имеет значение 12:
"msg": 12
```
2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.
```
leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/ansible/playbook/group_vars/all$ cat examp.yml 
---
  some_fact: "all default fact"

leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/ansible/playbook$ ansible-playbook -i inventory/test.yml site.yml
 
PLAY [Print os facts] *************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************
ok: [localhost]

TASK [Print OS] *******************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *****************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP ************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
```
done
```
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
![Task_4_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.1_task4.png) 
  

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились следующие значения: для `deb` - 'deb default fact', для `el` - 'el default fact'.
![Task_5_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.1_task5.png) 
  

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
![Task_6_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.1_task6.png) 
  

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
![Task_7_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.1_task7.png) 
  

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
![Task_8_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.1_task8.png) 
  

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
Необходимо использовать плагин "local"  
  
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
![Task_10_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.1_task10.png) 
  

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
![Task_11_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.1_task11.png) 
  
После добавления отдельного group-vars для local вывод выглядит так:  
![Task_11_1_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.1_task11_1.png) 


12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в вашей личный репозиторий.

---








