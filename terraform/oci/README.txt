





Cloud Shell:

    cd ~
    rm -fr auto5/
    git clone https://github.com/pedroAkiraDanno/auto5.git
    cd auto5/terraform/oci/oci_infrastructure/

    Key
    cd ~    
    cd auto5/terraform/oci/Key/
    #myvar=$(id -u -n )
    myvar=$(whoami)
    cp  *.pem    /home/$myvar/.ssh/


    Create_Intance
        cd ~   
        cd auto5/terraform/oci/oci_infrastructure/Create_Intance

        terraform init
        terraform plan
        terraform apply -auto-approve




Instance:


