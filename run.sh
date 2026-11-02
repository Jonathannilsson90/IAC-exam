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
echo "2) Install Terraform"
echo "3) Quit"
echo "---------------------------------------"


read -r -p "Welcome to the Terraform and ansible initaliser, what would you like to do? " INPUT


case $INPUT in

1)
log "Checking dependencies"
check_dependencies
;;

2)
log "Installing Terraform bootstrap"
;;

3)
RUNNING=false
echo "Quitting"
;;

*)
warn "Invalid choice"

esac

done