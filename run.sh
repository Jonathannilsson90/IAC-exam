#!/bin/bash

# ==============================
# Directory imports
# ==============================

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
readonly SCRIPT_DIR
INFRA_DIR="$SCRIPT_DIR/infra"
ANSIBLE_DIR="$SCRIPT_DIR/ansible"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/check_dependencies.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/ensure_venv.sh"

# ==============================
# Running while-loop for the GUI
# in the terminal to work
# ==============================

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
    
    # ==============================
    # Bootstraping terraform and
    # provisioning logs
    # ==============================
    
    mkdir -p logs/

    LOG_FILE_APPLY="./logs/terraform-apply$(date +%Y%m%d-%H%M%S).log"

    export TF_LOG_CORE=WARN
    export TF_LOG_PROVIDER=INFO
    export TF_LOG_PATH="$LOG_FILE_APPLY"

    terraform -chdir="$INFRA_DIR" init || return
    terraform -chdir="$INFRA_DIR" apply -auto-approve

    ip="$(terraform -chdir="$INFRA_DIR" output -raw url)"
    log "Container deployed with IP: $ip"
    echo "Visit web: http://localhost:8080"
    ;;


  3)
    log "Destroying terraform provision"
    
    # ==============================
    # Destroying 2) bootstrapped terraform
    # and provisioning logs
    # ==============================
    
    mkdir -p logs/

    LOG_FILE_DESTROY="./logs/terraform-destroy$(date +%Y%m%d-%H%M%S).log"

    export TF_LOG_CORE=WARN
    export TF_LOG_PATH="$LOG_FILE_DESTROY"

    terraform -chdir="$INFRA_DIR" destroy -auto-approve
    ;;

  4)
    log "Running Ansible playbook"

    # ==============================
    # Initializing Ansible playbook
    # site.yml
    # ==============================

    (cd "$ANSIBLE_DIR" && ansible-playbook site.yml)
    ;;

  5)
    log "Running Pytests"

    # ==============================
    # Starting pytest and ensuring
    # .venv exist in root dir
    # ==============================

    ensure_venv
    pytest -s --tb=short
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
