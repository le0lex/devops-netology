# Домашнее задание к занятию «Организация сети»

### Подготовка к выполнению задания

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашнее задание по теме «Облачные провайдеры и синтаксис Terraform». Заранее выберите регион (в случае AWS) и зону.

---
### Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.

 - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
 - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
 - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.
3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
 - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
 - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

Resource Terraform для Yandex Cloud:

- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet).
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table).
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance).

---
  
### Ответ
  
План инфраструктуры и дополнительные файлы для Terraform:  
[main.tf](https://github.com/le0lex/devops-netology/blob/058c754ee327b822da0e0bcda120d0a0face0280/HW_15.1/main.tf)  
[vars.tf](https://github.com/le0lex/devops-netology/blob/058c754ee327b822da0e0bcda120d0a0face0280/HW_15.1/vars.tf)  
[versions.tf](https://github.com/le0lex/devops-netology/blob/058c754ee327b822da0e0bcda120d0a0face0280/HW_15.1/versions.tf)  
  
Используется зона ru-central1-b и облако netology  
![HW_15.1_t001.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_15.1_t001.png)
  
Применяем план  
![HW_15.1_t002.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_15.1_t002.png) 
  
Адреса VM:  
```
external_ip_address_nat = "158.160.11.79"
external_ip_address_public = "158.160.0.113"
internal_ip_address_private = "192.168.20.8"
```
  
Захожу на `public-instance`, используя инжектированный ключ    
![HW_15.1_t003.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_15.1_t003.png)  
Пинг внешнего ресурса в интернете успешен.  
   
Подключаюсь к `private-instance`, предварительно добавив на `public-instance` ключ id_rsa  
![HW_15.1_t004.png](https://github.com/le0lex/devops-netology/blob/main/screen/HW_15.1_t004.png)  
Пинг внешнего ресурса в интернете успешен. 
  
---





