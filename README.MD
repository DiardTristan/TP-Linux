# TP 2

## I. Fichier

### 1. Find Me !

#### 🌞 Trouver le chemin vers le répertoire personnel de votre utilisateur

```cd /home/toto```

#### 🌞 Trouver le chemin du fichier de logs SSH

```sudo cat /var/log/secure```

#### 🌞 Trouver le chemin du fichier de configuration du serveur SSH

```sudo cat /etc/ssh/ssh_config```

## II. Users

### 1. Nouveau user

#### 🌞 Créer un nouvel utilisateur

```sudo useradd -m -d /home/papier_alu marmotte```

```sudo passwd marmotte```

#### 🌞 Prouver que cet utilisateur a été créé

```sudo cat /etc/passwd | grep marmotte```

#### 🌞 Déterminer le hash du password de l'utilisateur marmotte

```sudo cat /etc/shadow | grep marmotte```

### 3. Connexion sur le nouvel utilisateur

#### 🌞 Tapez une commande pour vous déconnecter : fermer votre session utilisateur

```logout```

#### 🌞 Assurez-vous que vous pouvez vous connecter en tant que l'utilisateur marmotte

```
localhost login: marmotte
Password: chocolat
```

# Partie 2 : Programmes et paquets

## I. Programmes et processus

### 1. Run then kill

#### 🌞 Lancer un processus sleep

```sleep 1000```

```sudo ps -ef | grep sleep```

#### 🌞 Terminez le processus sleep depuis le deuxième terminal

```sudo kill 1344```

### 2. Tâche de fond

#### 🌞 Lancer un nouveau processus sleep, mais en tâche de fond

```sleep 1000 &```

#### 🌞 Visualisez la commande en tâche de fond

```jobs -p```

### 3. Find paths

#### 🌞 Trouver le chemin où est stocké le programme sleep

```ls -a /usr/bin/sleep```

#### 🌞 Tant qu'on est à chercher des chemins : trouver les chemins vers tous les fichiers qui s'appellent .bashrc

```
sudo find / -name ".bashrc

/etc/skel/.bashrc
/root/.bashrc
/home/it4/.bashrc
/home/tristan/.bashrc
/home/papier_alu/.bashrc
```
### 4. La variable PATH

#### 🌞 Vérifier que

```which sleep```

```which ssh```

```which ping```

## II. Paquets

#### 🌞 Installer le paquet firefox (git pour le coup)

```sudo dnf install git```

#### 🌞 Utiliser une commande pour lancer Firefox

```which "git"```

```"/usr/bin/git"```

#### 🌞 Installer le paquet nginx

```sudo dnf install nginx```

#### 🌞 Déterminer

- le chemin vers le dossier de logs de NGINX

```which nginx```

```chemin : /usr/sbin/nginx```

- le chemin vers le dossier qui contient la configuration de NGINX

```sudo find / -name "nginx*"```

```chemin : /etc/nginx/nginx.conf```

# Partie 3 : Poupée russe

#### 🌞 Récupérer le fichier meow

```sudo dnf install wget```

```wget gitlab.com/it4lik/b1-linux-2023/-/raw/master/tp/2/meow?inline=false```

```mv 'meow?inline=false meow.zip```

```sudo dnf install zip```

```unzip meow.zip```

```file meow```

```sudo dnf install bzip2```

```mv meow meow.bz2```

```bzip2 -d meow.bz2```

#### 🌞 Dans le dossier dawa/, déterminer le chemin vers

##### Le seul fichier de 15Mo 

```find dawa/ -size 15M```

##### le seul fichier qui est nommé cookie

```find -name cookie```

##### le seul fichier caché (un fichier caché c'est juste un fichier dont le nom commence par un .)

```find -name ".*"```

##### le seul fichier qui date de 2014

```find -newermt 2014-01-01 ! -newermt 2015-01-01```

##### le seul fichier qui a 5 dossiers-parents

```find -wholename "*/*/*/*/*/*/*"```