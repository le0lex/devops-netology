3.9. Элементы безопасности информационных систем




3.Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=CompanyX/OU=Org/CN=CompanyX.net"
mkdir /var/www/CompanyX.net
vim /var/www/CompanyX.net/index.html

root@leolex-VirtualBox:/var/www/127.0.0.1# vim /etc/apache2/sites-available/CompanyX.conf 
root@leolex-VirtualBox:/var/www/127.0.0.1# mkdir /var/www/CompanyX.net
root@leolex-VirtualBox:/var/www/127.0.0.1# vim /var/www/CompanyX.net/index.html
root@leolex-VirtualBox:/var/www/CompanyX.net# sudo a2ensite CompanyX.net.conf
Site CompanyX.net already enabled
root@leolex-VirtualBox:/var/www/CompanyX.net# apache2ctl configtest
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
Syntax OK
root@leolex-VirtualBox:/var/www/CompanyX.net# systemctl reload apache2

root@leolex-VirtualBox:/var/www/CompanyX.net# cat /etc/apache2/sites-available/CompanyX.net.conf 
<VirtualHost *:443>
	ServerName CompanyX.net
	DocumentRoot /var/www/CompanyX.net

	SSLEngine on
	SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
	SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</Virtualhost>




4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

root@leolex-VirtualBox:/var/www/CompanyX.net/testssl.sh# ./testssl.sh -U --sneaky https://arenda-car.ru

###########################################################
    testssl.sh       3.1dev from https://testssl.sh/dev/
    (d931eb4 2022-05-14 13:57:46)

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.0.2-chacha (1.0.2k-dev)" [~183 ciphers]
 on leolex-VirtualBox:./bin/openssl.Linux.x86_64
 (built: "Jan 18 17:12:17 2019", platform: "linux-x86_64")


 Start 2022-05-22 20:26:24        -->> 82.202.222.219:443 (arenda-car.ru) <<--

 rDNS (82.202.222.219):  --
 Service detected:       HTTP


 Testing vulnerabilities 

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
 ROBOT                                     Server does not support any cipher suites that use RSA key transport
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
 BREACH (CVE-2013-3587)                    potentially NOT ok, "gzip" HTTP compression detected. - only supplied "/" tested
                                           Can be ignored for static pages or if no secrets in the page
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
 TLS_FALLBACK_SCSV (RFC 7507)              Downgrade attack prevention supported (OK)
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services, see
                                           https://search.censys.io/search?resource=hosts&virtual_hosts=INCLUDE&q=BC2FD1D1F7225469D1D67E52FDBC26680BDE7C92CD2EEEAD382B46994E529158
 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
 BEAST (CVE-2011-3389)                     TLS1: ECDHE-RSA-AES128-SHA 
                                           VULNERABLE -- but also supports higher protocols  TLSv1.1 TLSv1.2 (likely mitigated)
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


 Done 2022-05-22 20:26:44 [  23s] -->> 82.202.222.219:443 (arenda-car.ru) <<--




5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.

SSHD сервер установлен и работает
root@leolex-VirtualBox:/var/www/CompanyX.net/testssl.sh# systemctl status sshd.service
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2022-05-09 17:28:30 MSK; 1 weeks 6 days ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 721 (sshd)
      Tasks: 1 (limit: 4628)
     Memory: 2.2M
     CGroup: /system.slice/ssh.service
             └─721 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

мая 09 17:28:30 leolex-VirtualBox systemd[1]: Starting OpenBSD Secure Shell server...
мая 09 17:28:30 leolex-VirtualBox sshd[721]: Server listening on 0.0.0.0 port 22.
мая 09 17:28:30 leolex-VirtualBox sshd[721]: Server listening on :: port 22.
мая 09 17:28:30 leolex-VirtualBox systemd[1]: Started OpenBSD Secure Shell server.

Сгенерируем ключ:
root@leolex-VirtualBox:/home/leolex/.ssh# ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): id_rsa
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in id_rsa
Your public key has been saved in id_rsa.pub
The key fingerprint is:
SHA256:QcHn2/feslWOTKwpJJUsMlfeuhNVdaBbMB0Tt6yzzUI root@leolex-VirtualBox
The key's randomart image is:
+---[RSA 3072]----+
|       .o.. o.*=+|
|       ..+.o =ooo|
|      o +o= + .o |
|       + +.o +.  |
|        S +o.Eo .|
|         o.oo=*o.|
|          + o+o+o|
|           o  o.o|
|              .+o|
+----[SHA256]-----+
root@leolex-VirtualBox:/home/leolex/.ssh# ls -la
total 28
drwx------  2 leolex leolex 4096 мая 22 20:32 .
drwxr-xr-x 20 leolex leolex 4096 мая  9 17:28 ..
-rw-------  1 root   root   2655 мая 22 20:32 id_rsa
-rw-r--r--  1 root   root    576 мая 22 20:32 id_rsa.pub
-rw-r--r--  1 leolex leolex 2212 апр 25 13:57 known_hosts
-rw-------  1 leolex leolex 2655 апр  8 16:06 yes
-rw-r--r--  1 leolex leolex  578 апр  8 16:06 yes.pub

root@leolex-VirtualBox:/home/leolex/.ssh# scp id_rsa.pub leolex@10.0.2.20://home/leolex/.ssh/
The authenticity of host '10.0.2.20 (10.0.2.20)' can't be established.
ECDSA key fingerprint is SHA256:4Fwm6Ob8yJFBsXNfHOB+Y3TImUI8oE3gXSFDPj8IMKY.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.0.2.20' (ECDSA) to the list of known hosts.
leolex@10.0.2.20's password: 
id_rsa.pub                                                      100%  576   177.4KB/s   00:00    
rleolex@leolex-VirtualBox:~/Desktop$ ssh -i ~/.ssh/id_rsa.pub leolex@10.0.2.20
The authenticity of host '10.0.2.20 (10.0.2.20)' can't be established.
ECDSA key fingerprint is SHA256:4Fwm6Ob8yJFBsXNfHOB+Y3TImUI8oE3gXSFDPj8IMKY.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.0.2.20' (ECDSA) to the list of known hosts.
leolex@10.0.2.20's password: 
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-41-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

170 updates can be applied immediately.
119 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings

Your Hardware Enablement Stack (HWE) is supported until April 2025.
Last login: Sun May 22 22:16:45 2022 from 10.0.2.20




6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

leolex@leolex-VirtualBox:~/.ssh$ sudo cat config
Host VB1
	Hostname 10.0.2.20
	IdentityFile /home/leolex/.ssh/new_rsa
	User root
leolex@leolex-VirtualBox:~/.ssh$ ssh VB1
leolex@vb1's password: 
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-41-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

170 updates can be applied immediately.
119 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings

Your Hardware Enablement Stack (HWE) is supported until April 2025.
Last login: Sun May 22 22:52:17 2022 from 10.0.2.15

