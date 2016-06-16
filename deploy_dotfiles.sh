#!/bin/bash

warn_and_exit() {
  echo
  echo "!!!!!!!!!!!!!WARNING WARNING WARNING!!!!!!!!!!!!!!!"
  echo "THIS WILL OVERWRITE ALL SUPPORTED CONFIG FILES !!!!"
  echo "..PLEASE USE \"-YES-RESET-MY-CONF\" to really do it.."
  echo
  exit 1
}

overwrite_config() {
  for dir in *; do
    if [[ -d "${dir}" ]]; then
      for item in "${dir}"/*; do
        rm -rf "${HOME}/.${item#${dir}/}"
        cp -vr "${item}" "${HOME}/.${item#${dir}/}"
      done
    fi
  done
  exit 0
}

[[ $1 = "-YES-RESET-MY-CONF" ]] || warn_and_exit

overwrite_config
