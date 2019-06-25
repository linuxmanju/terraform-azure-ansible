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


curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash






