#!/bin/bash

LIB_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$LIB_DIR/common.sh"

ensure_venv() {
  local ROOT_DIR
  ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
  local VENV_DIR="$ROOT_DIR/.venv"

  echo "$VENV_DIR"

  if [[ ! -d "$VENV_DIR/.venv/bin/python" ]]; then
    log "Missing .venv - creating .venv in order for pytest to work"
    python3 -m venv "$VENV_DIR/.venv/" || return 1
  else
    log ".venv is found"
  fi

}
