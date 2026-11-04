#!/bin/bash

ensure_venv() {
  local ROOT_DIR
  ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
  VENV_DIR="$ROOT_DIR/.venv"

  if [[ ! -x "$VENV_DIR/bin/python" ]]; then
    log "Missing .venv - creating .venv in order for pytest to work"
    python3 -m venv "$VENV_DIR" || return 1
  else
    log ".venv is found"
  fi

}
