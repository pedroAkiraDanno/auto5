# Postgresql ansible

Repo to postgresql 15 with ansible

### OCI ( [teraform](https://github.com/pedroAkiraDanno/auto5/tree/develop/srv/terraform/oci))

    create a instance   	   (manual or with terraform, check terraform README.md)
    create 2 block volumes 	   (manual or with terraform, check terraform README.md)
    atttach block volumes 	   (manual or with terraform, check terraform README.md)

---

## 1- step

    ### login server:
    ### On Ubuntu ###
    sudo su -
    sudo apt update  --yes
    sudo apt install software-properties-common  --yes
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible --yes
    #sudo apt-get update && sudo apt-get upgrade -y
    #apt list --upgradable

## 2- step

    #run a iSCSI commands & information #in oci oracle
    lsblk

## 3 - step root

    sudo cp /home/ubuntu/.ssh/authorized_keys /root/.ssh/
    #sudo passwd root

    #login by root
    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp

    #move file sshd_config with github
    cd ~  ; rm -fr auto5
    git clone https://github.com/pedroAkiraDanno/auto5
    cd /root/auto5/srv/ansible25/ ; mv sshd_config  /etc/ssh/
    cat /etc/ssh/ssh_config | grep PasswordAuthentication
    cd ~  ; rm -fr auto5
    systemctl restart sshd


    OR

    # move the sshd_config file with (SCP)
    Set in vi /etc/ssh/sshd_config:

    PermitRootLogin yes
    PasswordAuthentication yes

    # systemctl restart sshd
    OR
    # /etc/init.d/sshd restart

    #move sshd_config file to server

## 4 - step login with ssh root

    #move key to server with sftp to /root/.ssh/ and ssh-key-2022-01-19
    cd ~
    rm -fr auto5
    git clone https://github.com/pedroAkiraDanno/auto5
    cd  /root/auto5/srv/ansible25/ ; mv ssh-key-2022-01-19.key*  /root/.ssh/
    cd ~  ; rm -fr auto5
    chmod 400 /root/.ssh/ssh-key-2022-01-19.key*
    ls -lath /root/.ssh/ssh-key-2022-01-19.key*


    OR


    #move key to server with sftp to /root/.ssh/ and ssh-key-2022-01-19
    chmod 400 /root/.ssh/ssh-key-2022-01-19.key*

## 5 - step move files and folder about ansible

    #user with root
    #move ansible files to server with sftp to /etc/ansible OR USE GITHUB REPO **better use GITHUB
    #GitHub:
    cd /etc/ansible/  && rm -rf /etc/ansible/*
    git clone https://github.com/pedroAkiraDanno/auto5
    cd /etc/ansible/auto5/srv/ansible25/ ; mv *  /etc/ansible/
    cd /etc/ansible/  && rm -rf auto5/
    ls -lath



    #and
    #execute
    cd /etc/ansible
    ansible <HOST_GROUP> -m ping
    ansible psql  -m ping
    chmod +x README2.sh
    ./README2.sh


    #reboot server --because the HDs
    #sudo apt-get update && sudo apt-get upgrade -y
    #apt list --upgradable
    #lsblk

## 6 - step exec ansible

    #TEST new files ****NOT NEED EXEC
        cd ~
        cd /etc/ansible/  && rm -rf /etc/ansible/*
        git clone https://github.com/pedroAkiraDanno/auto5
        cd /etc/ansible/auto5/ ;     git checkout develop ; cd ..
        cd /etc/ansible/auto5/srv/ansible25/ ; mv *  /etc/ansible/
        cd /etc/ansible/  && rm -rf auto5/



    #root user

    cd /etc/ansible

    #FILE SYSTEM - create file system to /dev/sd[b,c] and create /var/lib/postgresql/
        ansible-playbook -i hosts filesystem-playbook2.yml   #IF AZURE exec because they create sdb1 in /mnt    ansible-playbook -i hosts filesystem-playbook2-azure2.yml

    #Install postgresql
        ansible-playbook -i hosts db-server-playbook.yml

    #Move .sql files and install and config  pg_top pgbadger pgbench
        ansible-playbook -i hosts db-dir-playbook.yml
        ansible-playbook -i hosts pgbench.yml
        ansible-playbook -i hosts pg_top.yml


    #Enable archive and pgmetrics
        ansible-playbook -i hosts archive.yml
        #ansible-playbook -i hosts pgmetrics.yml  ***PROBLEM WITH aarch64


    ##BACKUP###
    #Backup - File System to backup
        ansible-playbook -i  hosts backup_filesystem.yml     #IF AZURE exec     ansible-playbook -i hosts backup_filesystem-azure2.yml     if need: sudo useradd postgres

    #Backup to dump
        ansible-playbook -i hosts backupcron.yml

    #Backup about pgbackRest
        ansible-playbook -i hosts pgbackRest.yaml

    #Backup about pg_basebackup
        ansible-playbook -i hosts /etc/ansible/pg_basebackup.yml

    #Backup Restore  pgbackRest
        ansible-playbook -i hosts /etc/ansible/sudo.yml
        ansible-playbook -i hosts /etc/ansible/pgbackRest-restore2.yaml



    #Postgresql test and utilitys
        ansible-playbook -i hosts swap.yml
        ansible-playbook -i hosts pg_collector.yml
        ansible-playbook -i hosts /etc/ansible/Load_sample_database_dvdrental3.yml
        #/var/lib/postgresql/scripts/dvdrental.sh
        ansible-playbook -i hosts /etc/ansible/db-temp.yml
        ansible-playbook -i hosts /etc/ansible/large_sort_temporary_files.yml

        ansible-playbook -i hosts /etc/ansible/postgres_structure.yaml
        ansible-playbook -i hosts /etc/ansible/pg_stat_statements.yml
        ansible-playbook -i hosts /etc/ansible/sequence.yml
        ansible-playbook -i hosts /etc/ansible/walfile.yml
        #ansible-playbook -i hosts pgAdmin.yaml


    ## LOG  	#dont need exec this commands 	IF
        ansible-playbook -i hosts /etc/ansible/log2.yml 	#Script to log maintenance log_rotation_size=500MB EXEC THIS IF WANT LESS SIZE
        ansible-playbook -i hosts /etc/ansible/log3.yml 	#Script to test log name and size 		JUST TO TEST


    ## Linux health-check-scripts
        #ansible-playbook -i hosts /etc/ansible/Environmental_Variables.yml
        ansible-playbook -i hosts /etc/ansible/Environmental_Variables2.yml
        ansible-playbook -i hosts /etc/ansible/health-check-script.yml
        ansible-playbook -i hosts /etc/ansible/health-check-script2.yaml
        ansible-playbook -i hosts /etc/ansible/health-check-script3.yaml

    ## About VACUUM
        ansible-playbook -i hosts /etc/ansible/pg_freespacemap.yaml
        ansible-playbook -i hosts /etc/ansible/vacuum_pgstattuple.yaml
        ansible-playbook -i hosts vacuum.yml
        ansible-playbook -i hosts /etc/ansible/vacuum_TABLE_BLOAT.yml
        ansible-playbook -i hosts /etc/ansible/vacuum_parameter.yml


    ## PGTune  Parameters 	OPTION TO EXEC
        #ansible-playbook -i hosts /etc/ansible/PGTune_Parameters8GB.yml
        #ansible-playbook -i hosts /etc/ansible/PGTune_Parameters12GB.yml
        #ansible-playbook -i hosts /etc/ansible/PGTune_Parameters16GB.yml
        #ansible-playbook -i hosts /etc/ansible/PGTune_Parameters32GB.yml
        #ansible-playbook -i hosts /etc/ansible/PGTune_Parameters64GB.yml

    #Generating fake data
        ansible-playbook -i hosts /etc/ansible/GeneratingfakedataSQL.yml
        ansible-playbook -i hosts /etc/ansible/MOCK_DATA.yml
        ansible-playbook -i hosts /etc/ansible/MOCK_DATA-cvs.yml


    ## About GUI Graphical User Interface in Linux
        ansible-playbook -i hosts /etc/ansible/GUI_linux.yml
        ansible-playbook -i hosts /etc/ansible/change_password.yml


    # About Postgresql architecture
        ansible-playbook -i hosts /etc/ansible/work_mem.yml


    #Install packetes
       ansible-playbook -i hosts /etc/ansible/installPacktes.yml


    #Permission_owership_group.yml
       ansible-playbook -i hosts /etc/ansible/permission_owership_group.yml

## need exec

    #use user root

    mkdir -p  /var/log/health-report/
    chmod +x /root/scripts/health-check.sh
    chmod +x /root/scripts/health-check-gen.sh
    chmod +x /root/scripts/linuxsystemhealth.sh
    chmod 755 /root/scripts/tecmint_monitor.sh
    /root/scripts/tecmint_monitor.sh -i

    apt-get install -y postfix mailutils

    cp profile /var/lib/postgresql
    #login with postgresql
    mv profile .profile
    . .profile

    #rm /root/.ssh/ssh-key-2022-01-19*
    #sudo passwd postgres

    ***change the name in fstab to uuid
    sudo blkid | grep UUID=
    vi /etc/fstab


    UUID="cf63881d-c34c-4cd7-be49-d4ed4586648e"
    UUID="1d1bb132-635a-44d0-9983-82fbb85b2b9b"

    UUID="cf63881d-c34c-4cd7-be49-d4ed4586648e"   /var/lib/postgresql ext4 defaults,auto,noatime,_netdev 2 0
    UUID="1d1bb132-635a-44d0-9983-82fbb85b2b9b"  /postgresql ext4 defaults,auto,noatime,_netdev 2 0



    #sudo apt-get update && sudo apt-get upgrade -y
    #apt list --upgradable
    #lsblk
    #reboot server --because the HDs


    #sudo with no NOPASSWD
    sudo su -
    cp /etc/sudoers /root/sudoers.bak
    su - postgres
    sudo visudo
    	postgres ALL=(ALL) NOPASSWD: ALL
    sudo -k


    #https://www.youtube.com/watch?v=FmiDt5hiOe0
    #https://phoenixnap.com/kb/how-to-install-nmap-ubuntu-18-04
    #https://linuxhint.com/setup-sudo-no-password-linux/

## need exec 2 BACKUP NOT USE OR EXEC

    #use user root

    mkdir -p  /var/log/health-report/
    chmod +x /root/scripts/health-check.sh
    chmod +x /root/scripts/health-check-gen.sh
    chmod +x /root/scripts/linuxsystemhealth.sh
    chmod 755 /root/scripts/tecmint_monitor.sh
    /root/scripts/tecmint_monitor.sh -i

    apt-get install -y postfix mailutils
    #/var/lib/postgresql/scripts/pgmetrics.sh

    #mkdir  /postgresql/backups/
    #chown -R postgres /postgresql/backups/
    #chgrp -R postgres /postgresql/backups/

    #chown -R postgres /postgresql/backups/
    #chgrp -R postgres /postgresql/backups/
    #chmod +x /var/lib/postgresql/scripts/pg_collector_delete.sh
    #chmod +x /var/lib/postgresql/scripts/pgbadger_delete.sh


    #chmod +x /var/lib/postgresql/scripts/*.sh
    #chown -R postgres:postgres /postgresql/

    cp profile /var/lib/postgresql
    #login with postgresql
    mv profile .profile
    . .profile

    #rm /root/.ssh/ssh-key-2022-01-19*
    #sudo passwd postgres

    ***change the name in fstab to uuid
    sudo blkid | grep UUID=
    vi /etc/fstab


    UUID="cf63881d-c34c-4cd7-be49-d4ed4586648e"
    UUID="1d1bb132-635a-44d0-9983-82fbb85b2b9b"

    UUID="cf63881d-c34c-4cd7-be49-d4ed4586648e"   /var/lib/postgresql ext4 defaults,auto,noatime,_netdev 2 0
    UUID="1d1bb132-635a-44d0-9983-82fbb85b2b9b"  /postgresql ext4 defaults,auto,noatime,_netdev 2 0




    #sudo apt-get update && sudo apt-get upgrade -y
    #apt list --upgradable
    #lsblk
    #reboot server --because the HDs


    #sudo with no NOPASSWD
    sudo su -
    cp /etc/sudoers /root/sudoers.bak
    su - postgres
    sudo visudo
    	postgres ALL=(ALL) NOPASSWD: ALL
    sudo -k


    apt-get install gcc -y

    ## install nmap and traceroute to zabbix
    sudo apt-get update
    sudo apt-get install nmap -y
    nmap --version

    sudo apt-get install traceroute


    #INSTALL
        sudo apt install net-tools -y
        sudo apt-get install neofetch -y
        sudo apt install net-tools -y




    #https://www.youtube.com/watch?v=FmiDt5hiOe0
    #https://phoenixnap.com/kb/how-to-install-nmap-ubuntu-18-04
    #https://linuxhint.com/setup-sudo-no-password-linux/

## OR

    chmod +x README2.sh
    ./README2.sh

    **commands.txt**
    **about: commands to use**

---

## OPTIONS 1: Enable 80 in OCI and iptables

## Step 1: in the OCI in browser

    Access the OCI and enable port 80/443/3000 in the firewall
    Virtual Cloud Networks:
    Networking  -> Virtual Cloud Networks  -> vcn-20220115-0043  -> Subnet Details  -> Security Lists
    Add enable port 80/443/3000 to the rules

## Step 2: in the server Linux

    sudo apt update
    sudo apt -y install apache2

    sudo systemctl restart apache2


    sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT
    sudo netfilter-persistent save


    access the browser
    http://<x.x.x.x.x>
    http://

    access the browser example:
    zabbix:
    http://129.213.163.55/zabbix/
    Grafana:
    http://129.213.163.55:3000

### REFERENCES:

https://docs.oracle.com/pt-br/iaas/developer-tutorials/tutorials/apache-on-ubuntu/01oci-ubuntu-apache-summary.htm

https://www.youtube.com/watch?v=XwpZwtXyHxc&t=262s

---

<br/>

## OPTIONS 2: Improve shape of Computer Instance and Block Volumes

## Step 1: Improve shape of Computer Instance

    Add Memory (GB): 12 OCPU count: 4

    Access the OCI
    Computer -> Instance -> edit -> change the shape to 4 OCPU and Memory to 12GB

## Step 2: Block Volumes

    Access the OCI
    Storage -> Block Volumes  -> Edit (blv0,blv1)
    VPU to: 20
    Enable Auto-tube Performance
    Backup Policies: choose the Gold or Blonze

<br/>

---

## OPTIONS 3: Extending partition and file system sizes

## Step 1: in the OCI in browser

    Access the OCI
    Storage -> Block Volume
    Select the block volume (blv0, blv1) -> edit
    Volume Size and Performance
    Volume Size (in GB)
    To 70

## Step 2: Extending partition and file system sizes

    df -h
    lsblk
    systemctl stop postgresql

    # /dev/sdb1 /var/lib/postgresql
    umount /dev/sdb1
    fdisk -u /dev/sdb
    p
    d
    1
    n
    p
    1
    enter
    enter
    w

    e2fsck -f /dev/sdb1
    enter
    enter

    resize2fs /dev/sdb1

    mount /dev/sdb1 /var/lib/postgresql

## Step 3: Extending partition and file system sizes (/dev/sdc1)

    # /dev/sdc1 /postgresql
    umount /dev/sdc1

    fdisk -u /dev/sdc
    p
    d
    1
    n
    p
    1
    enter
    enter
    w

    e2fsck -f /dev/sdc1
    enter
    enter

    resize2fs /dev/sdc1

    mount /dev/sdc1 /postgresql

## Step 4: edit /etc/fstab

    ***change the name in fstab to uuid
    sudo blkid | grep UUID=
    vi /etc/fstab



    UUID="cf63881d-c34c-4cd7-be49-d4ed4586648e"
    UUID="1d1bb132-635a-44d0-9983-82fbb85b2b9b"

    UUID="a16fb5a4-9f8e-4a5f-9304-53573bbb65fd"   /var/lib/postgresql ext4 defaults,auto,noatime,_netdev 2 0
    UUID="0488adbc-b0ae-4071-8853-f8240b8a3841"  /postgresql ext4 defaults,auto,noatime,_netdev 2 0


    #restart postgresql and reboot server with reboot command or oci
    #systemctl restart postgresql
    reboot

### REFERENCES:

https://www.ibm.com/docs/en/cloud-pak-system-w3550/2.3.3?topic=images-extending-partition-file-system-sizes

---

end:
