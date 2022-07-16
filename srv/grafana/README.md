# Grafana


**Grafana** is a multi-platform open source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources. 



For more information look at our
docs located at [doc](https://github.com/pedroAkiraDanno/auto5/) and [wiki](https://github.com/pedroAkiraDanno/auto5/wiki) .



---




## How works:

Simple install and configuration about **Grafana**.



<br /> 


## Notes/Infos: 


<br /> 




---



## Download and Install Grafana



### Step 1 - click in link: 

    https://grafana.com/grafana/download?pg=get&plcmt=selfmanaged-box1-cta1&platform=arm

<br /> 




### Step 2 -  Install Grafana repository
Ubuntu and Debian(ARM64)  SHA256: 98f22640af2f816e09cd8d41bdd98fe5320b73cec83062550c8888fc7a8b0990

    sudo apt-get install -y adduser libfontconfig1
    wget https://dl.grafana.com/enterprise/release/grafana-enterprise_9.0.3_arm64.deb
    sudo dpkg -i grafana-enterprise_9.0.3_arm64.deb

<br /> 



### Step 3 -  Enable Grafana when start 
    #info about linux 
    lsb_release -a 
    cat /etc/issue
    cat /etc/os-release
    hostnamectl

    #info about linux 
    sudo apt install screenfetch
    screenfetch

    #enable and restart grafana 
    sudo systemctl enable grafana-server 
    sudo systemctl start grafana-server 


<br /> 


### Step 4 -  Install plugins and zabbix plugins
    #info about grafana configuration 
    cat /etc/default/grafana-server

    #install some plugins about grafana 
    sudo grafana-cli plugins install jdbranham-diagram-panel 
    sudo grafana-cli plugins install grafana-piechart-panel 

    #install zabbix plugin
    grafana-cli plugins install alexanderzobnin-zabbix-app



<br /> 


### Step 5 - Configure Grafana frontend
Connect to your newly installed Grafana frontend: **http://server_ip_or_name:3000** 

And access: [doc](https://github.com/pedroAkiraDanno/auto5/blob/develop/srv/zabbix/doc/zabbix.pdf)



<br /> 



---



## STEPS by STEPS How to Install and configure Grafana (completed)
    sudo su - 

    sudo apt-get install -y adduser libfontconfig1
    wget https://dl.grafana.com/enterprise/release/grafana-enterprise_9.0.3_arm64.deb
    sudo dpkg -i grafana-enterprise_9.0.3_arm64.deb


<br /> 






# PostgreSQL Monitoring with Grafana


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
    cp /root/zabbix/templete/db/postgresql/*  /var/lib/zabbix/postgresql/
    ls -lath  /var/lib/zabbix/postgresql/




<br /> 


### Step 4 - Copy template_db_postgresql.conf to Zabbix agent configuration directory /etc/zabbix/zabbix_agentd.d/ and restart Zabbix agent service.

    cp template_db_postgresql.conf /etc/zabbix/zabbix_agentd.d/

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
Inspired in [Grafana](https://grafana.com/) , [Grafana.plugins](https://grafana.com/grafana/plugins/) , [Grafana.dashboards](https://grafana.com/grafana/dashboards/) , [Grafana.download](https://grafana.com/grafana/download) , [Grafana.docs](https://grafana.com/docs/) , [Grafana.github](https://github.com/grafana) and [Grafana.youtube](https://www.youtube.com/c/Grafana/videos) this is grafana to postgresql auto-minimalistic version.
©  [PedroAkira](https://www.instagram.com/pedro.akira.3)
