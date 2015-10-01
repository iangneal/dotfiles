###
#	Bash prompt definitions
###

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

## Section for path related things

prependPath(){
    for var in "$@"
    do
        if [[ "$PATH" != *"$var"* ]]
        then
            export PATH="$var:$PATH"
        else
            # remove all instances of this variable from the path
            # and then prepend - gets rid of the issue of having 
            # the same thing on the path multiple times.
            sed_flag="-r"
            if [ "$(uname)" == "Darwin" ]; then
                sed_flag="-E"
            fi
            trimmed=$(echo $PATH | sed $sed_flag s,$var:?,,g)
            export PATH="$var:$trimmed"
        fi
    done
}

removePath(){
    for var in "$@"
    do
        if [[ "$PATH" == *"$var"* ]]
        then
            sed_flag="-r"
            if [ "$(uname)" == "Darwin" ]; then
                sed_flag="-E"
            fi
            trimmed=$(echo $PATH | sed $sed_flag s,:$var:?,:,g)
            trimmed=$(echo $trimmed | sed $sed_flag s,^$var:,:,)
        fi
    done
}

sbin="/usr/local/sbin"
gnubin="/usr/local/opt/coreutils/libexec/gnubin"

prependPath $sbin $gnubin

## Section for bash prompt details

if [ "$(whoami)" = "root" ]; then
	a="\[$bldred\]\u@\h\[\e[m\]:\[$bldblu\]\w\[\e[m\]"
	b=" - \A \[$bldred\]#\[\e[m\] "
    export PS1=$a$b
else
	a="\[$txtgrn\]\u@\h\[\e[m\]:\[$bldblu\]\w\[\e[m\]"
	b=" - \A \[$txtylw\]$\[\e[m\] "
    export PS1=$a$b
fi

## Section for helping with terminal navigation

export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'

alias ls="ls -Gal"

## Section for git related commands

alias gau="git add -u"
alias gaa="git add -A"
alias gcm="git commit -m"
alias gcam="git commit -a -m"

alias gs="git status"
alias gl="git log"

alias gps="git push"
alias gpl="git pull"
alias gch="git checkout"
alias gbr="git checkout -b"

gitAllFunction(){
    git commit -a -m "$1"
    git push
}

alias gcamp=gitAllFunction

### This is for changing a git repo's protocol 

gitSwitchProtocol(){
    if [ "$1" != "https" ]
    then
        REPO_URL=`git remote -v | grep -m1 '^origin' | sed -Ene 's#.*(https://[^[:space:]]*).*#\1#p'`
        if [ -z "$REPO_URL" ]; then
            echo "-- ERROR:  Could not identify Repo url."
            echo "   It is possible this repo is already using SSH."
            return -1
        fi

        USER=`echo $REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\1#p'`
        if [ -z "$USER" ]; then
            echo "-- ERROR:  Could not identify User."
            return -1
        fi

        REPO=`echo $REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\2#p'`
        if [ -z "$REPO" ]; then
            echo "-- ERROR:  Could not identify Repo."
            return -1
        fi
        NEW_URL="git@github.com:$USER/$REPO.git"
    
    else
        REMOTE=${1-origin}

        REPO_URL=`git remote -v | grep -m1 "^$REMOTE" | sed -Ene's#.*(git@github.com:[^[:space:]]*).*#\1#p'`
        if [ -z "$REPO_URL" ]; then
            echo "-- ERROR:  Could not identify Repo url."
            echo "   It is possible this repo is already using HTTPS instead of SSH."
            return -1
        fi

        USER=`echo $REPO_URL | sed -Ene's#git@github.com:([^/]*)/(.*).git#\1#p'`
        if [ -z "$USER" ]; then
            echo "-- ERROR:  Could not identify User."
            return -1
        fi

        REPO=`echo $REPO_URL | sed -Ene's#git@github.com:([^/]*)/(.*).git#\2#p'`
        if [ -z "$REPO" ]; then
            echo "-- ERROR:  Could not identify Repo."
            return -1
        fi
    fi
    
    echo "Changing repo url from "
    echo "  '$REPO_URL'"
    echo "      to "
    echo "  '$NEW_URL'"
    echo ""

    CHANGE_CMD="git remote set-url origin $NEW_URL"
    `$CHANGE_CMD`
    
    echo "Success"
    return 0
}

alias -- git-switch-ssh="gitSwitchProtocol"
alias -- git-switch-https="gitSwitchProtocol https"

## Section for mistakenly typed commands

alias sl="sl -e"
alias cd..="cd .."


alias clr="clear"

alias refresh="source ~/.bashrc"

# allows ** to be recursive
shopt -s globstar
