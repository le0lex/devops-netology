# Домашнее задание к занятию "09.04 Jenkins"

## Подготовка к выполнению

1. Создать 2 VM: для jenkins-master и jenkins-agent.
2. Установить jenkins при помощи playbook'a.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

---
### Ответ:
---

1. Подготовлены 2 VM:  
![HW9.4_pt1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_pt1.png)

2. Установлен Jenkins:  
![HW9.4_pt2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_pt2.png)

3. Проверена работоспособность
![HW9.4_pt3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_pt3.png)
  
## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.
5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True), по умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.

---
### Ответ:
---

1. Создан `Freestyle Job`, настроена сборка:  
![HW9.4_t1-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_t1-1.png)  

![HW9.4_t1-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_t1-2.png) 

![HW9.4_t1-3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_t1-3.png) 

Лог запуска: [Freestyle Job](https://github.com/le0lex/devops-netology/blob/785153c582d182d69890c62d29151fa5039bbba8/HW_9.4/HW9.4_t1_freestyle_job.log)  

2. Создан `Declarative Pipeline Job`, настраиваем сборку и запускаем:

![HW9.4_t2-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_t2-1.png)

![HW9.4_t2-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_t2-2.png)

```
pipeline {
    agent {
        label 'linux-YC'
    }
    stages {
        stage('Git clone') {
            steps {
                git branch: 'master', url: 'https://github.com/le0lex/vector-role.git'
            }
        }
        stage('molecule install') {
            steps {
                sh 'pip3 install molecule molecule_docker'
            }
        }
        stage('Directory') {
            steps {
                dir('/opt/jenkins_agent/workspace/HW9.4_pipeline/') {
                sh 'molecule test'    }
                }
            }
        }
        }
```


Лог запуска: [Declarative Pipeline Job](https://github.com/le0lex/devops-netology/blob/785153c582d182d69890c62d29151fa5039bbba8/HW_9.4/HW9.4_t2_d-pipeline_job.log)

На `jenkins-agent` нет необходимых docker-контейнеров, которые использовались при выполнении в домашнем задании 8.5, поэтому задача вываливается с ошибкой.  

3. Переносим `Declarative Pipeline Job` в репозиторий в файл [`Jenkinsfile`](https://github.com/le0lex/devops-netology/blob/785153c582d182d69890c62d29151fa5039bbba8/HW_9.4/Jenkinsfile)  

![HW9.4_t3-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_t3-1.png)

4. Создан `Multibranch Pipeline` на запуск `Jenkinsfile` из репозитория:

![HW9.4_t4-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_t4-1.png)

![HW9.4_t4-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_t4-2.png)

```
pipeline {
    agent {
        label 'linux-YC'
    }
    stages {
        stage('Git clone') {
            steps {
                git branch: 'master', url: 'https://github.com/le0lex/vector-role.git'
            }
        }
        stage('molecule install') {
            steps {
                sh 'pip3 install molecule molecule_docker'
            }
        }
        stage('Directory') {
            steps {
                dir('/opt/jenkins_agent/workspace/HW9.4_pipeline/') {
                sh 'molecule test'    }
                }
            }
        }
        }
```

Лог запуска: [Multibranch Pipeline Job](https://github.com/le0lex/devops-netology/blob/785153c582d182d69890c62d29151fa5039bbba8/HW_9.4/HW9.4_t5_scr-pipeline_job_log.log)  


На `jenkins-agent` нет необходимых docker-контейнеров, которые использовались при выполнении в домашнем задании 8.5, поэтому задача вываливается с ошибкой.    

![HW9.4_t5-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_t5-1.png)


![HW9.4_t5-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.4_t5-2.png)

```
node("linux-YC"){
    stage("Git checkout"){
        git credentialsId: '5ac0095d-0185-431b-94da-09a0ad9b0e2c', url: 'git@github.com:aragastmatb/example-playbook.git'
    }
    stage("Sample define secret_check"){
        secret_check=true
    }
    
    if (secret_check){
        stage("Run playbook"){
        sh 'ansible-playbook site.yml -i inventory/prod.yml'
            }
        }
    else{
        stage("Run playbook with --check --diff"){
            sh 'ansible-playbook site.yml -i inventory/prod.yml --check --diff'
            }
       }
    }
```

Так как указан CredentialId которого нет, то задание вываливается с ошибкой.  

Лог запуска: [Multibranch Pipeline log](https://github.com/le0lex/devops-netology/blob/785153c582d182d69890c62d29151fa5039bbba8/HW_9.4/HW9.4_t5_scr-pipeline_job_log.log)  

6. Добавляем `ScriptedJenkinsfile` в репозиторий.

Ссылки на коммиты репозитория:

[`Declarative Pipeline`](https://github.com/le0lex/devops-netology/blob/27d8ddcbb4d8296e56f4edb14f2a45e2d3b1c84e/HW_9.4/Jenkinsfile)
[`Scripted Pipeline`](https://github.com/le0lex/devops-netology/blob/27d8ddcbb4d8296e56f4edb14f2a45e2d3b1c84e/HW_9.4/HW9.4_t5_scr-pipeline_job_script)



## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, которые завершились хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением с названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline таким образом, чтобы он мог сначала запустить через Ya.Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Тем самым, мы должны по нажатию кнопки получить готовую к использованию систему.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

# Домашнее задание к занятию "10.06. Инцидент-менеджмент"

## Задание 

Составьте постмортем, на основе реального сбоя системы Github в 2018 году.

Информация о сбое доступна [в виде краткой выжимки на русском языке](https://habr.com/ru/post/427301/) , а
также [развёрнуто на английском языке](https://github.blog/2018-10-30-oct21-post-incident-analysis/).


---
### Ответ:
---

![HW10.6_t1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.6_t1.png)


---


# Домашнее задание к занятию "09.03 CI\CD"

## Подготовка к выполнению

1. Создаём 2 VM в yandex cloud со следующими параметрами: 2CPU 4RAM Centos7(остальное по минимальным требованиям)
2. Прописываем в [inventory](./infrastructure/inventory/cicd/hosts.yml) [playbook'a](./infrastructure/site.yml) созданные хосты
3. Добавляем в [files](./infrastructure/files/) файл со своим публичным ключом (id_rsa.pub). Если ключ называется иначе - найдите таску в плейбуке, которая использует id_rsa.pub имя и исправьте на своё
4. Запускаем playbook, ожидаем успешного завершения
5. Проверяем готовность Sonarqube через [браузер](http://localhost:9000)
6. Заходим под admin\admin, меняем пароль на свой
7.  Проверяем готовность Nexus через [бразуер](http://localhost:8081)
8. Подключаемся под admin\admin123, меняем пароль, сохраняем анонимный доступ

---
### Ответ:
---

Созданы 2 VM:  

![HW9.3_pt_1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_pt_1.png)

id_rsa.pub добавлен
```
leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/HW_9.3/infrastructure/files$ ls -la
total 24
drwx------ 2 leolex leolex 4096 ноя 23 11:27 .
drwx------ 5 leolex leolex 4096 ноя 23 11:14 ..
-rw-rw-rw- 1 leolex leolex 1706 ноя 23 11:14 CentOS-Base.repo
-rw-rw-r-- 1 leolex leolex  578 ноя 23 11:27 id_rsa.pub
-rw-rw-rw- 1 leolex leolex 4263 ноя 23 11:14 pg_hba.conf
```

Playbook выполнен успешно:  
![HW9.3_pt_2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_pt_2.png)
  
[Ansible_log](https://github.com/le0lex/devops-netology/blob/a40144298ce32356cd938993a19e277b8cfc24bf/ansible.log)  

SonarQube доступен через браузер:  
![HW9.3_pt_3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_pt_3.png)  
  
Nexus доступен через браузер:  
![HW9.3_pt_4.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_pt_4.png)   
  
  
## Знакомоство с SonarQube

### Основная часть

1. Создаём новый проект, название произвольное
2. Скачиваем пакет sonar-scanner, который нам предлагает скачать сам sonarqube
3. Делаем так, чтобы binary был доступен через вызов в shell (или меняем переменную PATH или любой другой удобный вам способ)
4. Проверяем `sonar-scanner --version`
5. Запускаем анализатор против кода из директории [example](./example) с дополнительным ключом `-Dsonar.coverage.exclusions=fail.py`
6. Смотрим результат в интерфейсе
7. Исправляем ошибки, которые он выявил(включая warnings)
8. Запускаем анализатор повторно - проверяем, что QG пройдены успешно
9. Делаем скриншот успешного прохождения анализа, прикладываем к решению ДЗ

---
### Ответ:
---

Создан новый проект:  
![HW9.3_t_1-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_t_1-1.png)
  
Sonar-scanner скачан и установлен, PATH прописан:   
![HW9.3_t_1-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_t_1-2.png)
  
Анализатор выявил 2 бага:  
![HW9.3_t_1-3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_t_1-3.png)

Иправленный код:

```
fail.py 
index = 0
def increment(index):
    index += 1
    return index
def get_square(numb):
    return numb*numb
def print_numb(numb):
    print("Number is {}".format(numb))
#    pass

#index = 0
while (index < 10):
    index = increment(index)
    print(get_square(index))
```

Повторный запуск аналиизатора:
![HW9.3_t_1-4.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_t_1-4.png)
![HW9.3_t_1-5.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_t_1-5.png)

[sonar_log_2](https://github.com/le0lex/devops-netology/blob/a40144298ce32356cd938993a19e277b8cfc24bf/sonar_log_2.txt)  



## Знакомство с Nexus

### Основная часть

1. В репозиторий `maven-releases` загружаем артефакт с GAV параметрами:
   1. groupId: netology
   2. artifactId: java
   3. version: 8_282
   4. classifier: distrib
   5. type: tar.gz
2. В него же загружаем такой же артефакт, но с version: 8_102
3. Проверяем, что все файлы загрузились успешно
4. В ответе присылаем файл `maven-metadata.xml` для этого артефекта
  
---
### Ответ:
---  
  
![HW9.3_t_2-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_t_2-1.png)  
   
[maven-metadata](https://github.com/le0lex/devops-netology/blob/a40144298ce32356cd938993a19e277b8cfc24bf/maven-metadata.xml) 
 
### Знакомство с Maven

### Подготовка к выполнению

1. Скачиваем дистрибутив с [maven](https://maven.apache.org/download.cgi)
2. Разархивируем, делаем так, чтобы binary был доступен через вызов в shell (или меняем переменную PATH или любой другой удобный вам способ)
3. Удаляем из `apache-maven-<version>/conf/settings.xml` упоминание о правиле, отвергающем http соединение( раздел mirrors->id: my-repository-http-blocker)
4. Проверяем `mvn --version`
5. Забираем директорию [mvn](./mvn) с pom

### Основная часть

1. Меняем в `pom.xml` блок с зависимостями под наш артефакт из первого пункта задания для Nexus (java с версией 8_282)
2. Запускаем команду `mvn package` в директории с `pom.xml`, ожидаем успешного окончания
3. Проверяем директорию `~/.m2/repository/`, находим наш артефакт
4. В ответе присылаем исправленный файл `pom.xml`

---
### Ответ:
---  

Устанавливаем Maven производим настройки и проверяем доступность:   
  
![HW9.3_t_3-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_t_3-1.png) 

Меняем pom.xml под артефакт java 8_282:  
  
![HW9.3_t_3-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_t_3-2.png) 

Результат запуска команды mvn package:  
  
![HW9.3_t_3-3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_t_3-3.png) 

[mvn_log](https://github.com/le0lex/devops-netology/blob/a40144298ce32356cd938993a19e277b8cfc24bf/mvn_log.txt) 

Проверяем директорию ~/.m2/repository/:  
  
![HW9.3_t_3-4.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW9.3_t_3-4.png) 
 
[pom.xml](https://github.com/le0lex/devops-netology/blob/472457bfa8a7337363841bdbdfb1e45187dd0878/pom.xml) 

---


# Домашнее задание к занятию "08.05 Тестирование Roles"

## Подготовка к выполнению
1. Установите molecule: `pip3 install "molecule==3.5.2"`
2. Выполните `docker pull aragast/netology:latest` -  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри

---
### Ответ:
---

1. Устанавливаем `molecule` и проверяем:

![HW_8.5_t0-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.5_t0-1.png)

2. Скачиваем и проверяем docker-образ:

![HW_8.5_t0-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.5_t0-2.png)



## Основная часть

Наша основная цель - настроить тестирование наших ролей. Задача: сделать сценарии тестирования для vector. Ожидаемый результат: все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos7` внутри корневой директории clickhouse-role, посмотрите на вывод команды.
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
4. Добавьте несколько assert'ов в verify.yml файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска, etc). Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

---
### Ответ:
---

1. Запускаем `molecule` в директории clickhouse:

![HW_8.5_t1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.5_t1.png)

2. Сценарий тестирования для роли `vectorrole`:

![HW_8.5_t2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.5_t2.png)

3. Добавляем дистрибутивы в файл `molecule.yml`:

> 
    platforms:
      - name: centos_7
        image: centos:7
        pre_build_image: true
      - name: centos_8
        image: centos:8_update
        pre_build_image: true
      - name: ubuntu
        image: ubuntu:python
        pre_build_image: true
        
`molecule test`:

![HW_8.5_t3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.5_t3.png)

Полный результат работы в файле: [m_test_1.md](https://github.com/le0lex/vector-role/blob/f0f6a09a09713d37bbe02ee9afa060a88e935c38/m_test_1.md)

4. Добавляем assert в verify.yml и запускаем `molecule test` снова:

![HW_8.5_t4_2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.5_t4_2.png)

[m_test_2.md](https://github.com/le0lex/vector-role/blob/f0f6a09a09713d37bbe02ee9afa060a88e935c38/m_test_2.md)

5. Ссылка на коммит с рабочим сценарием: [molecule](https://github.com/le0lex/vector-role.git)


### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example)
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo - путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini` для того чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Ссылка на репозиторий являются ответами на домашнее задание. Не забудьте указать в ответе теги решений Tox и Molecule заданий.

---
### Ответ:
---

1. Файлы добавлены, контейнер запущен:

![HW_8.5_tox_1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.5_tox_1.png)

2. Исправляем tox.ini для проверки своей роли `default`, запускаем `tox`, получаем ошибки: так как в образе не установлен `docker`

Docker не установлен:
```
[root@d6767b2e66f2 vector-role]# docker --version
bash: docker: command not found
[root@d6767b2e66f2 vector-role]# podman --version
podman version 4.0.2
[root@d6767b2e66f2 vector-role]# exit
```

![HW_8.5_tox_2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.5_tox_2.png)



3. Меняем драйвер на `podman` и облегчаем сценарий

> 
    [tox]
    minversion = 1.8
    basepython = python3.6
    envlist = py{37,39}-ansible{210}
    skipsdist = true

    [testenv]
    passenv = *
    deps =
        -r tox-requirements.txt
        ansible210: ansible<3.0
    commands =
        {posargs:molecule test -s default --destroy always}
        
4. tox прошел по сценарию molecule, но завершился ошибками. Видимо, при работе с molecule использовались docker-образы без предустановленного python.

![HW_8.5_tox_3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.5_tox_3.png)

Полный вывод в [файле](https://github.com/le0lex/vector-role/blob/3939dac24acc02d5f66453fad0affcf2cb1164a8/tox-output.md)

5. Ссылка на коммит с рабочим сценарием (ветка master): [tox](https://github.com/le0lex/vector-role.git)

### Tox - Fixed   
  
Поправил molecule.yml:  
```
---
dependency:
  name: galaxy
driver:
  name: podman
platforms:
 - name: ubuntu
   image: docker.io/pycontribs/ubuntu:latest
   pre_build_image: true
   privileged: true
provisioner:
  name: ansible
playbooks:
  prepare: prepare.yml
verifier:
  name: ansible  
  ```
    
Результат:  
![HW_8.5_tox_3_fixed.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.5_tox_3_fixed.png)  
  
Full log:  
[tox_fixed_log](https://github.com/le0lex/devops-netology/blob/b5aa923de0e4b7be0a3a711549ee925a104cd28d/ansible/playbook_8.5/tox_fixed_log.txt)
  
Тест прошел успешно.    
  
---

# Домашнее задание к занятию "10.03. Grafana"

## Обязательные задания

### Задание 1
Используя директорию [help](./help) внутри данного домашнего задания - запустите связку prometheus-grafana.

Зайдите в веб-интерфейс графана, используя авторизационные данные, указанные в манифесте docker-compose.

Подключите поднятый вами prometheus как источник данных.

Решение домашнего задания - скриншот веб-интерфейса grafana со списком подключенных Datasource.

---
### Ответ:
---

1. Запускаем связку `prometheus-grafana`:

![HW10.3_t1_1](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.3_t1_1.png)

2. Подключаем `prometheus` как источник данных:

![HW10.3_t1_2](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.3_t1_2.png)


## Задание 2
Изучите самостоятельно ресурсы:
- [promql-for-humans](https://timber.io/blog/promql-for-humans/#cpu-usage-by-instance)
- [understanding prometheus cpu metrics](https://www.robustperception.io/understanding-machine-cpu-usage)

Создайте Dashboard и в ней создайте следующие Panels:
- Утилизация CPU для nodeexporter (в процентах, 100-idle)
- CPULA 1/5/15
- Количество свободной оперативной памяти
- Количество места на файловой системе

Для решения данного ДЗ приведите promql запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

---
### Ответ:
---

1. Создаем `Dashboard` и добавляем панели:

- Утилизация CPU

```
100 - (avg by (instance) (rate(node_cpu_seconds_total{job="nodeexporter",mode="idle"}[1m])) * 100) 
```

- CPULA 1/5/15

```
node_load1

node_load5

node_load15
```

- Количество свободной оперативной памяти

```
node_memory_Inactive_bytes/node_memory_MemAvailable_bytes*100
```

- Количество места на файловой системе

```
node_filesystem_avail_bytes{fstype!~"tmpfs|fuse.lxcfs|squashfs"} / node_filesystem_size_bytes{fstype!~"tmpfs|fuse.lxcfs|squashfs"}*100  
```

Скриншот получившегося `Dashboard` с добавленными панелями:

![HW10.3_t2](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.3_t2.png)



## Задание 3
Создайте для каждой Dashboard подходящее правило alert (можно обратиться к первой лекции в блоке "Мониторинг").

Для решения ДЗ - приведите скриншот вашей итоговой Dashboard.

---
### Ответ:
---

Алерты для каждой панели:

![HW10.3_t3_1](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.3_t3_1.png)

![HW10.3_t3_2](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.3_t3_2.png)

![HW10.3_t3_3](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.3_t3_3.png)

![HW10.3_t3_4](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.3_t3_4.png)

Финальный `Dashboard` с панелями и добавленными алертами:

![HW10.3_t3_5](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.3_t3_5.png)


## Задание 4
Сохраните ваш Dashboard.

Для этого перейдите в настройки Dashboard, выберите в боковом меню "JSON MODEL".

Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.

В решении задания - приведите листинг этого файла.

---
### Ответ:
---

Ссылка на листинг json-содержимого `Dashboard`: [dashboard.json](https://github.com/le0lex/devops-netology/blob/cf481016fc3a016175c073f4ac800be1f50c664f/HW_10.3/dashboard.json)  

---

# Домашнее задание к занятию "10.02. Системы мониторинга"

## Обязательные задания

1. Опишите основные плюсы и минусы pull и push систем мониторинга.

2. Какие из ниже перечисленных систем относятся к push модели, а какие к pull? А может есть гибридные?

    - Prometheus 
    - TICK
    - Zabbix
    - VictoriaMetrics
    - Nagios

3. Склонируйте себе [репозиторий](https://github.com/influxdata/sandbox/tree/master) и запустите TICK-стэк, 
используя технологии docker и docker-compose.(по инструкции ./sandbox up )

В виде решения на это упражнение приведите выводы команд с вашего компьютера (виртуальной машины):

    - curl http://localhost:8086/ping
    - curl http://localhost:8888
    - curl http://localhost:9092/kapacitor/v1/ping

А также скриншот веб-интерфейса ПО chronograf (`http://localhost:8888`). 

P.S.: если при запуске некоторые контейнеры будут падать с ошибкой - проставьте им режим `Z`, например
`./data:/var/lib:Z`

4. Изучите список [telegraf inputs](https://github.com/influxdata/telegraf/tree/master/plugins/inputs).
    - Добавьте в конфигурацию telegraf плагин - [disk](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/disk):
    ```
    [[inputs.disk]]
      ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]
    ```
    - Так же добавьте в конфигурацию telegraf плагин - [mem](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/mem):
    ```
    [[inputs.mem]]
    ```
    - После настройки перезапустите telegraf.
 
    - Перейдите в веб-интерфейс Chronograf (`http://localhost:8888`) и откройте вкладку `Data explorer`.
    - Нажмите на кнопку `Add a query`
    - Изучите вывод интерфейса и выберите БД `telegraf.autogen`
    - В `measurments` выберите mem->host->telegraf_container_id , а в `fields` выберите used_percent. 
    Внизу появится график утилизации оперативной памяти в контейнере telegraf.
    - Вверху вы можете увидеть запрос, аналогичный SQL-синтаксису. 
    Поэкспериментируйте с запросом, попробуйте изменить группировку и интервал наблюдений.
    - Приведите скриншот с отображением
    метрик утилизации места на диске (disk->host->telegraf_container_id) из веб-интерфейса.  

5. Добавьте в конфигурацию telegraf следующий плагин - [docker](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker):
```
[[inputs.docker]]
  endpoint = "unix:///var/run/docker.sock"
```

Дополнительно вам может потребоваться донастройка контейнера telegraf в `docker-compose.yml` дополнительного volume и 
режима privileged:
```
  telegraf:
    image: telegraf:1.4.0
    privileged: true
    volumes:
      - ./etc/telegraf.conf:/etc/telegraf/telegraf.conf:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
    links:
      - influxdb
    ports:
      - "8092:8092/udp"
      - "8094:8094"
      - "8125:8125/udp"
```

После настройки перезапустите telegraf, обновите веб интерфейс и приведите скриншотом список `measurments` в 
веб-интерфейсе базы telegraf.autogen . Там должны появиться метрики, связанные с docker.

Факультативно можете изучить какие метрики собирает telegraf после выполнения данного задания.

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

В веб-интерфейсе откройте вкладку `Dashboards`. Попробуйте создать свой dashboard с отображением:

    - утилизации ЦПУ
    - количества использованного RAM
    - утилизации пространства на дисках
    - количество поднятых контейнеров
    - аптайм
    - ...
    - фантазируйте)
    
    ---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
### Ответ:
---

1. `Pull` и `Push`-модели систем мониторинга:

- Push-модель – сервер мониторинга ожидает подключений от агентов для получения данных;
- Pull-модель – сервер мониторинга сам подключается к агентам мониторинга для выгрузки данных.

#### `Push`-модель

Плюсы:
- Удобна для использования в динамически создаваемых машинах, например в docker-контейнерах  
- Можно задавать глубину мониторинга на самих машинах 

Минусы:
- Передача данных в открытом виде по сети
- Есть риск потери данных при недоступности системы мониторинга

#### `Pull`-модель

Плюсы:
- Контроль над метриками с единой точки, возможность конеккта по SSL к агентам
- Разными системами мониторинга можно получать одни и те же метрики  
- Более высокий уровень контроля за источниками метрик ,т.е. всегда известно кто откуда что передает


Минусы:
- Неудобство для динамических машин (докер-контейнеры) нужно динамически собирать статистику о наличии машин, нужен дополнительный оркестратор
- Нет гарантии доставки пакетов


2. Сравнение систем:

#### `Pull`-модели: 

Nagios

#### `Push`-модели: 

TICK, VictoriaMetrics

#### Гибридные модели:

Prometheus, Zabbix

3. Запускаем TICK-стек и проверяем работоспособность:

[Tick_install-log](https://github.com/le0lex/devops-netology/blob/05713d4f8236319cf599044a200d3efe7dfcba71/Tick_install-log.md)

Вывод команды `curl http://localhost:8086/ping -v`

```
leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/HW_10.2/sandbox$ curl http://localhost:8086/ping -v
*   Trying 127.0.0.1:8086...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 8086 (#0)
> GET /ping HTTP/1.1
> Host: localhost:8086
> User-Agent: curl/7.68.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 204 No Content
< Content-Type: application/json
< Request-Id: 1ea6b747-6729-11ed-801a-0242ac120002
< X-Influxdb-Build: OSS
< X-Influxdb-Version: 1.8.10
< X-Request-Id: 1ea6b747-6729-11ed-801a-0242ac120002
< Date: Fri, 18 Nov 2022 10:09:42 GMT
< 
* Connection #0 to host localhost left intact

```

Вывод команды `curl http://localhost:8888 -v`

```
leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/HW_10.2/sandbox$ curl http://localhost:8888 -v
*   Trying 127.0.0.1:8888...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 8888 (#0)
> GET / HTTP/1.1
> Host: localhost:8888
> User-Agent: curl/7.68.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Accept-Ranges: bytes
< Cache-Control: public, max-age=3600
< Content-Length: 414
< Content-Security-Policy: script-src 'self'; object-src 'self'
< Content-Type: text/html; charset=utf-8
< Etag: ubyGAbz3Tc69bqd3w45d4WQtqoI=
< Vary: Accept-Encoding
< X-Chronograf-Version: 1.10.0
< X-Content-Type-Options: nosniff
< X-Frame-Options: SAMEORIGIN
< X-Xss-Protection: 1; mode=block
< Date: Fri, 18 Nov 2022 10:14:36 GMT
< 
* Connection #0 to host localhost left intact
<!DOCTYPE html><html><head><link rel="stylesheet" href="/index.c708214f.css"><meta http-equiv="Content-type" content="text/html; charset=utf-8"><title>Chronograf</title><link rel="icon shortcut" href="/favicon.70d63073.ico"></head><body> <div id="react-root" data-basepath=""></div> <script type="module" src="/index.e81b88ee.js"></script><script src="/index.a6955a67.js" nomodule="" defer></script> </body></html>
```

Вывод команды `curl http://localhost:9092/kapacitor/v1/ping -v`

```
leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/HW_10.2/sandbox$ curl http://localhost:9092/kapacitor/v1/ping -v
*   Trying 127.0.0.1:9092...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 9092 (#0)
> GET /kapacitor/v1/ping HTTP/1.1
> Host: localhost:9092
> User-Agent: curl/7.68.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 204 No Content
< Content-Type: application/json; charset=utf-8
< Request-Id: df2801c0-6729-11ed-8065-0242ac120005
< X-Kapacitor-Version: 1.6.5
< Date: Fri, 18 Nov 2022 10:15:05 GMT
< 
* Connection #0 to host localhost left intact

```

Скриншот веб-интерфейса ПО:

![HW10.2_t3](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.2_t3.png)

4. Добавляем плагины `disk` и `mem` в `telegraf`, перезапускаем `telegraf`:

Добавил в telegraf.conf:  
```
[[inputs.mem]]

[[inputs.disk]]
   ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]
```

Перезапустил telegraf:
![HW10.2_t4_1](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.2_t4_1.png)


В ` Data Explorer` добавил график утилизации оперативной памяти

![HW10.2_t4_2](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.2_t4_2.png)

Меняем группировку, интервал наблюдений и добавляем в новый дашбоард:

![HW10.2_t4_3](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.2_t4_3.png)
![HW10.2_t4_4](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.2_t4_4.png)

Добавил графики утилизации места на диске:

![HW10.2_t4_5](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.2_t4_5.png)
![HW10.2_t4_6](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.2_t4_6.png)

5. Добавляем плагины `docker` в `telegraf`, перезапускаем `telegraf`. 
Не получилось добиться появления measurment `docker`. Пробовал разные конфигурации `telegraf` и `docker-compose`, но безуспешно.

Плагин `docker`:

#### telegraf.conf

```
[[inputs.docker]]
  endpoint = "unix:///var/run/docker.sock"
  container_names = []
  timeout = "5s"
  perdevice = true
  total = false
```

#### docker-compose.yml

```
 telegraf:
    # Full tag list: https://hub.docker.com/r/library/telegraf/tags/
    build:
      context: ./images/telegraf/
      dockerfile: ./${TYPE}/Dockerfile
      args:
        TELEGRAF_TAG: ${TELEGRAF_TAG}
        image: "telegraf"
    privileged: true
    environment:
      HOSTNAME: "telegraf-getting-started"
    # Telegraf requires network access to InfluxDB
    links:
      - influxdb
    volumes:
      # Mount for telegraf configuration
      - ./telegraf/:/etc/telegraf/
      # Mount for Docker API access
      #- /var/run/docker.sock:/var/run/docker.sock
        #- ./etc/telegraf.conf:/etc/telegraf/telegraf.conf:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
    depends_on:
      - influxdb
    ports:
      - "8092:8092/udp"
      - "8094:8094"
      - "8125:8125/udp"

```
Позже нашел решение проблемы - нужно быол в контейнере telegraf дать права на чтение и запись файлу /var/run/docker.sock  
  
![HW10.2_t5](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.2_t5.png)  
  
Финальный вариант dashboard  
![dashboard ](https://github.com/le0lex/devops-netology/blob/main/screen/HW10.2_t4_7.png)

---

# Домашнее задание к занятию "08.06 Создание собственных modules"

## Подготовка к выполнению
1. Создайте пустой публичных репозиторий в любом своём проекте: `my_own_collection`
2. Скачайте репозиторий ansible: `git clone https://github.com/ansible/ansible.git` по любому удобному вам пути
3. Зайдите в директорию ansible: `cd ansible`
4. Создайте виртуальное окружение: `python3 -m venv venv`
5. Активируйте виртуальное окружение: `. venv/bin/activate`. Дальнейшие действия производятся только в виртуальном окружении
6. Установите зависимости `pip install -r requirements.txt`
7. Запустить настройку окружения `. hacking/env-setup`
8. Если все шаги прошли успешно - выйти из виртуального окружения `deactivate`
9. Ваше окружение настроено, для того чтобы запустить его, нужно находиться в директории `ansible` и выполнить конструкцию `. venv/bin/activate && . hacking/env-setup`

## Основная часть

Наша цель - написать собственный module, который мы можем использовать в своей role, через playbook. Всё это должно быть собрано в виде collection и отправлено в наш репозиторий.

1. В виртуальном окружении создать новый `my_own_module.py` файл
2. Наполнить его содержимым:
```python
#!/usr/bin/python

# Copyright: (c) 2018, Terry Jones <terry.jones@example.org>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_test

short_description: This is my test module

# If this is part of a collection, you need to use semantic versioning,
# i.e. the version is of the form "2.5.0" and not "2.4".
version_added: "1.0.0"

description: This is my longer description explaining my test module.

options:
    name:
        description: This is the message to send to the test module.
        required: true
        type: str
    new:
        description:
            - Control to demo if the result of this module is changed or not.
            - Parameter description can be a list as well.
        required: false
        type: bool
# Specify this value according to your collection
# in format of namespace.collection.doc_fragment_name
extends_documentation_fragment:
    - my_namespace.my_collection.my_doc_fragment_name

author:
    - Your Name (@yourGitHubHandle)
'''

EXAMPLES = r'''
# Pass in a message
- name: Test with a message
  my_namespace.my_collection.my_test:
    name: hello world

# pass in a message and have changed true
- name: Test with a message and changed output
  my_namespace.my_collection.my_test:
    name: hello world
    new: true

# fail the module
- name: Test failure of the module
  my_namespace.my_collection.my_test:
    name: fail me
'''

RETURN = r'''
# These are examples of possible return values, and in general should use other names for return values.
original_message:
    description: The original name param that was passed in.
    type: str
    returned: always
    sample: 'hello world'
message:
    description: The output message that the test module generates.
    type: str
    returned: always
    sample: 'goodbye'
'''

from ansible.module_utils.basic import AnsibleModule


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        name=dict(type='str', required=True),
        new=dict(type='bool', required=False, default=False)
    )

    # seed the result dict in the object
    # we primarily care about changed and state
    # changed is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # if the user is working with this module in only check mode we do not
    # want to make any changes to the environment, just return the current
    # state with no modifications
    if module.check_mode:
        module.exit_json(**result)

    # manipulate or modify the state as needed (this is going to be the
    # part where your module will do what it needs to do)
    result['original_message'] = module.params['name']
    result['message'] = 'goodbye'

    # use whatever logic you need to determine whether or not this module
    # made any modifications to your target
    if module.params['new']:
        result['changed'] = True

    # during the execution of the module, if there is an exception or a
    # conditional state that effectively causes a failure, run
    # AnsibleModule.fail_json() to pass in the message and the result
    if module.params['name'] == 'fail me':
        module.fail_json(msg='You requested this to fail', **result)

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
```
Или возьмите данное наполнение из [статьи](https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_general.html#creating-a-module).

3. Заполните файл в соответствии с требованиями ansible так, чтобы он выполнял основную задачу: module должен создавать текстовый файл на удалённом хосте по пути, определённом в параметре `path`, с содержимым, определённым в параметре `content`.
4. Проверьте module на исполняемость локально.
5. Напишите single task playbook и используйте module в нём.
6. Проверьте через playbook на идемпотентность.
7. Выйдите из виртуального окружения.
8. Инициализируйте новую collection: `ansible-galaxy collection init my_own_namespace.yandex_cloud_elk`
9. В данную collection перенесите свой module в соответствующую директорию.
10. Single task playbook преобразуйте в single task role и перенесите в collection. У role должны быть default всех параметров module
11. Создайте playbook для использования этой role.
12. Заполните всю документацию по collection, выложите в свой репозиторий, поставьте тег `1.0.0` на этот коммит.
13. Создайте .tar.gz этой collection: `ansible-galaxy collection build` в корневой директории collection.
14. Создайте ещё одну директорию любого наименования, перенесите туда single task playbook и архив c collection.
15. Установите collection из локального архива: `ansible-galaxy collection install <archivename>.tar.gz`
16. Запустите playbook, убедитесь, что он работает.
17. В ответ необходимо прислать ссылку на репозиторий с collection

---
### Ответ:
---

1. Создаем публичный репозиторий:

![HW8.6_p1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_p1.png)

2. Скачиваем репозиторий `ansible`, создаем вирутальное окружение и активруем его:

![HW8.6_p2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_p2.png)

3. Устанавливаем зависимости и запускаем настройку окружения:

![HW8.6_p3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_p3.png)
![HW8.6_p4.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_p4.png)

## Основная часть

Наша цель - написать собственный module, который мы можем использовать в своей role, через playbook. 
Всё это должно быть собрано в виде collection и отправлено в наш репозиторий.

1. В виртуальном окружении создать новый `my_own_module.py` файл
2. Наполнить его содержимым:
```python
#!/usr/bin/python

# Copyright: (c) 2018, Terry Jones <terry.jones@example.org>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_test

short_description: This is my test module

# If this is part of a collection, you need to use semantic versioning,
# i.e. the version is of the form "2.5.0" and not "2.4".
version_added: "1.0.0"

description: This is my longer description explaining my test module.

options:
    name:
        description: This is the message to send to the test module.
        required: true
        type: str
    new:
        description:
            - Control to demo if the result of this module is changed or not.
            - Parameter description can be a list as well.
        required: false
        type: bool
# Specify this value according to your collection
# in format of namespace.collection.doc_fragment_name
extends_documentation_fragment:
    - my_namespace.my_collection.my_doc_fragment_name

author:
    - Your Name (@yourGitHubHandle)
'''

EXAMPLES = r'''
# Pass in a message
- name: Test with a message
  my_namespace.my_collection.my_test:
    name: hello world

# pass in a message and have changed true
- name: Test with a message and changed output
  my_namespace.my_collection.my_test:
    name: hello world
    new: true

# fail the module
- name: Test failure of the module
  my_namespace.my_collection.my_test:
    name: fail me
'''

RETURN = r'''
# These are examples of possible return values, and in general should use other names for return values.
original_message:
    description: The original name param that was passed in.
    type: str
    returned: always
    sample: 'hello world'
message:
    description: The output message that the test module generates.
    type: str
    returned: always
    sample: 'goodbye'
'''

from ansible.module_utils.basic import AnsibleModule


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        name=dict(type='str', required=True),
        new=dict(type='bool', required=False, default=False)
    )

    # seed the result dict in the object
    # we primarily care about changed and state
    # changed is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # if the user is working with this module in only check mode we do not
    # want to make any changes to the environment, just return the current
    # state with no modifications
    if module.check_mode:
        module.exit_json(**result)

    # manipulate or modify the state as needed (this is going to be the
    # part where your module will do what it needs to do)
    result['original_message'] = module.params['name']
    result['message'] = 'goodbye'

    # use whatever logic you need to determine whether or not this module
    # made any modifications to your target
    if module.params['new']:
        result['changed'] = True

    # during the execution of the module, if there is an exception or a
    # conditional state that effectively causes a failure, run
    # AnsibleModule.fail_json() to pass in the message and the result
    if module.params['name'] == 'fail me':
        module.fail_json(msg='You requested this to fail', **result)

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
```
Или возьмите данное наполнение из [статьи](https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_general.html#creating-a-module).

3. Заполните файл в соответствии с требованиями ansible так, чтобы он выполнял основную задачу: module должен создавать текстовый файл на удалённом хосте по пути, определённом в параметре `path`, с содержимым, определённым в параметре `content`.
4. Проверьте module на исполняемость локально.
5. Напишите single task playbook и используйте module в нём.
6. Проверьте через playbook на идемпотентность.
7. Выйдите из виртуального окружения.
8. Инициализируйте новую collection: `ansible-galaxy collection init my_own_namespace.yandex_cloud_elk`
9. В данную collection перенесите свой module в соответствующую директорию.
10. Single task playbook преобразуйте в single task role и перенесите в collection. У role должны быть default всех параметров module
11. Создайте playbook для использования этой role.
12. Заполните всю документацию по collection, выложите в свой репозиторий, поставьте тег `1.0.0` на этот коммит.
13. Создайте .tar.gz этой collection: `ansible-galaxy collection build` в корневой директории collection.
14. Создайте ещё одну директорию любого наименования, перенесите туда single task playbook и архив c collection.
15. Установите collection из локального архива: `ansible-galaxy collection install <archivename>.tar.gz`
16. Запустите playbook, убедитесь, что он работает.
17. В ответ необходимо прислать ссылку на репозиторий с collection

---
### Ответ:
---

1. В виртуальном окружении создаем файл `my_own_module.py`:

![HW8.6_t1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_t1.png)

2. Заполняем его содержимым и вносим необходимые правки:

[my_own_module.py](https://github.com/le0lex/my_own_collection/blob/7b2d31b4693eaab27f93e021667029ea920528f7/my_own_module.py)

Создаем файл `payload.json` 

```
{
    "ANSIBLE_MODULE_ARGS": {
        "path": "/tmp/test_file.txt",
        "content": "Netology is a great school"
    }
}

```

3. Проверяем работу созданного модуля локально: 

![HW8.6_t3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_t3.png)

4. Пишем `single task playbook` запускаем его, проверяем идемпотентность:

```
---
- hosts: localhost
  tasks:
    - name: RUN my_own_module module
      my_own_module:
        path: "/tmp/file.txt"
        content: "default content"
```

![HW8.6_t4.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_t4.png)

5. Выходим из окружения, создаем новую коллекцию:

![HW8.6_t5.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_t5.png)

6. Переносим модуль в созданную коллекцию:

![HW8.6_t6.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_t6.png)

7. Преобразуем `single task playbook` в `single task role` и перенесем в коллецию:

![HW8.6_t7.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_t7.png)

8. Создаем `playbook` для использования новой роли, заполняем документацию и выкладываем в репозиторий

9. Создаем .tar.gz коллекции, создаем директорию и переносим туда `single task playbook` и архив c коллекцией.

![HW8.6_t13.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_t13.png)

10. Создаём ещё одну директорию любого наименования, перенесим туда single task playbook и архив c collection.

![HW8.6_t14.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_t14.png)

11. Устанавливаем коллекцию из локального архива, запускаем и проверяем `playbook`

![HW8.6_t15.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_t15.png)

12. Запускаем playbook

![HW8.6_t16.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.6_t16.png)

13. Ссылка на репозиторий: [my_own_collection v1.0.0](https://github.com/le0lex/my_own_collection.git)




## Необязательная часть

1. Реализуйте свой собственный модуль для создания хостов в Yandex Cloud.
2. Модуль может (и должен) иметь зависимость от `yc`, основной функционал: создание ВМ с нужным сайзингом на основе нужной ОС. Дополнительные модули по созданию кластеров Clickhouse, MySQL и прочего реализовывать не надо, достаточно простейшего создания ВМ.
3. Модуль может формировать динамическое inventory, но данная часть не является обязательной, достаточно, чтобы он делал хосты с указанной спецификацией в YAML.
4. Протестируйте модуль на идемпотентность, исполнимость. При успехе - добавьте данный модуль в свою коллекцию.
5. Измените playbook так, чтобы он умел создавать инфраструктуру под inventory, а после устанавливал весь ваш стек Observability на нужные хосты и настраивал его.
6. В итоге, ваша коллекция обязательно должна содержать: clickhouse-role(если есть своя), lighthouse-role, vector-role, два модуля: my_own_module и модуль управления Yandex Cloud хостами и playbook, который демонстрирует создание Observability стека.

---



# Домашнее задание к занятию "10.01. Зачем и что нужно мониторить"

## Обязательные задания

1. Вас пригласили настроить мониторинг на проект. На онбординге вам рассказали, что проект представляет из себя 
платформу для вычислений с выдачей текстовых отчетов, которые сохраняются на диск. Взаимодействие с платформой   
осуществляется по протоколу http. Также вам отметили, что вычисления загружают ЦПУ. Какой минимальный набор метрик вы  
выведите в мониторинг и почему?  
  
2. Менеджер продукта посмотрев на ваши метрики сказал, что ему непонятно что такое RAM/inodes/CPUla. Также он сказал,   
что хочет понимать, насколько мы выполняем свои обязанности перед клиентами и какое качество обслуживания. Что вы   
можете ему предложить?  
  
3. Вашей DevOps команде в этом году не выделили финансирование на построение системы сбора логов. Разработчики в свою   
очередь хотят видеть все ошибки, которые выдают их приложения. Какое решение вы можете предпринять в этой ситуации,   
чтобы разработчики получали ошибки приложения?  
  
4. Вы, как опытный SRE, сделали мониторинг, куда вывели отображения выполнения SLA=99% по http кодам ответов.   
Вычисляете этот параметр по следующей формуле: summ_2xx_requests/summ_all_requests. Данный параметр не поднимается выше   
70%, но при этом в вашей системе нет кодов ответа 5xx и 4xx. Где у вас ошибка?  
  
---
### Ответ:  
---
  
1. Минимальный набор метрик может быть таким:  
  
- метрики приложения (работа с хранилицем): количество http запросов и количество сохраненных запросов интервал времени. Значительные расхождения между количеством запросов и количеством сохраненых отчетов может говорить сбоях в системе.  
- метрики работы жесткого диска: обязательная метрика объема оставшегося свободного места, метрики связанные с количеством операций записи и чтения, задержка при записи и чтении, что покажет производительность работы жесткого диска.  
- метрики сетевой доступности:  метрика доступности ресурса например через ping,  метрики доступности шлюза и DNS-серверов.  
- метрики CPU:  метрика использования процессора по системынми службами и приложениям.  
- метрики оперативной памяти с заданным критическим значением.  
- нагрузка на сетвой интерфейс  
- количество открытых соединение с хостом или сервисом  
- мониторинг БД на предмет долгоработающих блокировок  
  
2. Очевидно речь идет о том, чтобы связать бизнес метрики с метриками техническими. Поэтому, для начала я предложу ему изучить SLA и отталкиваться от условий прописанных в SLA. Например, если допускается только 5% отказов, то можно указать доступность 95% с учетом технического обслуживания и 5% на отказы ресурса. Эту задачу можно решить посредством мониторинга сетевой доступности. Также можно выводить разницу между запросами на создание отчетов и сохраненными отчетами, то есть эффективность работы системы. Согласно требованию заказчика, например, 95% запросов должны сохраняться и быть доступны (SLO).  
Также можно вывести время формирования отчета(среднее время, а так же минимальное и максимальное время) и количество ошибок при формировании отчетов.  
  
3. Как вариант, можно логи хранить на сетевом ресурсе и дать туда доступ всем, кому требуется на чтение. Также можноиспользовать систему сбора логов (стэк ELK). Еще один вариант это воспользоваться бесплатными облачными решениями. Выбор будет зависеть от объема хранимой информации и глубины хранения данных. Например сервис SumoLogic.  
  
4. Необходимо просмотреть 3xx (перенаправления) и 1xx ((информационные) коды ответов, так как они не являются ошибочными.  
  
---


# Домашнее задание к занятию "8.4 Работа с Roles"

## Подготовка к выполнению
1. (Необязательно) Познакомтесь с [lighthouse](https://youtu.be/ymlrNlaHzIY?t=929)
2. Создайте два пустых публичных репозитория в любом своём проекте: vector-role и lighthouse-role.
3. Добавьте публичную часть своего ключа к своему профилю в github.

---
### Ответ:
---

1. Ознакомился с `lighthouse`.
2. Создано 2 новых репозитория `vector-role` и `lighthouse-role`:  

![HW_8.4_t1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t1.png)

3. Публичный ключ добавлен:  

![HW_8.4_t1_add-key.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t1_add-key.png)  

  

## Основная часть  
   
Наша основная цель - разбить наш playbook на отдельные roles. Задача: сделать roles для clickhouse, vector и lighthouse и написать playbook для использования этих ролей. Ожидаемый результат: существуют три ваших репозитория: два с roles и один с playbook.  
  
1. Создать в старой версии playbook файл `requirements.yml` и заполнить его следующим содержимым:  

   ```yaml
   ---
     - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
       scm: git
       version: "1.11.0"
       name: clickhouse 
   ```

2. При помощи `ansible-galaxy` скачать себе эту роль.  
3. Создать новый каталог с ролью при помощи `ansible-galaxy role init vector-role`.  
4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`.   
5. Перенести нужные шаблоны конфигов в `templates`.  
6. Описать в `README.md` обе роли и их параметры.  
7. Повторите шаги 3-6 для lighthouse. Помните, что одна роль должна настраивать один продукт.  
8. Выложите все roles в репозитории. Проставьте тэги, используя семантическую нумерацию Добавьте roles в `requirements.yml` в playbook.   
9. Переработайте playbook на использование roles. Не забудьте про зависимости lighthouse и возможности совмещения `roles` с `tasks`.  
10. Выложите playbook в репозиторий.  
11. В ответ приведите ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.  

---
### Ответ:  
---

1. Создаем файл `requirements.yml` и добавляем необходимое содержимое:  

```
leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/ansible/playbook_8.4$ cat requirements.yml 
---
  - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
    scm: git
    version: "1.11.0"
    name: clickhouse 


  - src: git@github.com:le0lex/vector-role.git
    scm: git
    version: "0.0.1"
    name: vector-role 

  - src: git@github.com:le0lex/lighthouse-role.git
    scm: git
    version: "0.0.1"
    name: lighthouse-role
```


2. Создаем папку `roles` и скачиваем туда роль при помощи `ansible-galaxy`:

![HW_8.4_t2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t2.png)   

3. Создаем роль `vector-role`:

![HW_8.4_t3-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t3-1.png) 

Добавляем в файл `vars/main.yml` переменные:

![HW_8.4_t3-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t3-2.png)

Добавляем `tasks` в файл `tasks/main.yml`:

![HW_8.4_t3-3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t3-3.png)

4. Создаем роль `lighthouse-role`:

![HW_8.4_t4-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t4-1.png)

Добавляем `tasks` в файл `tasks/main.yml`:

![HW_8.4_t4-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t4-2.png)

5. Выкладываем созданные роли в репозитории, созданные при подготовке:

`vector-role`:

![HW_8.4_t5-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t5-1.png)

`lighthouse-role`:

![HW_8.4_t5-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t5-2.png)

6. Добавление описания ролей в `README.md`:

`vector-role`:

![HW_8.4_t5-1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t5-1.png)

`lighthouse-role`:

![HW_8.4_t5-2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t5-2.png)

7. Добавляем вновь созданные `roles` в `requirements.yml` в playbook:

![HW_8.4_t7.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t7.png)

8. Пересобираем `playbook` на использование ролей:

![HW_8.4_t8.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_8.4_t8.png)

9. Ссылки на репозитории:

- [playbook](https://github.com/le0lex/devops-netology/tree/main/ansible/playbook_8.4)
- [vector-role](https://github.com/le0lex/vector-role.git)
- [lighthouse-role](https://github.com/le0lex/lighthouse-role.git)

---


# Домашнее задание к занятию "08.03 Использование Yandex Cloud"

## Подготовка к выполнению

1. (Необязательно) Познакомтесь с [lighthouse](https://youtu.be/ymlrNlaHzIY?t=929)
2. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.

Ссылка на репозиторий LightHouse: https://github.com/VKCOM/lighthouse

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает lighthouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику lighthouse, установить nginx или любой другой webserver, настроить его конфиг для открытия lighthouse, запустить webserver.
4. Приготовьте свой собственный inventory файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

Ответ:  
Подготовлены три VM   
![HW8.3_t0.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.3_t0.png)

Добавил в playbook новый play:  
```
- name: Install Lighthouse
  hosts: vm-lighthouse
  tasks:
    - name: Install EPEL
      become: true
      ansible.builtin.yum:
        name: "epel-release"
        state: latest
    - name: Install Nginx & Git
      become: true
      ansible.builtin.yum:
        name:
          - nginx
          - git
        state: latest
    - name: Start Nginx
      become: true
      ansible.builtin.systemd:
        name: nginx
        state: started
    - name: Autorun Nginx
      become: true
      ansible.builtin.systemd:
        name: nginx
        enabled: yes
    - name: Install FireWall
      become: true
      ansible.builtin.yum:
        name: "firewalld"
        state: latest
    - name: Start FireWall
      become: true
      ansible.builtin.systemd:
        name: firewalld
        state: started
    - name: Upgrade FireWall
      become: true
      ansible.builtin.command:
        cmd: "{{ item }}"
      with_items:
        - firewall-cmd --zone=public --permanent --add-service=http
        - firewall-cmd --zone=public --permanent --add-service=https
        - firewall-cmd --reload
    - name: Create directory
      become: true
      ansible.builtin.file:
        path: /var/www/lighthouse
        state: directory
        owner: nginx
        group: nginx
        mode: "0755"
    - name: Check folder
      ansible.builtin.stat:
        path: /usr/share/nginx/lighthouse
      register: stat_result
    - name: Clone repository Lighthouse
      become: true
      ansible.builtin.command:
        cmd: "{{ item }}"
      with_items:
        - git clone https://github.com/VKCOM/lighthouse.git /usr/share/nginx/lighthouse
        - sed -i 's|/usr/share/nginx/html|/usr/share/nginx/lighthouse|' /etc/nginx/nginx.conf
      when: stat_result.stat.islnk is not defined
    - name: Restart Nginx
      become: true
      ansible.builtin.systemd:
        name: nginx
        state: restarted
```

[README.md](https://github.com/le0lex/devops-netology/blob/40292a9d31866ef8329668bf4e5a095e48b00901/ansible/playbook_8.3/README.md)

Проверена конфигурация:  
![HW8.3_t0_lint.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.3_t0_lint.png)

Запуск playbook с параметром --check:  
![HW8.3_t1_check.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.3_t1_check.png)
![HW8.3_t1_check2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.3_t1_check2.png)

Запускаем playbook на prod с параметром --diff:  
prod.yml
```
---
clickhouse:
  hosts:
    vm-clickhouse:
       ansible_host: 158.160.10.42
      
vector:
  hosts:
    vm-vector:
       ansible_host: 84.252.140.23
       
lighthouse:
  hosts:
    vm-lighthouse:
       ansible_host: 84.201.166.62
```

![HW8.3_t1_1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.3_t1_1.png)
![HW8.3_t1_2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.3_t1_2.png)

Не перезапустился nginx, поэтому добавил "become: true" в блок "Restart Nginx"  

Повторный запуск playbook с параметром --diff:  
![HW8.3_t2_1.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.3_t2_1.png)
![HW8.3_t2_2.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.3_t2_2.png)

Теперь ошибки нет.

Проверяем доступ к WEB интерфейсу lighthouse:  
![HW8.3_t3.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.3_t3.png)

[08-ansible-03-yandex](https://github.com/le0lex/devops-netology/tree/main/ansible/playbook_8.3)

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
- name: Install Vector
  hosts: vector
  tasks:
    - name: Download Vector
      ansible.builtin.get_url:
        url: "https://packages.timber.io/vector/0.21.0/vector-0.21.0-1.x86_64.rpm"
        dest: "./vector-0.21.0-1.x86_64.rpm"
    - name: Install Vector
      become: true
      ansible.builtin.yum:
        name: "vector-0.21.0-1.x86_64.rpm"
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
Ожидаемо, скрипт выдал ошибку о том, что не нашел пакеты.  

![Task_6_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.2_t6_1.png) 

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

Получил ошибку:  
```
TASK [Create database] *******************************************************************************************************
fatal: [clickhouse]: FAILED! => {"changed": false, "cmd": ["clickhouse-client", "-q", "create database logs;"], "delta": "0:00:00.029054", "end": "2022-10-18 09:16:31.775849", "failed_when_result": true, "msg": "non-zero return code", "rc": 210, "start": "2022-10-18 09:16:31.746795", "stderr": "Code: 210. DB::NetException: Connection refused (localhost:9000). (NETWORK_ERROR)", "stderr_lines": ["Code: 210. DB::NetException: Connection refused (localhost:9000). (NETWORK_ERROR)"], "stdout": "", "stdout_lines": []}

```
Добавил блок:  
```
name: Start clickhouse-server
      become: true
      ansible.builtin.service:
        name: clickhouse-server
        state: started
```
![Task_7_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.2_t7_1.png) 
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.  
![Task_8_output](https://github.com/le0lex/devops-netology/blob/main/screen/HW8.2_t8_1.png)
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.  
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.  
[фиксирующий коммит](https://github.com/le0lex/devops-netology/tree/main/ansible/playbook_8.2_2)

---

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

[All_task_workflow](https://github.com/le0lex/devops-netology/blob/main/All_task_workflow.xml)    
[BUG_workflow](https://github.com/le0lex/devops-netology/blob/main/BUG_workflow.xml) 


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








