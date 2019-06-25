# Azure + Terraform + Ansible playbook with service discovery

This is an example integrated Provisioning + Config Management and Deployment flow.

## Dependencies
* terraform 11.X Download appropriate build from https://releases.hashicorp.com/terraform/0.11.14/ ( Please note recent terraform version 12 is not tested and may not work .. yet)
* ansible 2.8.1
* ansible['azure'] module 
* Tested in Ubuntu Latest and OSx
* Azure account with service principle configured

## Example installation of above dependeicnes on Ubuntu..

Easiest way to get started is to pull docker container. If not skip the below code and move to the common section.

```
docker run --name my-ubuntu -ti ubuntu:latest bash
```

Common to all Ubuntu ( Docker or otherwise )

```
apt-get update
apt-get install curl python-pip unzip git
curl -o terraform.zip https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_linux_amd64.zip
unzip terraform.zip && mv terraform /usr/bin/
pip install ansible
pip install ansible['azure']
```

Create service principal in azure.. Easy way is to do az login and execute below command from azure web cli or a management machine

```
az ad sp create-for-rbac --name ServicePrincipalName
```

Note down the output and save it securely.

Back to our docker container/Ubuntu machine

```
git clone https://github.com/linuxmanju/terraform-azure-ansible.git
cd terraform-azure-ansible
```

From here on deploy.sh should do rest of the things for you.. Loggin in to azure using Service principle+ Provisinong + Config management ..etc

Usage of deploy.sh is as below..

./deployapp.sh -t|--azure_tenant_id <AZURE_TENANT_ID> -c|--azure_client_id <Azure Client ID> \
      -s|--azure_secret <AZURE_SECRET> -a|--azure_subscription_id <AZURE_SUBSCRIPTION_ID>

Replace the appropriate value from the service principle creation output.

An example run..

```
./deployapp.sh -t ddddddddddddd -c ccccccccccccccccc -s 8dsssssssss -a 2fffffffff
```

Once the run is complete.. You should be able to access Application on port 443 of webvm


git clone https://github.com/linuxmanju/terraform-azure-ansible.git
cd terraform-azure-ansible
```


curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash






