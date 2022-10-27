    cd ~
    cd /etc/ansible/  && rm -rf /etc/ansible/*
    git clone https://github.com/pedroAkiraDanno/auto5
    cd /etc/ansible/auto5/ ;     git checkout develop ; cd ..

    cd /etc/ansible/auto5/srv/ansible24/ ; mv *  /etc/ansible/
    cd /etc/ansible/  && rm -rf auto5/





    #pedroAkiraDanno/pg_faker
    #ROOT
    cd ~
    #cd /etc/ansible/  && rm -rf /etc/ansible/*
    cd /etc/ansible/
    git clone https://github.com/pedroAkiraDanno/pg_faker.git

    cd /etc/ansible/pg_faker/ ; mv  *  /etc/ansible/
    cd /etc/ansible/  && rm -rf pg_faker/

    $ ansible-playbook setup.yml --extra-vars "database_name=my_database"
