# TP 5

```bash
bash-5.1$ . idcard.sh
Machine name : storage
OS : Rocky Linux and kernel version is 9.2 (Blue Onyx)
IP : 10.2.1.12/24
RAM : 771Mi memory available on  total memory
Disk : 1798392 space left
Top 5 processes by RAM usage :
 - /home/tristan/.vscode-server/bin/863d2581ecda6849923a2118d93a088b0745d9d6/node  : 13.3%
 - /home/tristan/.vscode-server/bin/863d2581ecda6849923a2118d93a088b0745d9d6/node  : 11.1%
 - /home/tristan/.vscode-server/bin/863d2581ecda6849923a2118d93a088b0745d9d6/node  : 8.3%
 - /home/tristan/.vscode-server/bin/863d2581ecda6849923a2118d93a088b0745d9d6/node  : 7.6%
 - /usr/bin/python3  : 5.3%
Listening ports :
Failed to open cgroup2 by ID
Failed to open cgroup2 by ID
Failed to open cgroup2 by ID
Failed to open cgroup2 by ID
Failed to open cgroup2 by ID
Failed to open cgroup2 by ID
      - 36097 udp : sk:1
      - 41798 udp : cgroup:unreachable:bbc
      - 20048 udp : nfs-mountd
      - 111 udp : rpcbind
      - 659 udp : rpc-statd
      -   : sk:6
      -   : cgroup:unreachable:bbc
      -   : nfs-mountd
      -   : rpcbind
      - 33551 tcp : cgroup:unreachable:bbc
      - 40311 tcp : sk:b
      - 48089 tcp : sk:c
      - 22 tcp : sshd
      - 2049 tcp : cgroup:unreachable:bbc
      - 111 tcp : rpcbind
      - 20048 tcp : nfs-mountd
      -   : sk:11
      -   : cgroup:unreachable:bbc
      -   : sshd
      -   : cgroup:unreachable:bbc
      -   : rpcbind
      -   : nfs-mountd
PATH directories :
 /home/tristan/.vscode-server/bin/863d2581ecda6849923a2118d93a088b0745d9d6/bin/remote-cli

 /usr/local/bin

 /usr/bin

 /usr/local/sbin

 /usr/sbin

Here is your random cat (jpg file) : https://cdn2.thecatapi.com/images/d8i.jpg ```

## 2. Youtube Video Downloader

```bash
[tristan@storage yt]$ sudo -u yt ./yt.sh 'https://www.youtube.com/watch?v=xi02wD8GLKQ'
La vidéo est déjà téléchargée
[tristan@storage yt]$ sudo -u yt ./yt.sh 'https://www.youtube.com/watch?v=kQeBeCmNIvU'
[youtube] kQeBeCmNIvU: Downloading webpage
[download] Destination: download/dr_nefario_tries_roblox/dr_nefario_tries_roblox.mp4
[download] 100% of 1.62MiB in 00:01
Video : https://www.youtube.com/watch?v=kQeBeCmNIvU
Path  : /dr_nefario_tries_roblox/dr_nefario_tries_roblox.mp4
```


```bash
[tristan@storage yt]$ sudo systemctl status yt
● yt.service - Youtube Video Downloader
     Loaded: loaded (/etc/systemd/system/yt.service; disabled; preset: disabled)
     Active: active (running) since Tue 2024-03-05 13:11:06 CET; 2min 39s ago
   Main PID: 10920 (yt-v2.sh)
      Tasks: 2 (limit: 4673)
     Memory: 6.1M
        CPU: 1min 42.128s
     CGroup: /system.slice/yt.service
             ├─10920 /bin/bash /srv/yt/yt-v2.sh
             └─11040 sleep 1

Mar 05 13:11:51 storage yt-v2.sh[10943]: [youtube] CySAWSIAsNY: Downloading webpage
Mar 05 13:12:09 storage yt-v2.sh[10943]: [download] Destination: /srv/yt/download/gru_time_travels/gr>
Mar 05 13:12:10 storage yt-v2.sh[10943]: [677B blob data]
Mar 05 13:12:32 storage yt-v2.sh[10920]: Video : https://www.youtube.com/watch?v=CySAWSIAsNY
Mar 05 13:12:32 storage yt-v2.sh[10920]: Path  : /gru_time_travels/gru_time_travels.mp4
Mar 05 13:13:01 storage yt-v2.sh[10974]: [youtube] sEhXU7cZf4c: Downloading webpage
Mar 05 13:13:20 storage yt-v2.sh[10974]: [download] Destination: /srv/yt/download/gru_becomes_small/g>
Mar 05 13:13:21 storage yt-v2.sh[10974]: [678B blob data]
Mar 05 13:13:38 storage yt-v2.sh[10920]: Video : https://www.youtube.com/watch?v=sEhXU7cZf4c
Mar 05 13:13:38 storage yt-v2.sh[10920]: Path  : /gru_becomes_small/gru_becomes_small.mp4
```


#### 🌞 Le journalctl :

```bash
Mar 05 13:11:06 storage systemd[1]: Started Youtube Video Downloader.
░░ Subject: A start job for unit yt.service has finished successfully
░░ Defined-By: systemd
░░ Support: https://access.redhat.com/support
░░
░░ A start job for unit yt.service has finished successfully.
░░
░░ The job identifier is 3887.
Mar 05 13:11:21 storage yt-v2.sh[10920]: La vidéo est déjà téléchargée
Mar 05 13:11:51 storage yt-v2.sh[10943]: [youtube] CySAWSIAsNY: Downloading webpage
Mar 05 13:12:09 storage yt-v2.sh[10943]: [download] Destination: /srv/yt/download/gru_time_travels/gr>
Mar 05 13:12:10 storage yt-v2.sh[10943]: [677B blob data]
Mar 05 13:12:32 storage yt-v2.sh[10920]: Video : https://www.youtube.com/watch?v=CySAWSIAsNY
Mar 05 13:12:32 storage yt-v2.sh[10920]: Path  : /gru_time_travels/gru_time_travels.mp4
Mar 05 13:13:01 storage yt-v2.sh[10974]: [youtube] sEhXU7cZf4c: Downloading webpage
Mar 05 13:13:20 storage yt-v2.sh[10974]: [download] Destination: /srv/yt/download/gru_becomes_small/g>
Mar 05 13:13:21 storage yt-v2.sh[10974]: [678B blob data]
Mar 05 13:13:38 storage yt-v2.sh[10920]: Video : https://www.youtube.com/watch?v=sEhXU7cZf4c
Mar 05 13:13:38 storage yt-v2.sh[10920]: Path  : /gru_becomes_small/gru_becomes_small.mp4
```