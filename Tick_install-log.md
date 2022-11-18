leolex@leolex-VirtualBox:~/SW/pycharm-community-2021.3.3/my_git01/HW_10.2/sandbox$ sudo ./sandbox up
Using latest, stable releases
Spinning up Docker Images...
If this is your first time starting sandbox this might take a minute...
Creating network "sandbox_default" with the default driver
Building influxdb
Sending build context to Docker daemon  4.096kB
Step 1/2 : ARG INFLUXDB_TAG
Step 2/2 : FROM influxdb:$INFLUXDB_TAG
1.8: Pulling from library/influxdb
a8ca11554fce: Pull complete 
e4e46864aba2: Pull complete 
c85a0be79bfb: Pull complete 
ef4db93e59de: Pull complete 
2c31834a2f75: Pull complete 
6e2b3307f4e3: Pull complete 
c90b3746a2a1: Pull complete 
dec26e29524b: Pull complete 
Digest: sha256:80e27a7af363c70597993003831703cf914105331dfa3f0268d4b2c42970e361
Status: Downloaded newer image for influxdb:1.8
 ---> 064158037146
Successfully built 064158037146
Successfully tagged influxdb:latest
Building telegraf
Sending build context to Docker daemon  4.096kB
Step 1/2 : ARG TELEGRAF_TAG
Step 2/2 : FROM telegraf:$TELEGRAF_TAG
latest: Pulling from library/telegraf
a8ca11554fce: Already exists 
e4e46864aba2: Already exists 
c85a0be79bfb: Already exists 
4e470c46ca22: Pull complete 
352e66d44593: Pull complete 
46b4a75a8c99: Pull complete 
f82440e40182: Pull complete 
Digest: sha256:89ad64fb54b836d6be94b8f6a80651cdc9fd74fa5843ceab3f459f0cf510addf
Status: Downloaded newer image for telegraf:latest
 ---> 2eec2876765c
Successfully built 2eec2876765c
Successfully tagged telegraf:latest
Building kapacitor
Sending build context to Docker daemon  4.096kB
Step 1/2 : ARG KAPACITOR_TAG
Step 2/2 : FROM kapacitor:$KAPACITOR_TAG
latest: Pulling from library/kapacitor
e96e057aae67: Pull complete 
9a586f3d84de: Pull complete 
5ac951de24f6: Pull complete 
4963b3f490e4: Pull complete 
3b00314ef588: Pull complete 
2819edb7c604: Pull complete 
369f0f8aa00c: Pull complete 
Digest: sha256:da5b8e7bf0af1926d5094be5b3211758fee6decdc2e522e8b6057f10ca509bf5
Status: Downloaded newer image for kapacitor:latest
 ---> c32bc2fab6d4
Successfully built c32bc2fab6d4
Successfully tagged kapacitor:latest
Building chronograf
Sending build context to Docker daemon  6.144kB
Step 1/4 : ARG CHRONOGRAF_TAG
Step 2/4 : FROM chronograf:$CHRONOGRAF_TAG
latest: Pulling from library/chronograf
a603fa5e3b41: Pull complete 
751b5fd79a26: Pull complete 
0c9face4f63f: Pull complete 
64f2dfb3de65: Pull complete 
bbb8a191c5aa: Pull complete 
8099be4e85dd: Pull complete 
Digest: sha256:fe561e1c1ffcd6942f5eab576ae67a264d2d799c5ea6c286346ec5ad17fb0a8f
Status: Downloaded newer image for chronograf:latest
 ---> aa22173565f1
Step 3/4 : ADD ./sandbox.src ./usr/share/chronograf/resources/
 ---> e235be3e548f
Step 4/4 : ADD ./sandbox-kapa.kap ./usr/share/chronograf/resources/
 ---> 90c9a3d34a02
Successfully built 90c9a3d34a02
Successfully tagged chrono_config:latest
Building documentation
Sending build context to Docker daemon  12.95MB
Step 1/6 : FROM alpine:3.12
3.12: Pulling from library/alpine
1b7ca6aea1dd: Pull complete 
Digest: sha256:c75ac27b49326926b803b9ed43bf088bc220d22556de1bc5f72d742c91398f69
Status: Downloaded newer image for alpine:3.12
 ---> 24c8ece58a1a
Step 2/6 : EXPOSE 3010:3000
 ---> Running in 8fd8df58822a
Removing intermediate container 8fd8df58822a
 ---> 0cf2fc6fad29
Step 3/6 : RUN mkdir -p /documentation
 ---> Running in bd9438fafb88
Removing intermediate container bd9438fafb88
 ---> b7ea3a2b44dc
Step 4/6 : COPY builds/documentation /documentation/
 ---> 8cdc0a33c1a9
Step 5/6 : COPY static/ /documentation/static
 ---> 393b4e7e33f6
Step 6/6 : CMD ["/documentation/documentation", "-filePath", "/documentation/"]
 ---> Running in 3ff446ed755a
Removing intermediate container 3ff446ed755a
 ---> 5b1d5070c8cb
Successfully built 5b1d5070c8cb
Successfully tagged sandbox_documentation:latest
Creating sandbox_influxdb_1      ... done
Creating sandbox_documentation_1 ... done
Creating sandbox_kapacitor_1     ... done
Creating sandbox_telegraf_1      ... done
Creating sandbox_chronograf_1    ... done
Opening tabs in browser...
Running Firefox as root in a regular user's session is not supported.  ($XAUTHORITY is /run/user/1000/gdm/Xauthority which is owned by leolex.)
[5390:5390:1118/130836.257319:ERROR:zygote_host_impl_linux.cc(90)] Running as root without --no-sandbox is not supported. See https://crbug.com/638180.
Running Firefox as root in a regular user's session is not supported.  ($XAUTHORITY is /run/user/1000/gdm/Xauthority which is owned by leolex.)
/usr/bin/xdg-open: 869: iceweasel: not found
/usr/bin/xdg-open: 869: seamonkey: not found
/usr/bin/xdg-open: 869: mozilla: not found
/usr/bin/xdg-open: 869: epiphany: not found
/usr/bin/xdg-open: 869: konqueror: not found
/usr/bin/xdg-open: 869: chromium: not found
/usr/bin/xdg-open: 869: chromium-browser: not found
[5427:5427:1118/130836.370842:ERROR:zygote_host_impl_linux.cc(90)] Running as root without --no-sandbox is not supported. See https://crbug.com/638180.
/usr/bin/xdg-open: 869: www-browser: not found
/usr/bin/xdg-open: 869: links2: not found
/usr/bin/xdg-open: 869: elinks: not found
/usr/bin/xdg-open: 869: links: not found
/usr/bin/xdg-open: 869: lynx: not found
/usr/bin/xdg-open: 869: w3m: not found
xdg-open: no method available for opening 'http://localhost:8888'
