# Postgresql terraform

Repo to postgresql with terraform in <strong>AZURE<strong/>(Microsoft AZURE)

---

# AZURE & Cloud Shell :

Microsoft Azure, often referred to as Azure, is a cloud computing service operated by Microsoft for application management via Microsoft-managed data centers.

Azure Power Shell is an authenticated, browser-accessible way to interact with Azure resources from the Azure portal. Cloud Shell is authenticated, meaning once you have access to your Azure portal you also have access to Cloud Shell.

#### Create Virtual_Machine(VM)

        cd ~
        rm -fr auto5/
        git clone https://github.com/pedroAkiraDanno/auto5.git
        // cd auto5 ; git checkout develop

        cd ~
        cd auto5/srv/terraform/azure/a/VM/05/
        terraform init
        terraform apply
                  Enter a value: eastus
                  Enter a value: vmtest


        #Clean up resources
        terraform destroy


        REFERENCE: https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/virtual-machines/linux/public-ip

#### Create Disks

        #DISK 1
                cd ~
                rm -fr auto5/
                git clone https://github.com/pedroAkiraDanno/auto5.git
                // cd auto5 ; git checkout develop
                // cd auto5 ;git checkout azure

                cd ~
                cd auto5/srv/terraform/azure/a/Disks/3/

                terraform init
                terraform plan
                terraform apply

        #DISK 2
                cd ~
                rm -fr auto5/
                git clone https://github.com/pedroAkiraDanno/auto5.git
                // cd auto5 ; git checkout develop
                // cd auto5 ;git checkout azure

                cd ~
                cd auto5/srv/terraform/azure/a/Disks/3/

                vi main.tf
                #change name in   name= "${local.vm_name}-disk1 to name= "${local.vm_name}-disk2

                terraform init
                terraform plan
                terraform apply

#### Attached Disks

        Portal Azure
        Virtual machines -> vmtest-vm | Disks -> Attach existing disks -> select the two disks that was created

---

# TESTS :

## 06_vm_linux

        cd ~
        rm -fr auto5/
        git clone https://github.com/pedroAkiraDanno/auto5.git
        // cd auto5 ; git checkout develop
        // cd auto5 ;git checkout azure

        cd ~
        cd auto5/srv/terraform/azure/d/test/06_vm_linux/


        # format the tf files
        terraform fmt

        # initialize terraform Azure modules
        terraform init

        # validate the template
        terraform validate

        # plan and save the infra changes into tfplan file
        terraform plan -out tfplan

        # show the tfplan file
        terraform show -json tfplan
        terraform show -json tfplan >> tfplan.json

        # Format tfplan.json file
        terraform show -json tfplan | jq '.' > tfplan.json

        # apply the infra changes
        terraform apply tfplan

        # delete the infra
        terraform destroy

        # cleanup files
        rm terraform.tfstate
        rm terraform.tfstate.backup
        rm tfplan
        rm tfplan.json
        rm -r .terraform/

## test02 disk

        cd ~
        rm -fr auto5/
        git clone https://github.com/pedroAkiraDanno/auto5.git
        // cd auto5 ; git checkout develop
        // cd auto5 ;git checkout azure

        cd ~
        cd auto5/srv/terraform/azure/a/Disks/2/

        terraform init
        terraform plan
        terraform apply

## test03 disk

        cd ~
        rm -fr auto5/
        git clone https://github.com/pedroAkiraDanno/auto5.git
        // cd auto5 ; git checkout develop
        // cd auto5 ;git checkout azure

        cd ~
        cd auto5/srv/terraform/azure/a/Disks/3/

        terraform init
        terraform plan
        terraform apply

## test03 VM

        cd ~
        rm -fr auto5/
        git clone https://github.com/pedroAkiraDanno/auto5.git
        // cd auto5 ; git checkout develop

        cd ~
        cd auto5/srv/terraform/azure/a/VM/02/
        terraform init
        terraform plan -out main.tfplan
        terraform apply main.tfplan
        //terraform apply main.tfplan -auto-approve

        #Verify the results
        terraform output -raw tls_private_key > id_rsa
        terraform output public_ip_address
        ssh -i id_rsa azureuser@<public_ip_address>

        #Clean up resources
        terraform plan -destroy -out main.destroy.tfplan
        terraform apply main.destroy.tfplan
        //terraform apply main.destroy.tfplan -auto-approve

        REFERENCE: https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform

---

# Instance / Linux Environment:

## Install Terraform

Install the latest version of Terraform v1.1.3+:

### Step 1 - In your environment, check your Terraform version.

        terraform -v

If you don't have Terraform v1.1.3+, then install Terraform using the following steps.

### Step 2 - From a browser, go to [Download Latest Terraform Release](https://www.terraform.io/downloads).

### Step 3 - Download or follow steps below.

Find the link for your environment and then follow the instructions for your environment. Alternatively, you can perform the following steps. Here is an example for installing Terraform v1.1.3 on Linux 64-bit.

### Step 4 - In your environment, create a temp directory and change to that directory:

        mkdir temp
        cd temp

### Step 5 - Download the Terraform zip file. Example:

        wget https://releases.hashicorp.com/terraform/1.1.3/terraform_1.1.3_linux_amd64.zip

### Step 6 - Unzip the file. Example:

        unzip terraform_1.1.3_linux_amd64.zip

#### Step 7 - Move the folder to /usr/local/bin or its equivalent in Mac. Example:

        sudo mv terraform /usr/local/bin

#### Step 8 - Go back to your home directory:

        cd

#### Step 9 - Check the Terraform version:

        terraform -v

        Example: Terraform v1.1.3 on linux_amd64

**_Reference:_** [Oracle OCI Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm)
