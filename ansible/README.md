# Postgresql ansible

Repo to postgresql with ansible 


For more information look at our
docs located at [doc](https://github.com/pedroAkiraDanno/auto5) and [wiki](https://github.com/pedroAkiraDanno/auto5/wiki) .



## How works:

Create a basic ansible postgresql.

**Will need 2 disks**

first  disk to  install postgresql in diferent partition. Partition =  /var/lib/postgresql/

second disk  to  configuration backup in the future if want. backup in diferent partition. Partition = /postgresql/


---



### OCI 
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


## 5 - step  move files and folder about ansible
	#user with root
	#move ansible files to server with sftp to /etc/ansible OR USE GITHUB REPO **better use GITHUB
	#GitHub:
	cd /etc/ansible/  && rm -rf /etc/ansible/*  
	git clone https://github.com/pedroAkiraDanno/auto5
	cd /etc/ansible/auto5/ansible24/ ; mv *  /etc/ansible/ 
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

	ansible-playbook -i hosts  filesystem-playbook2.yml
	ansible-playbook -i hosts  db-server-playbook.yml 		
	ansible-playbook -i hosts  backup_filesystem.yml
	ansible-playbook -i hosts  /etc/ansible/Environmental_Variables2.yml

	





## need exec 
	#use user root

	chown -R postgres:postgres /postgresql/

	cp profile /var/lib/postgresql
	login with postgresql 
	mv profile .profile
	. .profile

	#rm /root/.ssh/ssh-key-2022-01-19*
	#sudo passwd postgres

	#because OCI
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






---
Inspired in [postgresql](https://www.postgresql.org/) , [ansible](https://www.ansible.com/) , [terraform](https://www.terraform.io/) and [oracle_cloud](https://www.oracle.com/cloud/) , this is postgresql auto-minimalistic version.
©  [PedroAkira](https://www.instagram.com/pedro.akira.3)




end: