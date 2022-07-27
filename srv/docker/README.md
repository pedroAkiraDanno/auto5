# Docker Postgresql & pgAdmin

Repo to postgresql and pgAdmin Docker  


<br />

**important:** use docker because in OCI Ubuntu Linux the architecture is aarch64 and pgAdmin not support this architecture so need use DOCKER 

<br />

### Install Docker Linux 

## 1 - step 
	Remove any Docker files that are running in the system, using the following command:
	$ sudo su - 
	$ sudo apt-get remove docker docker-engine docker.io

## 2 - step 
	Check if the system is up-to-date using the following command:
	$ sudo apt-get update

## 3 - step 
	Install Docker using the following command:
	$ sudo apt install docker.io


## 4 - step 
	Install all the dependency packages using the following command:
	$ sudo snap install docker


## 5 - step 
	Before testing Docker, check the version installed using the following command:
	$ docker --version


## 6 - step: some commands
	$ sudo docker images
	$ sudo docker ps -a
	$ sudo docker ps

REFERENCE: 
https://www.simplilearn.com/tutorials/docker-tutorial/how-to-install-docker-on-ubuntu


---



### How to set up Postgresql and Pgadmin with Docker



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


## 2- step: Install Postgresql  with Docker
	$docker volume create postgresqldata
	$docker volume ls

	$docker run -d -v postgresqldata:/data/db -e POSTGRES_PASSWORD=postgres --name postgres -p 5432:5432 postgres
	$docker ps -a

	$docker exec -it postgres /bin/bash 
	$psql -h localhost -U postgres



## 3- step: Install Pgadmin with Docker
	$docker run --name pgadmin -e "PGADMIN_DEFAULT_EMAIL=name@example.com" -e "PGADMIN_DEFAULT_PASSWORD=admin" -p 5050:80 -d dpage/pgadmin4 
	$docker ps -a

	http://localhost:5050/login 



## 


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
	Networking  -> Virtual Cloud Networks  -> vcn-20220114-0043  -> Subnet Details  -> Security Lists
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
https://dev.to/steadylearner/how-to-set-up-postgresql-and-pgadmin-with-docker-51h

https://www.simplilearn.com/tutorials/docker-tutorial/how-to-install-docker-on-ubuntu

https://www.pgadmin.org/download/pgadmin-4-apt/

https://stackoverflow.com/questions/40324824/how-to-access-remotely-pgadmin4

https://stackoverflow.com/questions/64198359/pg-admin-4-password-for-postgres-user-when-trying-to-connect-to-postgresql-1









<br/>




---
Inspired in [postgresql](https://www.postgresql.org/) , [ansible](https://www.ansible.com/) , [terraform](https://www.terraform.io/) and [oracle_cloud](https://www.oracle.com/cloud/) , this is postgresql auto-minimalistic version.
©  [PedroAkira](https://www.instagram.com/pedro.akira.3)




