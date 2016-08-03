#! /bin/bash
###
#   Automatically replaces all dotfiles in the user's home directory with the
#   ones in this repo for easy setup.
###
for dotfile in dot/*; do
    if [ -f "$dotfile" ]
    then
	    newname=${dotfile:4}
        rm -f ~/.$newname
        ln -s $(pwd)/$dotfile ~/.$newname
    fi
done
###
#   Routes program specific configurations to their correct locations.
###
for config in config/*; do
    if [ -f "$config" ]
    then
        dirname=${config:7}
        rm -f ~/.$dirname/config
        ln -s $(pwd)/$config ~/.$dirname/config
    fi
done
echo "Done. Please restart your shell for bash configurations to appear."
