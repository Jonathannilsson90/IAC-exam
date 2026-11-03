#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/check_dependencies.sh"


RUNNING=true

while [ "$RUNNING" = true ]; do

echo "---------------------------------------"
echo "1) Check installed dependencies"
echo "2) Initalize Terraform"
echo "3) Destroy Terraform"
echo "4) Quit"
echo "---------------------------------------"


read -r -p "Welcome to the Terraform and ansible initaliser, what would you like to do? " INPUT


case $INPUT in

1)
log "Checking dependencies"
check_dependencies
;;

2)
log "Installing Terraform bootstrap"
mkdir -p logs/

export TF_LOG=DEBUG
export TF_LOG_PATH="./logs/terraform.log"

terraform init 
terraform apply -auto-approve
;;

3)
log "Destroying terraform provision"

mkdir -p logs/

export TF_LOG=DEBUG
export TF_LOG_PATH="./logs/terraform.log"

terraform destroy -auto-approve
;;

4)
RUNNING=false
log "Quitting"
;;

*)
warn "Invalid choice"

esac

done