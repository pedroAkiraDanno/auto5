# Docker Postgresql & pgAdmin

Repo to postgresql and pgAdmin Docker  


<br />

**important:** use docker because in OCI Ubuntu Linux the architecture is aarch64 and pgAdmin not support this architecture so need use DOCKER 

<br />




## Install Docker Linux 

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





## How to set up Postgresql and Pgadmin with Docker



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



---






## Link them with Docker network and set up Pgadmin

To make Pgadmin installed with Docker work along with Postgesql, we should link them with the Docker network command.


## 1- step 
	$docker network create --driver bridge pgnetwork
	$docker network ls

	$docker network connect pgnetwork pgadmin
	$docker network connect pgnetwork postgres




---





## Follow the document bellow to configure GUI pgAdmin 

Document: [postgresql](https://www.postgresql.org/)


<br />

---





## Options: 
	You can stop them after you test them not to use your resources with this.
	$docker stop pgadmin postgres

<br />

---



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




