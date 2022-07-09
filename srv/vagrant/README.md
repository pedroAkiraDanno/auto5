# Vagrant


Vagrant is an open-source software product for building and maintaining portable virtual software development environments; e.g., for VirtualBox, KVM, Hyper-V, Docker containers, VMware, and AWS. It tries to simplify the software configuration management of virtualization in order to increase development productivity. 


For more information look at our
docs located at [doc](https://github.com/pedroAkiraDanno/auto5/blob/feature/vagrant2/vagrant/doc.md) and [vagrant-cheat-sheet](https://gist.github.com/wpscholar/a49594e2e2b918f4d0c4) .



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




### Removing Vagrant from Ubuntu 
                sudo apt remove --autoremove vagrant








# ubuntu/jammy64 Vagrant box
How to use this box with Vagrant:

        vagrant init ubuntu/jammy64
        vagrant up



Connect with virtual machine:

        vagrant ssh 
        sudo passwd root









# codeup/Ubuntu-20.04-GUI  Vagrant box

Ubuntu 20.04 with GUI interface 

How to use this box with Vagrant:

        vagrant init codeup/Ubuntu-20.04-GUI
        vagrant up



Connect with virtual machine:

        vagrant ssh 
        sudo passwd root










# debian/bullseye64 Vagrant box

How to use this box with Vagrant:

        vagrant init debian/bullseye64
        vagrant up




Connect with virtual machine:

        vagrant ssh 
        sudo passwd root





# 4linux/debian9-desktop Vagrant box

Debian9 with GUI interface 

How to use this box with Vagrant:

        vagrant init 4linux/debian9-desktop
        vagrant up




Connect with virtual machine:

        vagrant ssh 
        sudo passwd root








# STEPS by STEPS on Linux Environment (completed)

        sudo su - 

        cd ~
        rm -fr logrotate2/
        git clone https://github.com/pedroAkiraDanno/auto5
        cd  auto5/vagrant

        mkdir ~/my-vagrant-project
        cd ~/my-vagrant-project


        vagrant init debian/bullseye64
        vagrant up


        vagrant ssh 
        sudo passwd root
        sudo passwd ubuntu 







# STEPS by STEPS on Windows Environment (completed)

        cd D:\Users\Pedro\Desktop\P\database\PostgreSQL\auto\PRINCIPAL\auto5\srv\vagrant\v

        vagrant init debian/bullseye64
        vagrant up


        vagrant ssh 
        sudo passwd root
        sudo passwd ubuntu 


        #When finish test 
        vagrant halt
        vagrant destroy
        vagrant box remove debian/bullseye64 






---
Inspired in [postgresql](https://www.postgresql.org/) , [vagrant_cloud_box](https://app.vagrantup.com/)  , [vagrant](https://www.vagrantup.com/) , 
 [vagrantup_docs](https://www.vagrantup.com/docs) and   [vagrant_source_code](https://github.com/hashicorp/vagrant) this is postgresql auto-minimalistic version.
©  [PedroAkira](https://www.instagram.com/pedro.akira.3)

