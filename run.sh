#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
INFRA_DIR="$SCRIPT_DIR/infra"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/check_dependencies.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/ensure_venv.sh"

file "$SCRIPT_DIR/lib/ensure_venv.sh"

RUNNING=true

while [ "$RUNNING" = true ]; do

  echo "---------------------------------------"
  echo "1) Check installed dependencies"
  echo "2) Initalize Terraform"
  echo "3) Destroy Terraform"
  echo "4) Deploy Ansible configuration"
  echo "5) Run Pytest for containers"
  echo "q) Quit"
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

    LOG_FILE_APPLY="./logs/terraform-apply$(date +%Y%m%d-%H%M%S).log"

    export TF_LOG_CORE=WARN
    export TF_LOG_PROVIDER=INFO
    export TF_LOG_PATH="$LOG_FILE_APPLY"

    terraform -chdir="$INFRA_DIR" init || return
    terraform -chdir="$INFRA_DIR" apply -auto-approve
    ;;

  3)
    log "Destroying terraform provision"
    mkdir -p logs/

    LOG_FILE_DESTROY="./logs/terraform-destroy$(date +%Y%m%d-%H%M%S).log"
    
    export TF_LOG_CORE=WARN
    export TF_LOG_PATH="$LOG_FILE_DESTROY"


    terraform -chdir="$INFRA_DIR" destroy -auto-approve
    ;;

  4) ;;

  5)
    ensure_venv
    ;;

  q)
    RUNNING=false
    log "Quitting"
    ;;

  *)
    warn "Invalid choice"
    ;;

  esac

done
