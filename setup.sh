#! /bin/bash

# Installs some nice things before we start.
if sudo -v >> /dev/null 2>&1 ; then
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    sudo apt install git wget curl zsh subversion
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    brew install git curl wget zsh subversion bash
  else
    echo "Unknown OSTYPE of $OSTYPE"
  fi
  # Make zsh a "standard" shell.
  sudo echo "$(which zsh)" >> /etc/shells
else
  echo "You do not have sudo privileges on this machine. Skipping package "
       "install..."
fi

# Switch shell if possible
if type "zsh" > /dev/null; then
  chsh -s $(which zsh)
fi

# Do some git configurations
git config --global core.editor "vim"

# Setup submodules.
git submodule init
git submodule update

# Setup some of the other, random resources I like.
# - Fonts
bash res/fonts/install.sh

# Automatically replaces all dotfiles in the user's home directory with the
# ones in this repo for easy setup.
for dotfile in dot/*; do
  if [ "$dotfile" != "dot\/\."* ]; then
    echo "symlinking $dotfile..."
    newname=${dotfile:4}
    rm -rf ~/.$newname
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

