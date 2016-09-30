#!/usr/bin/env bash

OS=$(uname)
PREFIX=${HOME}
VIM_PLUGIN_MANAGER_URL="https://github.com/Shougo/neobundle.vim"
VIM_PLUGIN_MANAGER_INSTALL_PATH="~/.vim/bundle/neobundle.vim"

function usage {
  echo "$(basename $0) all"
  echo "           install everything in ${PREFIX}"
  echo "$(basename $0) dir1 [dir2 dirN]"
  echo "           install config from dir1 dir2 dirN in ${PREFIX}"
  exit 1
}

function install_bash {
  echo "Installing bash configuration..."
  install -C -m 0600 bash/bash_profile ${PREFIX}/.bash_profile
  install -C -m 0600 bash/bash_prompt ${PREFIX}/.bash_prompt
  install -C -m 0600 bash/bash_theme ${PREFIX}/.bash_theme
  install -C -m 0600 bash/bashrc ${PREFIX}/.bashrc
  install -C -m 0600 bash/liquidpromptrc ${PREFIX}/.liquidpromptrc
  echo "Done."
}

function install_conky {
  echo "Installing conky configuration..."
  install -C -m 0600 conky/conky_functions.lua ${PREFIX}/.conky_functions.lua
  install -C -m 0600 conky/conkyrc ${PREFIX}/.conkyrc
  echo "Done."
}

function install_freebsd {
  echo "Installing FreeBSD specific configuration.."
  install -C -m 0600 freebsd/login_conf ${PREFIX}/.login_conf
  echo "done."
}

function install_git {
  echo "Installing git configuration..."
  install -C -m 0600 git/gitconfig ${PREFIX}/.gitconfig
  install -C -m 0600 git/gitignore_global ${PREFIX}/.gitignore_global
  echo "Done."
}

function install_mutt {
  echo "Installing mutt configuration..."
  install -C -m 0700 -d ${PREFIX}/.mutt
  install -C -m 0600 mutt/passwords.gpg ${PREFIX}/.mutt/passwords.gpg
  install -C -m 0600 mutt/jellybeans.theme ${PREFIX}/.mutt/jellybeans.theme
  install -C -m 0600 mutt/mailcap ${PREFIX}/.mutt/mailcap
  install -C -m 0600 mutt/dvtm.sig ${PREFIX}/.mutt/dvtm.sig
  install -C -m 0600 mutt/gcu.sig ${PREFIX}/.mutt/gcu.sig
  install -C -m 0600 mutt/twisla.sig ${PREFIX}/.mutt/twisla.sig
  install -C -m 0600 mutt/gpg.rc ${PREFIX}/.mutt/gpg.rc
  install -C -m 0600 mutt/muttrc ${PREFIX}/.mutt/muttrc
  echo "Done."
}

function install_tmux {
  echo "Installing tmux configuration..."
  install -C -m 0600 tmux/tmux.bindings ${PREFIX}/.tmux.bindings
  install -C -m 0600 tmux/tmux.theme ${PREFIX}/.tmux.theme
  install -C -m 0600 tmux/tmux.conf ${PREFIX}/.tmux.conf
  echo "Done."
}

function install_vim {
  if [[ $(which git > /dev/null) ]]; then
    echo "Installing vim configuration..."
    install -C -m 0700 -d .vim/bundle
    install -C -m 0700 -d .vim_cache
    install -C -m 0600 vim/vimrc ${PREFIX}/.vimrc
    echo "Done."
    if [ ! -d ${VIM_PLUGIN_MANAGER_INSTALL_PATH} ]; then
      echo "Cloning vim plugin manager"
      git clone ${VIM_PLUGIN_MANAGER_URL} $(VIM_PLUGIN_MANAGER_INSTALL_PATH)
      echo "Done."
    fi
  else
    echo "Please install git to clone vim plugins."
  fi
}

function install_xorg {
  echo "Installing graphical environment configuration..."
  install -C -m 0600 xorg/Xresources ${PREFIX}/.Xresources
  install -C -m 0700 xorg/xinitrc.sh ${PREFIX}/.xinitrc.sh
  install -C -m 0600 xorg/xinitrc ${PREFIX}/.xinitrc
  install -C -m 0600 xorg/spectrwm.conf ${PREFIX}/.spectrwm.conf
  echo "Done."
}

function install_all {
  install_bash
  install_conky
  install_git
  install_mutt
  install_tmux
  install_vim
  install_xorg
  if [[ "${OS}" = "FreeBSD" ]]; then
    install_freebsd
  fi
}

if [[ -n "$1" ]]; then
  case "$1" in
    -h|--help|help)
      usage
     ;;
  esac

  for arg in "$@"; do
    if [[ -n "$(type -t install_${arg})" ]] && [[ "$(type -t install_${arg})" = "function" ]]; then
    install_"${arg}"
    fi
  done
else
  usage
fi


