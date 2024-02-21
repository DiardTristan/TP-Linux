# TP 4 

## Partie 1 : Partitionnement du serveur de stockage

#### 🌞 Partitionner le disque à l'aide de LVM

``` bash
[tristan@storage ~]$ sudo pvcreate /dev/sdb
[sudo] password for tristan:
  Physical volume "/dev/sdb" successfully created.
  [tristan@storage ~]$ sudo pvcreate /dev/sdc
  Physical volume "/dev/sdc" successfully created.
```

```
[tristan@storage ~]$ sudo vgcreate storage sdb
  No device found for sdb.
[tristan@storage ~]$ sudo vgcreate storage /dev/sdb /dev/sdc
  Volume group "storage" successfully created
[tristan@storage ~]$
```

``` bash
[tristan@storage ~]$ sudo lvcreate -L 4000 storage -n storage
  Logical volume "storage" created.
```

#### 🌞 Formater la partition

``` bash
[tristan@storage ~]$ sudo mkfs -t ext4 /dev/storage/storage
[sudo] password for tristan:
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 1024000 4k blocks and 256000 inodes
Filesystem UUID: be40061e-6cca-4e6b-9512-b889ff76b220
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done
```


#### 🌞 Monter la partition

``` bash
[tristan@storage ~]$ sudo mkdir /mnt/storage
[tristan@storage ~]$ mount storage /m
[tristan@storage ~]$ sudo mount /dev/storage/storage /mnt/storage/
```

``` bash
[tristan@storage ~]$ df -h | grep "storage"
/dev/mapper/storage-storage  3.8G   24K  3.6G   1% /mnt/storage
```

```bash
[tristan@storage ~]$ sudo nano /etc/fstab
```

```
[tristan@storage ~]$ sudo umount /mnt/storage/
[tristan@storage ~]$ sudo mount -av
/                        : ignored
/boot                    : already mounted
none                     : ignored
mount: /mnt/storage does not contain SELinux labels.
       You just mounted a file system that supports labels which does not
       contain labels, onto an SELinux box. It is likely that confined
       applications will generate AVC messages and not be allowed access to
       this file system.  For more details see restorecon(8) and mount(8).
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
/mnt/storage             : successfully mounted
```

## Partie 2 : Serveur de partage de fichiers

#### 🌞 Donnez les commandes réalisées sur le serveur NFS storage.tp4.linux :

##### Le ptit Cat MIAOOOOWWWWWW : 

```bash
[tristan@storage site_web_1]$ cat /etc/exports
/storage/site_web_1     10.2.1.11(rw,sync,no_subtree_check)
/storage/site_web_2     10.2.1.11(rw,sync,no_subtree_check)
```

```bash
[tristan@storage ~]$ sudo mkdir -p /storage/site_web_1
[sudo] password for tristan:
[tristan@storage ~]$ sudo mkdir -p /storage/site_web_2
```

```bash
[tristan@storage site_web_1]$ sudo dnf install nfs-utils
```

```bash
sudo nano /etc/exports
```

```bash
[tristan@storage site_web_1]$ sudo systemctl enable nfs-server
```

```bash
[tristan@storage site_web_1]$ sudo systemctl start nfs-server
```

```bash
[tristan@storage site_web_1]$ sudo firewall-cmd --permanent --list-all | grep services
```

```bash
[tristan@storage site_web_1]$ sudo firewall-cmd --permanent --add-service=nfs
```

```bash
[tristan@storage site_web_1]$ sudo firewall-cmd --permanent --add-service=mountd
```

```bash
[tristan@storage site_web_1]$ sudo firewall-cmd --permanent --add-service=rpc-bind
```

```bash
[tristan@storage site_web_1]$ sudo firewall-cmd --reload
```

```bash
sudo touch /storage/site_web_1/ben
```

```
[tristan@storage site_web_1]$ ls
ben
```

#### 🌞 Donnez les commandes réalisées sur le client NFS web.tp4.linux

##### Le ptit Cat MIAOOOOWWWWWW : 

```bash
[tristan@web site_web_1]$ cat /etc/fstab | grep "storage"
10.2.1.12:/storage/site_web_1   /var/www/site_web_1     nfs auto,nofail,noatime,noclock,intr,tcp,axtimeo=1800 0 0
10.2.1.12:/storage/site_web_2   /var/www/site_web_2     nfs auto,nofail,noatime,noclock,intr,tcp,actimeo=1800 0 0
```

```bash
[tristan@web site_web_1]$ sudo dnf install nfs-utils
```

```bash
[tristan@web site_web_1]$ sudo mkdir -p /var/www/site_web_1/

```

```bash
[tristan@web site_web_1]$ sudo mkdir -p /var/www/site_web_2/
```

```bash
[tristan@web site_web_1]$ sudo mount 10.2.1.12:/storage/site_web_1 /var/www/site_web_1
```

```bash
[tristan@web site_web_1]$ sudo mount 10.2.1.12:/storage/site_web_2 /var/www/site_web_2
```

```bash
[tristan@web site_web_1]$ df -h | grep storage
10.2.1.12:/storage/site_web_1   17G  1.4G   16G   9% /var/www/site_web_1
10.2.1.12:/storage/site_web_2   17G  1.4G   16G   9% /var/www/site_web_2
```

```bash
[tristan@web site_web_1]$ ls
ben
```

```bash
[tristan@web site_web_1]$ sudo nano /etc/fstab
```

## Partie 3 : Serveur web

### 2. Install

#### 🌞 Installez NGINX

```bash
[tristan@web site_web_1]$ sudo dnf install nginx
[sudo] password for tristan:
Last metadata expiration check: 3:09:17 ago on Mon 19 Feb 2024 11:49:34 AM CET.
Package nginx-1:1.20.1-14.el9_2.1.x86_64 is already installed.
Dependencies resolved.
Nothing to do.
Complete!
```

### 3. Analyse

#### 🌞 Analysez le service NGINX

- avec une commande ps, déterminer sous quel utilisateur tourne le processus du service NGINX

```bash
[tristan@web site_web_1]$ ps -ef | grep nginx
root       13631       1  0 14:59 ?        00:00:00 nginx: master process /usr/sbin/nginx
💡💡nginx💡💡      13632   13631  0 14:59 ?        00:00:00 nginx: worker process
tristan    13642    1358  0 15:00 pts/0    00:00:00 grep --color=auto nginx
```

- avec une commande ss, déterminer derrière quel port écoute actuellement le serveur web

```bash
[tristan@web site_web_1]$ sudo ss -alnpt | grep nginx
LISTEN 0      511          0.0.0.0:💡💡80💡💡        0.0.0.0:*    users:(("nginx",pid=13632,fd=6),("nginx",pid=13631,fd=6))
LISTEN 0      511             [::]:💡💡80💡💡           [::]:*    users:(("nginx",pid=13632,fd=7),("nginx",pid=13631,fd=7))
```

- en regardant la conf, déterminer dans quel dossier se trouve la racine web

```bash
[tristan@web site_web_1]$ sudo cat /etc/nginx/nginx.conf | grep root
        root         💡💡/usr/share/nginx/html💡💡;
        root         💡💡/usr/share/nginx/html💡💡;
```

- inspectez les fichiers de la racine web, et vérifier qu'ils sont bien accessibles en lecture par l'utilisateur qui lance le processus

```bash
[tristan@web site_web_1]$ ls -al /usr/share/nginx/html
total 12
drwxr-xr-x. 3 root root  143 Jan 23 09:51 .
```

### 4. Visite du service web

#### 🌞 Configurez le firewall pour autoriser le trafic vers le service NGINX

```bash
[tristan@web site_web_1]$ sudo firewall-cmd --add-port=80/tcp --permanent
[sudo] password for tristan:
Warning: ALREADY_ENABLED: 80:tcp
success
```

#### 🌞 Accéder au site web

```
[tristan@storage ~]$ curl http://10.2.1.11 | tail -n 10
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7620  100  7620    0     0  1063k      0 --:--:-- --:--:-- --:--:-- 1240k
      </div>
      </div>

      <footer class="col-sm-12">
      <a href="https://apache.org">Apache&trade;</a> is a registered trademark of <a href="https://apache.org">the Apache Software Foundation</a> in the United States and/or other countries.<br />
      <a href="https://nginx.org">NGINX&trade;</a> is a registered trademark of <a href="https://">F5 Networks, Inc.</a>.
      </footer>

  </body>
</html>
```

#### 🌞 Vérifier les logs d'accès

```bash
[tristan@web site_web_1]$ sudo cat /var/log/nginx/access.log | tail -n 3
10.2.1.12 - - [19/Feb/2024:15:33:13 +0100] "GET / HTTP/1.1" 200 7620 "-" "curl/7.76.1" "-"
10.2.1.12 - - [19/Feb/2024:15:33:24 +0100] "GET / HTTP/1.1" 200 7620 "-" "curl/7.76.1" "-"
10.2.1.12 - - [19/Feb/2024:15:33:27 +0100] "GET / HTTP/1.1" 200 7620 "-" "curl/7.76.1" "-"
```

### 5. Modif de la conf du serveur web

```bash
[tristan@web site_web_1]$ sudo nano  /etc/nginx/nginx.conf
[tristan@web site_web_1]$ sudo firewall-cmd --add-port=8080/tcp --permanent
success
[tristan@web site_web_1]$ sudo firewall-cmd --remove-port=80/tcp --permanent
success
```

```bash
[tristan@web site_web_1]$ sudo ss -alnpt | grep nginx
LISTEN 0      511          0.0.0.0:8080      0.0.0.0:*    users:(("nginx",pid=13819,fd=6),("nginx",pid=13818,fd=6))
LISTEN 0      511             [::]:8080         [::]:*    users:(("nginx",pid=13819,fd=7),("nginx",pid=13818,fd=7))
```

```bash
[tristan@web site_web_1]$ curl http://10.2.1.11:8080 | tail -n 3
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7620  100  7620    0     0  1488k      0 --:--:-- --:--:-- --:--:-- 1860k

  </body>
</html>
```

#### 🌞 Changer l'utilisateur qui lance le service

```bash
[tristan@web site_web_1]$ sudo useradd web
```

```bash
[tristan@web site_web_1]$ sudo passwd web
```

```bash
[tristan@web site_web_1]$ sudo cat /etc/nginx/nginx.conf | grep user
user web;
```

```bash
[tristan@web site_web_1]$ sudo systemctl restart nginx
```

#### 🌞 Changer l'emplacement de la racine Web

```bash
[tristan@web site_web_1]$ sudo ps -ef |grep web
tristan    13776   13714  0 16:02 pts/0    00:00:00 grep --color=auto web
```

```bash
[tristano@web site_web_1]$ curl http://10.2.1.11:8080
<h1>Ben</h1>
```

### 6. Deux sites web sur un seul serveur

#### 🌞 Repérez dans le fichier de conf

```bash
[tristan@web site_web_1]$ sudo cat /etc/nginx/nginx.conf | grep conf.d
    # Load modular configuration files from the /etc/nginx/conf.d directory.
    include /etc/nginx/conf.d/*.conf;
```

#### 🌞 Créez le fichier de configuration pour le deuxième site

```bash
[tristan@web site_web_1]$ [hugo@web site_web_2]$ cat /etc/nginx/conf.d/site_web_2.conf
server {
        listen       8888;
        listen       [::]:8888;
        server_name  _;
        root         /var/www/site_web_2/;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }
```

```bash 
sudo firewall-cmd --list-all | grep ports
  ports: 8080/tcp 8888/tcp
```

#### 🌞 Prouvez que les deux sites sont disponibles

```bash
PS C:\Users\trist> curl http://10.5.1.101:8080
Content           : <h1>Ben</h1>
```


```bash
PS C:\Users\trist> curl http://10.5.1.101:8888
Content           : <h1>Ben2</h1>
```