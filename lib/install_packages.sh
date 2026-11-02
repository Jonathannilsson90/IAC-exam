#!/bin/bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/install/install_docker.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/install/install_terraform.sh"



install_packages() {
local PACKAGE="$1"

case $PACKAGE in
terraform)
    install_terraform
    ;;
ansible)
     sudo -v | sudo apt install -y ansible
    ;;
docker)
    install_docker
    ;;

*)
warn "No such package found"

esac

}