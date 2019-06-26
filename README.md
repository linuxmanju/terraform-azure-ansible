# Azure + Terraform + Ansible playbook with service discovery

This is an example integrated Provisioning + Config Management and Deployment flow. 

* Provisions dependencies for two tier app using terraform and tags them appropriately ( Web, APP.. etc)
* Runs config management with Service discovery for Web server ( Nginx for Static file serving and Proxy Pass )
* Installs and configures tomcat8 and dependencies on APP and on the web installs nginx and deploys static files + appropriate discovered APP nodes for proxypass
* Number of Instances can be controlled through a single parameter in variables.tf ( for eg.. repeatcount=4 ) would deploy 4 sets of app and Web tier
* A tied together script ( to integrate all ) which can be run manually with parameters OR can be integrated with Jenkins easily

## To Do

* Need to separate resources for  Security group for web and app ( currently shared)
* APP tier doesnt need a public IP ( Currently provisioned for easier config management as we dont have a Management host yet)
* Separate resource count for app and web is ideal ( currently repeat count = 4 deploys 4 app and 4 web )
* A Load balancer resource would be nice to have
* JAVA GC parameters and Xmx and Xms values should be dynamically calculated and populated as a part of config management ( for eg.. on cloud VM with 4 GB should have Xmx to be set to 3 Gigs and 8GB should be set to 6.5 Gigs)
* Nginx should be configured with backend pool ( for better load balancing config )


## Fastest way to get going..

Docker image which I have built has all the dependencies installed ( terraform, ansible , az cli.. etc).. all you need to do is do below..

```
docker run -ti linuxmanju/companynews ./entry.sh
```

That should clone the git repo from  master branch and land you straight in the cloned folder inside the docker container. Inside the container terminal run..

```
./deployapp.sh -t|--azure_tenant_id <AZURE_TENANT_ID> -c|--azure_client_id <Azure Client ID> -s|--azure_secret <AZURE_SECRET> -a|--azure_subscription_id <AZURE_SUBSCRIPTION_ID>
```

If you want to get your hand dirty setting up everything from scratch, continue below.


## Dependencies
* terraform 11.X Download appropriate build from https://releases.hashicorp.com/terraform/0.11.14/ ( Please note recent terraform version 12 is not tested and may not work .. yet)
* ansible 2.8.1
* ansible['azure'] module 
* Tested in Ubuntu Latest and OSx
* Azure account with service principle configured


## Fastest way to get going..

Docker image which I have built has all the dependencies installed ( terraform, ansible , az cli.. etc).. all you need to do is do below..

```
docker run -ti linuxmanju/companynews ./entry.sh
```

That should clone the git repo from  master branch and land you straight in the cloned folder inside the docker container. Inside the container terminal run..

```
./deployapp.sh -t|--azure_tenant_id <AZURE_TENANT_ID> -c|--azure_client_id <Azure Client ID> -s|--azure_secret <AZURE_SECRET> -a|--azure_subscription_id <AZURE_SUBSCRIPTION_ID>
```

If you want to get your hand dirty setting up everything from scratch, continue below.


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

Once the run is complete.. You should be able to access Application on port 443 of webvm public IP.


