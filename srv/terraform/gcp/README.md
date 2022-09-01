# Postgresql terraform

Repo to postgresql with terraform in <strong>GCP<strong/>(Google Cloud Plataform)

---

# Cloud Shell:

Google Cloud Shell is an online bash shell based on Debian. The free tier includes 1.7 gigabytes of random-access memory and a persistent 5 gigabyte home directory. Except for the home and root directories, the Cloud Shell environment is volatile. The editor in Google Cloud Shell is based on Eclipse Theia.

#### Get git and Github

    cd ~
    rm -fr auto5/
    git clone https://github.com/pedroAkiraDanno/auto5.git
    cd auto5/srv/terraform/gcp/

#### Create Compute_Engine

        cd ~
        cd auto5/srv/terraform/gcp/google_cloud/Compute_Engine/

        terraform init
        terraform plan
        terraform apply -auto-approve

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
