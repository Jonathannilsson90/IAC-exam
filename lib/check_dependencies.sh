#!/bin/bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/install_packages.sh"

REQUIRED_PACKAGES=("terraform" "ansible" "docker" "python3")

check_dependencies() {

local MISSING_PACKAGES=()
local INSTALLINPUT

for PACKAGE in "${REQUIRED_PACKAGES[@]}"; do
if command -v "$PACKAGE" >/dev/null 2>&1; then
    success "[OK] $PACKAGE is installed"
else
    warn "[MISSING] $PACKAGE is not installed"
    MISSING_PACKAGES+=("$PACKAGE")
fi
done

if [[ ${#MISSING_PACKAGES[@]} -eq 0 ]]; then
success "All packages are installed"
return 0
fi

   read -r -p "Would you like to install the missing dependencies ? [Y/N] " INSTALLINPUT

case "$INSTALLINPUT" in
[Yy])
for PACKAGE in "${MISSING_PACKAGES[@]}"; do
log "Installing $PACKAGE"
install_packages "$PACKAGE"

done
;;
*) 
warn "Installation were cancelled; no packages were installed"

esac

}