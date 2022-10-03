




cd ~
rm -fr auto5
git clone https://github.com/pedroAkiraDanno/auto5
cd  /root/auto5/srv/ansible24/ ; mv ssh-key-2022-01-19.key*  /root/.ssh/
cd ~  ; rm -fr auto5
chmod 400 /root/.ssh/ssh-key-2022-01-19.key*
ls -lath /root/.ssh/ssh-key-2022-01-19.key*


