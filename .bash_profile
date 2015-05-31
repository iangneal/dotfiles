export PATH="/usr/local/sbin:$PATH"
# Terminal opens a login shell, which runs bash profile and NOT bashrc. Therefore, this will force the load of the bashrc
[[ -s ~/.bashrc ]] && source ~/.bashrc
