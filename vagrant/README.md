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









---
# Basic commands

### vagrant status:
        vagrant status


### You can stop the virtual machine with the following command:
        vagrant halt


### To destroy all resources created during the creation of the machine, enter:
        vagrant destroy


### This command lists all the boxes that are installed into Vagrant.
        vagrant box list
        vagrant box list -i


### Display status of all Virtual environments
        vagrant global-status




### Resume Virtual machines
        vagrant resume




### Box Outdated (if the update an availability in the boxes installed)
        vagrant box outdated
        vagrant box outdated --global



### Box Remove (This command removes a box from Vagrant that matches the given name.)
        vagrant box remove NAME


### Box Update (This command updates the box for the current Vagrant environment if there are updates available. )
        vagrant box update


### Box Prune (This command removes old versions of installed boxes.) 
        vagrant box prune
        vagrant box prune --dry-run   //Only print the boxes that would be removed.
        vagrant box prune --force    //Destroy without confirmation even when box is in use.





#  Explain Vagrant  & Study 


**Providers** are like Hypervysor VirtualBox, Hyper-V etc...

        While Vagrant ships out of the box with support for VirtualBox, Hyper-V, and Docker, Vagrant has the ability to manage other types of machines as well. This is done by using other providers with Vagrant.

        Alternate providers can offer different features that make more sense in your use case. For example, if you are using Vagrant for any real work, VMware providers are recommended since they're well supported and generally more stable and performant than VirtualBox.

        Before you can use another provider, you must install it. Installation of other providers is done via the Vagrant plugin system.

        Once the provider is installed, usage is straightforward and simple, as you would expect with Vagrant. Read into the relevant subsections found in the navigation to the left for more information.

        Reference:      https://www.vagrantup.com/docs/providers



**Boxes** are like ISOS


        Boxes are the package format for Vagrant environments. A box can be used by anyone on any platform that Vagrant supports to bring up an identical working environment.

        The vagrant box utility provides all the functionality for managing boxes. You can read the documentation on the vagrant box command for more information.

        The easiest way to use a box is to add a box from the publicly available catalog of Vagrant boxes. You can also add and share your own customized boxes on this website.

        Boxes also support versioning so that members of your team using Vagrant can update the underlying box easily, and the people who create boxes can push fixes and communicate these fixes efficiently.

        You can learn all about boxes by reading this page as well as the sub-pages in the navigation to the left.


        Reference:      https://www.vagrantup.com/docs/boxes


**Vagrantfile**

        The primary function of the Vagrantfile is to describe the type of machine required for a project, and how to configure and provision these machines. Vagrantfiles are called Vagrantfiles because the actual literal filename for the file is Vagrantfile (casing does not matter unless your file system is running in a strict case sensitive mode).

        Vagrant is meant to run with one Vagrantfile per project, and the Vagrantfile is supposed to be committed to version control. This allows other developers involved in the project to check out the code, run vagrant up, and be on their way. Vagrantfiles are portable across every platform Vagrant supports.

        The syntax of Vagrantfiles is Ruby, but knowledge of the Ruby programming language is not necessary to make modifications to the Vagrantfile, since it is mostly simple variable assignment. In fact, Ruby is not even the most popular community Vagrant is used within, which should help show you that despite not having Ruby knowledge, people are very successful with Vagrant.


        Reference:      https://www.vagrantup.com/docs/vagrantfile



**Exaplain init command**
         
         ex:     vagrant init 4linux/debian9-desktop
         Will create the file Vagrantfile that can configuration how want the virtual machine 



**Explain vagrant up command**
       
        After execute vagrant init that create the Vagrantfile. Vagrant up will download the ISO and configute the virtual machine and create in provider(virtualbox, vmware etc...)




**Explain the remove**

        mkdir ~/my-vagrant-project
        cd ~/my-vagrant-project

        vagrant init debian/bullseye64
        vagrant up

        vagrant box remove  debian/bullseye64






**Explain the files about vagrant**

        Windows 
        C:\Users\username\.vagrant.d\boxes
        C:\Users\username\.vagrant

        Linux 
        ~/.vagrant.d.
        ~/.vagrant

        By default Vagrant uses ~/.vagrant.d. Fortunately, vagrant provides an environment variable called VAGRANT_HOME by which you can set vagrant home.






---
Inspired in [postgresql](https://www.postgresql.org/) , [vagrant_cloud_box](https://app.vagrantup.com/)  , [vagrant](https://www.vagrantup.com/) , 
 [vagrantup_docs](https://www.vagrantup.com/docs) and   [vagrant_source_code](https://github.com/hashicorp/vagrant) this is postgresql auto-minimalistic version.
©  [PedroAkira](https://www.instagram.com/pedro.akira.3)

