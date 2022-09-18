    cd ~
    cd /etc/ansible/  && rm -rf /etc/ansible/*
    git clone https://github.com/pedroAkiraDanno/auto5
    cd /etc/ansible/auto5/ ;     git checkout develop ; cd ..

    cd /etc/ansible/auto5/srv/ansible24/ ; mv *  /etc/ansible/
    cd /etc/ansible/  && rm -rf auto5/
