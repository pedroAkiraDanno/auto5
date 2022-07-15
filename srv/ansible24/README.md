# Postgresql ansible

Repo to postgresql with ansible 

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
	cd /root/auto5/srv/ansible24/ ; mv sshd_config  /etc/ssh/
	cat /etc/ssh/ssh_config | grep PasswordAuthentication
	cd ~  ; rm -fr auto5	
	

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
	chmod 400 /root/.ssh/ssh-key-2022-01-19.key*
	
	
	 OR 
	#move key to server with sftp to /root/.ssh/ and ssh-key-2022-01-19
	cd ~  
	rm -fr auto5
	git clone https://github.com/pedroAkiraDanno/auto5  
	cd  /root/auto5/srv/ansible24/ ; mv ssh-key-2022-01-19.key*  /root/.ssh/	
	cd ~  ; rm -fr auto5	
	chmod 400 /root/.ssh/ssh-key-2022-01-19.key*
	ls -lath /root/.ssh/ssh-key-2022-01-19.key*



## 5 - step  move files and folder about ansible
	#user with root
	#move ansible files to server with sftp to /etc/ansible OR USE GITHUB REPO **better use GITHUB
	#GitHub:
	cd /etc/ansible/  && rm -rf /etc/ansible/*  
	git clone https://github.com/pedroAkiraDanno/auto5
	cd /etc/ansible/auto5/srv/ansible24/ ; mv *  /etc/ansible/ 
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
	cd /etc/ansible

	ansible-playbook -i hosts filesystem-playbook2.yml
	ansible-playbook -i hosts db-server-playbook.yml 		
	ansible-playbook -i  hosts backup_filesystem.yml
	ansible-playbook -i hosts backupcron.yml
	ansible-playbook -i hosts archive.yml
	#ansible-playbook -i hosts pgmetrics.yml
	ansible-playbook -i hosts pgbackRest.yaml
	ansible-playbook -i hosts swap.yml
	ansible-playbook -i hosts pg_collector.yml
	ansible-playbook -i hosts /etc/ansible/Load_sample_database_dvdrental3.yml
	#/var/lib/postgresql/scripts/dvdrental.sh
	ansible-playbook -i hosts /etc/ansible/db-temp.yml
	ansible-playbook -i hosts /etc/ansible/large_sort_temporary_files.yml
	ansible-playbook -i hosts /etc/ansible/pg_basebackup.yml
	ansible-playbook -i hosts /etc/ansible/sudo.yml
	ansible-playbook -i hosts /etc/ansible/pgbackRest-restore2.yaml
	ansible-playbook -i hosts /etc/ansible/postgres_structure.yaml
	ansible-playbook -i hosts /etc/ansible/PGTune_Parameters8GB.yml
	ansible-playbook -i hosts /etc/ansible/pg_stat_statements.yml
	ansible-playbook -i hosts /etc/ansible/sequence.yml
	ansible-playbook -i hosts /etc/ansible/walfile.yml
	#ansible-playbook -i hosts pgAdmin.yaml
	
	LOG  	#dont need exec this commands 	IF 
	ansible-playbook -i hosts /etc/ansible/log2.yml 	#Script to log maintenance log_rotation_size=500MB EXEC THIS IF WANT LESS SIZE 
	ansible-playbook -i hosts /etc/ansible/log3.yml 	#Script to test log name and size 		JUST TO TEST
	
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



	## About GUI Graphical User Interface in Linux 
	ansible-playbook -i hosts /etc/ansible/GUI_linux.yml
	ansible-playbook -i hosts /etc/ansible/change_password.yml



## need exec 
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
	chown -R postgres /postgresql/backups/
	chgrp -R postgres /postgresql/backups/

	chown -R postgres /postgresql/backups/
	chgrp -R postgres /postgresql/backups/
	chmod +x /var/lib/postgresql/scripts/pg_collector_delete.sh
	chmod +x /var/lib/postgresql/scripts/pgbadger_delete.sh


	apt-get install gcc -y

	chmod +x /var/lib/postgresql/scripts/*.sh
	chown -R postgres:postgres /postgresql/

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



## OR

	chmod +x README2.sh
	./README2.sh

	**commands.txt**
	**about: commands to use**	



end:
