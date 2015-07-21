#! /bin/bash
###
#   Automatically replaces all dotfiles in the user's home directory with the ones in
#   this repo for easy setup
###
for dotfile in .*; do
    if [ -f "$dotfile" -a "$dotfile" != ".gitignore" ]
    then
        rm -f ~/$dotfile
        ln -s $(pwd)/$dotfile ~/$dotfile
    fi
done
echo "Done. Please restart your shell for bash configurations to appear"
