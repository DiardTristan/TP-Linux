# TP 3

## I. Service SSH

### 1. Analyse du service

#### 🌞 S'assurer que le service sshd est démarré

```
[tristan@localhost ~]$ systemctl status sshd
● sshd.service - OpenSSH server daemon
     Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; preset: enabled)
     Active: active (running) since Mon 2024-01-29 10:11:52 CET; 1h 12min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 689 (sshd)
      Tasks: 1 (limit: 4673)
     Memory: 5.6M
        CPU: 758ms
     CGroup: /system.slice/sshd.service
             └─689 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
```

#### 🌞 Analyser les processus liés au service SSH

```[tristan@localhost ~]$ ps -ef | grep sshd
root         689       1  0 10:11 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root        2138     689  0 11:11 ?        00:00:00 sshd: tristan [priv]
tristan     2142    2138  0 11:11 ?        00:00:00 sshd: tristan@pts/0
tristan     2200    2143  0 11:28 pts/0    00:00:00 grep --color=auto sshd
```

#### 🌞 Déterminer le port sur lequel écoute le service SSH

```
[tristan@localhost ~]$ sudo ss -alnpt | grep sshd
[sudo] password for tristan:
LISTEN 0      128          0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=689,fd=3))
LISTEN 0      128             [::]:22           [::]:*    users:(("sshd",pid=689,fd=4))
```

#### 🌞 Consulter les logs du service SSH


```
[tristan@localhost ~]$ sudo cat /var/log/secure | grep sshd | tail -n 10
Jan 29 10:55:59 localhost sshd[1414]: pam_unix(sshd:session): session closed for user tristan
Jan 29 11:01:07 localhost sshd[1447]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=10.2.1.1  user=tristan
Jan 29 11:01:09 localhost sshd[1447]: Failed password for tristan from 10.2.1.1 port 49997 ssh2
Jan 29 11:01:12 localhost sshd[1447]: Accepted password for tristan from 10.2.1.1 port 49997 ssh2
Jan 29 11:01:12 localhost sshd[1447]: pam_unix(sshd:session): session opened for user tristan(uid=1001) by (uid=0)
Jan 29 11:10:37 localhost sshd[1469]: Received disconnect from 10.2.1.1 port 49997:11: disconnected by user
Jan 29 11:10:37 localhost sshd[1469]: Disconnected from user tristan 10.2.1.1 port 49997
Jan 29 11:10:37 localhost sshd[1447]: pam_unix(sshd:session): session closed for user tristan
Jan 29 11:11:18 localhost sshd[2138]: Accepted password for tristan from 10.2.1.1 port 50139 ssh2
Jan 29 11:11:18 localhost sshd[2138]: pam_unix(sshd:session): session opened for user tristan(uid=1001) by (uid=0)
```

#### 🌞 Identifier le fichier de configuration du serveur SSH

```/etc/ssh/ssh_config```

#### 🌞 Modifier le fichier de conf

```
[tristan@localhost ~]$ sudo cat /etc/ssh/ssh_config | grep Port
#   Port 14239
```

```
[tristan@localhost ~]$ sudo firewall-cmd --remove-port=22/tcp --permanent
success
```

```
[tristan@localhost ~]$ sudo firewall-cmd --add-port=14239/tcp --permanent
success
```

```sudo firewall-cmd --reload```

```bash
[tristan@localhost ~]$ sudo firewall-cmd --list-all | grep port
  ports: 14239/tcp
  forward-ports:
  source-ports:
```

#### 🌞 Effectuer une connexion SSH sur le nouveau port

```bash
$ sudo systemctl restart sshd
```

jezo ijoi ezfoiz jfoi f `ls` dhhdhd 

## II. Service HTTP

#### 🌞 Installer le serveur NGINX

``` bash
dnf search nginx
```

``` bash
sudo dnf install nginx
```

#### 🌞 Démarrer le service NGINX

```
sudo systemctl start nginx
```

#### 🌞 Déterminer sur quel port tourne NGINX

```bash
[tristan@localhost ~]$ sudo ss -alnpt | grep nginx
LISTEN 0      511          0.0.0.0:80        0.0.0.0:*    users:(("nginx",pid=1394,fd=6),("nginx",pid=1393,fd=6))
LISTEN 0      511             [::]:80           [::]:*    users:(("nginx",pid=1394,fd=7),("nginx",pid=1393,fd=7))
```

Le port de NGINX est donc le port 80

```bash
[tristan@localhost ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
[sudo] password for tristan:
success
[tristan@localhost ~]$ sudo firewall-cmd --reload
success
```

#### 🌞 Déterminer les processus liés au service NGINX

Les processus liés au service NGINX sont le 511

#### 🌞 Déterminer le nom de l'utilisateur qui lance NGINX

```bash
[tristan@localhost ~]$ ps -ef | grep nginx
root        1393       1  0 10:42 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx       1394    1393  0 10:42 ?        00:00:00 nginx: worker process
tristan     1454    1300  0 11:14 pts/0    00:00:00 grep --color=auto nginx
```


#### 🌞 Test !

```bash
[tristan@localhost ~]$ curl http://10.2.1.11/ | head -n 7
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
100  7620  100  7620    0     0   620k      0 --:--:-- --:--:-- --:--:--  620k
```

#### 🌞 Déterminer le path du fichier de configuration de NGINX

```bash
[tristan@localhost ~]$ ls -al /etc/nginx/nginx.conf
-rw-r--r--. 1 root root 2334 Oct 16 20:00 /etc/nginx/nginx.conf
```

#### 🌞 Trouver dans le fichier de conf


```bash
[tristan@localhost ~]$ cat /etc/nginx/nginx.conf | grep "server {" -A 25
    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

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
[tristan@localhost ~]$ cat /etc/nginx/nginx.conf | grep include
include /usr/share/nginx/modules/*.conf;
```

#### 🌞 Créer un site web


```
[tristan@localhost ~]$ mkdir /var/www/ tp3_linux
```

```
sudo nano index.html
```

#### 🌞 Gérer les permissions

```
sudo chown -R nginx:nginx /var/www/index.html
```

#### 🌞 Adapter la conf NGINX

```
sudo systemctl restart nginx
```

```
[tristan@localhost ~]$ cat index.conf
server {
  # le port choisi devra être obtenu avec un 'echo $RANDOM' là encore
  listen 5598;

  root /var/www/tp3_linux;
}
```

```
[tristan@localhost ~]$ sudo firewall-cmd --add-port=5598/tcp --permanent
success
[tristan@localhost ~]$ sudo firewall-cmd --reload
```

