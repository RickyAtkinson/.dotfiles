#!/usr/bin/env bash
#
# Searches DuckDuckGo and displays the results in the lynx terminal browser.
# Expects a single string as the argument.

. ~/.local/scripts/lib/utils.sh

if [[ $# -eq 1 ]]; then
  query=$(echo $1 | tr ' ' '+')
  lynx -vikeys -accept_all_cookies "https://lite.duckduckgo.com/lite/?q=$query"
elif [[ $# -eq 0 ]]; then
  echo_error "No URL given."
  exit 22 # Error 22: Invalid argument
else
  echo_error "Only expected 1 agument."
  exit 22 # Error 22: Invalid argument
fi
