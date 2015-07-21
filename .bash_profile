###
#   .bash_profile is run for login shells (and new Terminal.app windows on Mac),
#   whereas .bashrc is run any other time bash is invoked.
#
#   This does some login specific things (welcome, print other statistics, etc),
#   and the .bashrc will house the more general configurations.
###
echo ""
echo "Welcome $(whoami)"
echo ""
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
