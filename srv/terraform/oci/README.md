# Postgresql terraform

Repo to postgresql with terraform 

---




## Cloud Shell:

Your Cloud Shell machine comes with 5GB of storage for your home directory. Your Cloud Shell (machine and home directory) are located in: US East (Ashburn).
You are using Cloud Shell in tenancy pedro**** as an OCI Local user pedro@****.com

#### Get git and Github 
    cd ~
    rm -fr auto5/
    git clone https://github.com/pedroAkiraDanno/auto5.git
    cd auto5/terraform/oci/oci_infrastructure/

#### Key 
    ## move public and private key to acess terrafrom with oci 
    cd ~    
    cd auto5/terraform/oci/oci_infrastructure/Key/
    #myvar=$(id -u -n )
    myvar=$(whoami)
    cp  *.pem    /home/$myvar/.ssh/


#### Create_Intance
        cd ~   
        cd auto5/terraform/oci/oci_infrastructure/Create_Intance

        terraform init
        terraform plan
        terraform apply -auto-approve


#### Block_Volume 1 
        cd ~   
        cd auto5/terraform/oci/oci_infrastructure/Block_Volume

        terraform init
        terraform plan
        terraform apply 



#### Block_Volume 2
        cd ~   
        cd auto5/terraform/oci/oci_infrastructure/Block_Volume

        vi variables_vars.auto.tfvars 
        #change name block_volume_display_name to blv1

        terraform init
        terraform plan
        terraform apply -auto-approve




---

## Instance / Linux Environment:



