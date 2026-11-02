#!/bin/bash
# Docs for colouring the terminal.
# https://gist.github.com/WestleyK/dc71766b3ce28bb31be54b9ab7709082

# ==============================
# Enabling custom status checks
# For all scripts with color
# ==============================

if [[ -t 1 || ${FORCE_COLOR:-0} == 1 ]]; then
  RED="\033[0;31m"
  YELLOW="\033[0;33m"
  GREEN="\033[0;32m"
  NOCOLOR="\033[0m"
else
  RED=""
  YELLOW=""
  GREEN=""
  NOCOLOR=""
fi

success() {
  echo
  printf "${GREEN}[SUCCESS] %s ${NOCOLOR}\n" "$*"
  echo
}

log() {
  echo
  printf "${YELLOW}[STATUS] %s ${NOCOLOR}\n" "$*"
  echo
}

warn() {
  echo
  printf "${RED}[WARN] %s ${NOCOLOR}\n" "$*" >&2
  echo
}