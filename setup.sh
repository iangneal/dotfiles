#! /bin/bash

# Setup submodules.
git submodule init
git submodule update

# Setup some of the other, random resources I like.
# - Fonts
bash res/fonts/install.sh

# Installs some nice things before we start.
if sudo -v >> /dev/null 2>&1 ; then
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Linux
    sudo apt install git wget curl
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    brew install git curl wget
  else
    echo "Unknown OSTYPE."
  fi
else
  echo "You do not have sudo privileges on this machine. Skipping package install..."
fi

# Do some git configurations
git config --global core.editor "vim"

# Automatically replaces all dotfiles in the user's home directory with the
# ones in this repo for easy setup.
for dotfile in dot/*; do
  if [ "$dotfile" != "dot\/\."* ]; then
    echo "symlinking $dotfile..."
    newname=${dotfile:4}
    rm -f ~/.$newname
    ln -s $(pwd)/$dotfile ~/.$newname
  fi
done

# Routes program specific configurations to their correct locations.
for config in config/*; do
  if [ -f "$config" ]; then
    dirname=${config:7}
    rm -f ~/.$dirname/config
    ln -s $(pwd)/$config ~/.$dirname/config
  fi
done
echo "Done. Please restart your shell for bash configurations to appear."
