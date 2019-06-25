#!/usr/bin/env bash

trap "echo 'Current state of the provisioned resources unknow..\n SIGINT recvd " SIGINT SIGTERM

usage() {
    echo "./deployapp.sh -t|--azure_tenant_id <AZURE_TENANT_ID> -c|--azure_client_id <Azure Client ID>
      -s|--azure_secret <AZURE_SECRET> -a|--azure_subscription_id <AZURE_SUBSCRIPTION_ID>"
}

if [[ $# -lt 1 ]]; then
  echo "Wrong params.."
  usage
  exit 1
fi

AZLOGIN() {

    if ! az --version 2&>1 > /dev/null; then
      echo "azure cli not installed"
      exit 1
    fi

    printf "Checking credentials by loggin in \n"

    if ! az login --service-principal --username $AZURE_CLIENT_ID --password $AZURE_SECRET --tenant $AZURE_TENANT; then
     printf "Unable to login.. Please check the credentials and try again.. \n"
     exit 1
    fi

    printf "Successfully logged in\n"
}

terra_run() {
    pushd provisioner
    if ! terraform --version 2&>1 > /dev/null ; then
      echo "Terraform not found.. exiting ..."
      exit 1
    fi

    terraform init

    if ! terraform apply -auto-approve; then
     echo "Something went wrong in.. provisioning.."
     popd
     exit 1
    fi
    echo "Done with Resource creation.. Config managing and deploying the code base"
    popd
}

ansible_run() {
    pushd ConfigManagement
    if ! ansible --version ; then
     echo "Ansible not installed.. pls install the same"
     popd
     exit 1
    fi
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./myazure_rm.yml site.yml
    exit 0
}



POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -t|--azure_tenant_id)
    AZURE_TENANT="$2"
    shift # past argument
    shift # past value
    ;;
    -c|--azure_client_id)
    AZURE_CLIENT_ID="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--azure_secret)
    AZURE_SECRET="$2"
    shift # past argument
    shift # past value
    ;;
    -a|--azure_subscription_id)
    AZURE_SUBSCRIPTION_ID="$2"
    shift
    shift
    ;;
    *)
          # unknown option
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

export AZURE_TENANT="${AZURE_TENANT}"
export AZURE_CLIENT_ID="${AZURE_CLIENT_ID}"
export AZURE_SECRET="${AZURE_SECRET}"
export AZURE_SUBSCRIPTION_ID="${AZURE_SUBSCRIPTION_ID}"
export ARM_CLIENT_ID="${AZURE_CLIENT_ID}"
export ARM_SUBSCRIPTION_ID="${AZURE_SUBSCRIPTION_ID}"
export ARM_TENANT_ID="${AZURE_TENANT}"
export ARM_CLIENT_SECRET="${AZURE_SECRET}"

AZLOGIN
terra_run
ansible_run