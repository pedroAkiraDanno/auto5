#!/bin/bash

#sudo su - 
sudo apt-get update && sudo apt-get upgrade -y


#INSTALL xrdp
  sudo apt-get install xrdp -y 

  sudo systemctl enable xrdp
  
  sudo systemctl status xrdp  




#REMOVE iptables RULES
    sudo truncate -s 0 /etc/iptables/rules.v4




# install GUI
    sudo apt install tasksel -y

    tasksel --list-tasks

    sudo tasksel install gnome-desktop


    sudo sed -i.bak '/fi/a #xrdp multiple users configuration \n mate-session \n' /etc/xrdp/startwm.sh 

    sudo systemctl set-default graphical.target

    sudo systemctl restart systemd-networkd    

    ##reboot









## call change_password.yml to change password using ansible module 
#sudo passwd ubuntu 
#qaz*()Q
#REFERENCE https://www.ansiblepilot.com/articles/change-user-password-ansible-module-user/





##CHECK IF GUI IS RUNNING
#pgrep -l "gnome|kde|mate|cinnamon|lx|xfce|jwm"
#pgrep -l "gnome|kde|mate|cinnamon"
#ps -A | egrep -i "gnome|kde|mate|cinnamon"
#/usr/bin/gnome-session
#type Xorg






#REFERENCES:
    #https://www.youtube.com/watch?v=b-lMXEKN6to
    #https://linuxize.com/post/how-to-install-xrdp-on-ubuntu-20-04/



