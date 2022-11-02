# Postgresql terraform

Repo to postgresql with terraform in <strong>AWS<strong/>(Amazon Web Services)

---

# Cloud Shell:

AWS CloudShell, a browser-based shell, you can quickly run scripts with the AWS Command Line Interface (CLI), experiment with service APIs using the AWS CLI, and use other tools to increase your productivity. The CloudShell icon appears in AWS Regions where CloudShell is available.

#### Get git and Github

    cd ~
    rm -fr auto5/
    git clone https://github.com/pedroAkiraDanno/auto5.git
    cd auto5/srv/terraform/aws/

#### Create Compute_Engine

        cd ~
        cd auto5/srv/terraform/aws/google_cloud/Compute_Engine/5


        terraform init
        terraform plan
        //terraform apply
        terraform apply -auto-approve

        //terraform destroy -auto-approve

---

#### Create Test Buckets

        cd ~
        cd auto5/srv/terraform/aws/d/buckets/

        terraform init
        terraform plan
        //terraform apply
        terraform apply -auto-approve

        //terraform destroy -auto-approve

---

# Instance / Linux Environment 2.0 NEW :

## LINUX:

        wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update && sudo apt install terraform

## AMAZON LINUX:

        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
        sudo yum -y install terraform

### REFERENCE: https://www.terraform.io/downloads

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
