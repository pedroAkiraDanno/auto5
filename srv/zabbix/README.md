# Zabbix


**Zabbix** is an open-source software tool to monitor IT infrastructure such as networks, servers, virtual machines, and cloud services. Zabbix collects and displays basic metrics.



For more information look at our
docs located at [doc](https://github.com/pedroAkiraDanno/auto5/) and [wiki](https://github.com/pedroAkiraDanno/auto5/wiki) .



---



## NOTES/INFOS: 

**Long-term support (LTS)**  is a product lifecycle management policy in which a stable release of computer software is maintained for a longer period of time than the standard edition. The term is typically reserved for open-source software, where it describes a software edition that is supported for months or years longer than the software's standard edition.





## How works:

Exist 2 folder about automation in **postgresql** **ansible24** and **terraform** .


---



## Download and Install Zabbix


### Step 1 - click in link: 

    https://www.zabbix.com/download



### Step 2 -  a. Install Zabbix repository
    wget https://repo.zabbix.com/zabbix/6.2/ubuntu-arm64/pool/main/z/zabbix-release/zabbix-release_6.2-1+ubuntu22.04_all.deb
    dpkg -i zabbix-release_6.2-1+ubuntu22.04_all.deb
    apt update



### Step 3 -  b. Install Zabbix server, frontend, agent
     apt install zabbix-server-pgsql zabbix-frontend-php php8.1-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent


### Step 4 -  c. Create initial database
Make sure you have database server up and running.

Run the following on your database host.

    sudo -u postgres createuser --pwprompt zabbix
    sudo -u postgres createdb -O zabbix zabbix



### Step 4.1 - On Zabbix server host import initial schema and data. You will be prompted to enter your newly created password.
    zcat /usr/share/doc/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix




### Step 5 -  d. Configure the database for Zabbix server
Edit file /etc/zabbix/zabbix_server.conf

    DBPassword=password



### Step 6 -  e. Start Zabbix server and agent processes
Start Zabbix server and agent processes and make it start at system boot.

    systemctl restart zabbix-server zabbix-agent apache2
    systemctl enable zabbix-server zabbix-agent apache2


### Step 7 -  f. Configure Zabbix frontend
Connect to your newly installed Zabbix frontend: http://server_ip_or_name/zabbix

Follow steps described in Zabbix documentation: Installing frontend



---



## STEPS by STEPS How to use (completed)
    sudo su - 
    sudo apt-get install gcc -y

    cd ~
    rm -fr auto5/
    git clone https://github.com/pedroAkiraDanno/auto5

    #1 ENTER IN terraform or vagrant folder to automation postgresql
    #2 ENTER IN ansible24 folder to automation postgresql 







---
Inspired in [Zabbix](https://www.zabbix.com/) , [git.zabbix](https://git.zabbix.com/projects/zbx/repos/zabbix/browse) and [gihub_zabbix](https://github.com/zabbix/zabbix) this is zabbix to postgresql auto-minimalistic version.
©  [PedroAkira](https://www.instagram.com/pedro.akira.3)
