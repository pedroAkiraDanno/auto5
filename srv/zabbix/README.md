# Zabbix


**Zabbix** is an open-source software tool to monitor IT infrastructure such as networks, servers, virtual machines, and cloud services. Zabbix collects and displays basic metrics.



For more information look at our
docs located at [doc](https://github.com/pedroAkiraDanno/auto5/) and [wiki](https://github.com/pedroAkiraDanno/auto5/wiki) .



---





## How works:

Simple install and configuration about **Zabbix**.

<br /> 


## Notes/Infos: 
**Long-term support (LTS)**  is a product lifecycle management policy in which a stable release of computer software is maintained for a longer period of time than the standard edition. The term is typically reserved for open-source software, where it describes a software edition that is supported for months or years longer than the software's standard edition.


<br /> 

Default root password for Zabbix Appliance: User: Admin     Password: zabbix


---



## Download and Install Zabbix


### Step 1 - click in link: 

    https://www.zabbix.com/download

<br /> 

### Step 2 -  a. Install Zabbix repository
    wget https://repo.zabbix.com/zabbix/6.2/ubuntu-arm64/pool/main/z/zabbix-release/zabbix-release_6.2-1+ubuntu22.04_all.deb
    dpkg -i zabbix-release_6.2-1+ubuntu22.04_all.deb
    apt update

<br /> 

### Step 3 -  b. Install Zabbix server, frontend, agent
     apt install zabbix-server-pgsql zabbix-frontend-php php8.1-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent

<br /> 

### Step 4 -  c. Create initial database
Make sure you have database server up and running.

Run the following on your database host.

        #sudo su - postgres
        sudo -u postgres createuser --pwprompt zabbix
        sudo -u postgres createdb -O zabbix zabbix


<br /> 

### Step 4.1 - On Zabbix server host import initial schema and data. You will be prompted to enter your newly created password.
    zcat /usr/share/doc/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

<br /> 


### Step 5 -  d. Configure the database for Zabbix server
Edit file /etc/zabbix/zabbix_server.conf

    DBPassword=password

<br /> 

### Step 6 -  e. Start Zabbix server and agent processes
Start Zabbix server and agent processes and make it start at system boot.

    systemctl restart zabbix-server zabbix-agent apache2
    systemctl enable zabbix-server zabbix-agent apache2

<br /> 

### Step 7 -  f. Configure Zabbix frontend
Connect to your newly installed Zabbix frontend: **http://server_ip_or_name/zabbix** 

And access: [doc](https://github.com/pedroAkiraDanno/auto5/blob/develop/srv/zabbix/doc/zabbix.pdf)

Follow steps described in Zabbix documentation: [Installing frontend](https://www.zabbix.com/documentation/6.2/en/manual/installation/install#installing_frontend)

<br /> 



---



## STEPS by STEPS How to Install and configure Zabbix (completed)
    sudo su - 

    wget https://repo.zabbix.com/zabbix/6.2/ubuntu-arm64/pool/main/z/zabbix-release/zabbix-release_6.2-1+ubuntu22.04_all.deb
    dpkg -i zabbix-release_6.2-1+ubuntu22.04_all.deb
    apt update

    #sudo su - postgres
    sudo -u postgres createuser --pwprompt zabbix
    sudo -u postgres createdb -O zabbix zabbix

    zcat /usr/share/doc/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix


    Edit file /etc/zabbix/zabbix_server.conf
         DBPassword=password

    systemctl restart zabbix-server zabbix-agent apache2
    systemctl enable zabbix-server zabbix-agent apache2


<br /> 


# PostgreSQL Monitoring With ZABBIX


## How works:
Use Zabbix agent1 to monitoring PostgreSQL.
PostgreSQL by Zabbix agent


Overview
For Zabbix version: 6.2 and higher
Templates to monitor PostgreSQL by Zabbix. This template was tested on PostgreSQL versions 9.6, 10 and 11 on Linux and Windows.

---


### Step 1 - Install Zabbix agent and create a read-only zbx_monitor user with proper access to your PostgreSQL server.

For PostgreSQL version 10 and above:

    su - postgres 
    psql 

    postgres=# CREATE USER zbx_monitor WITH PASSWORD 'zabbix' INHERIT;
    postgres=# GRANT pg_monitor TO zbx_monitor;


<br /> 


### Step 2 - Dowload templete postgresql/
    #Dowload from https://git.zabbix.com/projects/ZBX/repos/zabbix/browse/templates/db/postgresql?at=release/6.2

    #git clone https://git.zabbix.com/projects/ZBX/repos/zabbix/browse/templates/db/postgresql?at=release/6.2

    sudo su - 
    cd ~ 
    git clone https://github.com/pedroAkiraDanno/auto5.git
    mkdir /root/zabbix 
    cd auto5/srv/zabbix ; cp zabbix-master@c2b18672840.zip /root/zabbix ; cd /root/zabbix/ ; unzip zabbix-master@c2b18672840.zip

    


<br /> 


### Step 3 - Copy postgresql/ to Zabbix agent home directory /var/lib/zabbix/. 

The postgresql/ directory contains the files needed to obtain metrics from PostgreSQL.

    mkdir /var/lib/zabbix/
    chown zabbix:zabbix /var/lib/zabbix/
    chmod 755 /var/lib/zabbix/


    mkdir /var/lib/zabbix/postgresql 
    cp -r /root/zabbix/templetes/db/postgresql/*  /var/lib/zabbix/postgresql/
    ls -lath  /var/lib/zabbix/postgresql/




<br /> 


### Step 4 - Copy template_db_postgresql.conf to Zabbix agent configuration directory /etc/zabbix/zabbix_agentd.d/ and restart Zabbix agent service.

    cp /root/zabbix/templete/db/postgresql/template_db_postgresql.conf /etc/zabbix/zabbix_agentd.d/

    ls -lath /etc/zabbix/zabbix_agentd.d/


<br /> 

### Step 5 - Edit pg_hba.conf to allow connections from Zabbix agent [auth-pg-hba-conf.html](https://www.postgresql.org/docs/current/auth-pg-hba-conf.html).
Add rows (for example):

    find / -name pg_hba.conf

    sudo su - postgres 
    vi /etc/postgresql/14/main/pg_hba.conf
            host all zbx_monitor 127.0.0.1/32 trust
            host all zbx_monitor 0.0.0.0/0 md5
            host all zbx_monitor ::0/0 md5

    sudo systemctl restart postgresql



### Step 6 - /var/lib/zabbix/.pgpass 

    vi /var/lib/zabbix/.pgpass 
            127.0.0.1:5432:postgres:zbx_monitor:zabbix


    chown zabbix:zabbix /var/lib/zabbix/.pgpass 
    chmod 600 /var/lib/zabbix/.pgpass 
    ls -lath /var/lib/zabbix/.pgpass 


    systemctl restart postgresql



<br /> 



### Step 7 -  f. Configure Zabbix frontend with Postgresql 
Connect to your newly installed Zabbix frontend: **http://server_ip_or_name/zabbix** 

And access: [doc](https://github.com/pedroAkiraDanno/auto5/blob/develop/srv/zabbix/doc/zabbix.pdf)


<br /> 




## References: 
    https://www.youtube.com/watch?v=Dw_2-SB-QKY

    https://www.zabbix.com/integrations/postgresql

    https://chmod-calculator.com/







---
Inspired in [Zabbix](https://www.zabbix.com/) , [git.zabbix](https://git.zabbix.com/projects/zbx/repos/zabbix/browse) and [gihub_zabbix](https://github.com/zabbix/zabbix) this is zabbix to postgresql auto-minimalistic version.
©  [PedroAkira](https://www.instagram.com/pedro.akira.3)
