sudo swapon -s
sudo fallocate -l 8G /swapfile
chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

sudo su -c "echo '/swapfile   none    swap    sw    0   0' >> /etc/fstab"
