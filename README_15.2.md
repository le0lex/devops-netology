# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»  



---
## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.
4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

## Ответ

План, и другие файлы для terraform.  
[main.tf](https://github.com/le0lex/devops-netology/blob/8fe15dfed0a676a6f6a9ca388786bd1140f0d80c/HW_15.2/main.tf)  
[versions.tf](https://github.com/le0lex/devops-netology/blob/8fe15dfed0a676a6f6a9ca388786bd1140f0d80c/HW_15.2/versions.tf)  
[vars.tf](https://github.com/le0lex/devops-netology/blob/9e5420f26319f85fbcac87e3c5e86fa565c73c55/HW_15.2/vars.tf)  
[picture.png](https://github.com/le0lex/devops-netology/blob/8fe15dfed0a676a6f6a9ca388786bd1140f0d80c/HW_15.2/picture.png)  
  
План отрабатывает успешно:  
![HW_15.2_001](https://github.com/le0lex/devops-netology/blob/8fe15dfed0a676a6f6a9ca388786bd1140f0d80c/screen/HW_15.2_001.png)  
  
По адресу балансировщика доступна страница с картинкой:  
![HW_15.2_002](https://github.com/le0lex/devops-netology/blob/8fe15dfed0a676a6f6a9ca388786bd1140f0d80c/screen/HW_15.2_002.png)  
  
![HW_15.2_003](https://github.com/le0lex/devops-netology/blob/8fe15dfed0a676a6f6a9ca388786bd1140f0d80c/screen/HW_15.2_003.png)  
  
Удаляю 2 VM:  
![HW_15.2_004](https://github.com/le0lex/devops-netology/blob/8fe15dfed0a676a6f6a9ca388786bd1140f0d80c/screen/HW_15.2_004.png)  
  
По адресу балансировщика всё еще доступна страница с картинкой: 
![HW_15.2_005](https://github.com/le0lex/devops-netology/blob/8fe15dfed0a676a6f6a9ca388786bd1140f0d80c/screen/HW_15.2_005.png)  
  
VM пересоздаются:  
![HW_15.2_006](https://github.com/le0lex/devops-netology/blob/8fe15dfed0a676a6f6a9ca388786bd1140f0d80c/screen/HW_15.2_006.png)  
  
----