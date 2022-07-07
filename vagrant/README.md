# Vagrant


Vagrant is an open-source software product for building and maintaining portable virtual software development environments; e.g., for VirtualBox, KVM, Hyper-V, Docker containers, VMware, and AWS. It tries to simplify the software configuration management of virtualization in order to increase development productivity. 


---



## Install and use Vagrant on Ubuntu



### Install virtualbox 
                sudo apt update && sudo apt upgrade
                sudo apt install virtualbox



### Install Vagrant
                curl -O https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb
                sudo apt install ./vagrant_2.2.9_x86_64.deb
                vagrant --version




### Getting Started with Vagrant
                mkdir ~/my-vagrant-project
                cd ~/my-vagrant-project




### Removing Vagrant from Ubuntu 22.04
                sudo apt remove --autoremove vagrant






# ubuntu/jammy64 Vagrant box
How to use this box with Vagrant:

        vagrant init ubuntu/jammy64
        vagrant up



Connect with virtual machine:

        vagrant ssh 
        sudo passwd root









# codeup/Ubuntu-20.04-GUI 

Ubuntu 20.04 with GUI interface 

How to use this box with Vagrant:

        vagrant init codeup/Ubuntu-20.04-GUI
        vagrant up



Connect with virtual machine:

        vagrant ssh 
        sudo passwd root










# debian/bullseye64 

How to use this box with Vagrant:

        vagrant init debian/bullseye64
        vagrant up




Connect with virtual machine:

        vagrant ssh 
        sudo passwd root










---
# Basic commands

### vagrant status:
        vagrant status


### You can stop the virtual machine with the following command:
        vagrant halt


### To destroy all resources created during the creation of the machine, enter:
        vagrant destroy












---
Inspired in [postgresql](https://www.postgresql.org/) , [vagrant_cloud_box](https://app.vagrantup.com/)  , [vagrantup](https://www.vagrantup.com/) , 
 [vagrantup_docs](https://www.vagrantup.com/docs) and   [vragrant_source_code](https://github.com/hashicorp/vagrant) this is postgresql auto-minimalistic version.
©  [PedroAkira](https://www.instagram.com/pedro.akira.3)

