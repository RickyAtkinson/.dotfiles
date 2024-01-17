#!/usr/bin/env bash
#
# Bash script utilities

echo_info() {
  printf "$(tput setaf 4)‣ %s$(tput sgr0)\n" "$@"
}

echo_success() {
  printf "$(tput setaf 2)✓ %s$(tput sgr0)\n" "$@"
}

echo_warning() {
  printf "$(tput setaf 11)⚠ %s$(tput sgr0)\n" "$@"
}

echo_error() {
  printf "$(tput setaf 9)✖ %s$(tput sgr0)\n" "$@"
}
