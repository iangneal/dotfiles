export PATH="/usr/local/sbin:$PATH"
export PS1="\u@\h:\w - \A > "

alias ls="ls -al"
alias gau="git add -u"
alias gaa="git add -A"
alias gcm="git commit -m"
alias gcam="git commit -a -m"
alias gs="git status"
alias gp="git push"
alias refresh="source ~/.bashrc"

# allows ** to be recursive
shopt -s globstar
