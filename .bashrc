# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function GITBRANCH {
    if [[ `git branch 2>&1` == *"fatal: not a git repository (or any of the parent directories): .git"* ]]
    then
	    echo No git repo
    else
    STATUS='[ '
    set -f
    for S in `git status -s | cut -c 1-2`;
    do
        STATUS=${STATUS}${S}' '
    done
    BRANCH=`git branch | grep ^\* | sed s"/^\* //"`
	echo ${BRANCH}${STATUS}']'
    unset -f
    fi
}
function GITHASH {
    if [[ `git branch 2>&1` == *"fatal: not a git repository (or any of the parent directories): .git"* ]]
    then
	    echo 0
    else
    HASH=`git log | head -n 1 | cut -c 8-13`
    set -f
	echo ${HASH}
    unset -f
    fi
}




function set_color_prompt {
    RC=$?;
    #DATE="\033[1;36m`date "+%s"` \033[0m||"
    RAND_BASE64='\033[37m`openssl rand -base64 3`\033[0m'
    RAND_HEX='\033[37m`openssl rand -hex 3`\033[0m'
    SSH='\033[37m`ssh-add -l | cut -c 1-4,12-18,76-`\033[0m'
    #GITHASH='git log | head -n 1 | cut -c 8-13' 
    #/ git commit hash, maybe extend USERHOSTBRANCH, follow on GITBRANCH above
    USERHOSTBRANCH='\033[1;34m`whoami`\033[0m \033[1;33m$(GITHASH)\033[0m \033[1;35m$(GITBRANCH)\033[0m'
    if [  ${RC} -eq 0 ]
    then
        PWDRC='\033[1;32m${PWD}\033[0m\033[1;31m: ${RC} \033[0m$'
    else
        PWDRC='\033[1;31m${PWD}\033[0m RC\033[1;32m: ${RC} \033[0m$'
    fi
    #LINE_A=$RAND_HEX\t$RAND_BASE64\t$RAND_HEX\t$RAND_BASE64'\n'
    LINE_A=$RAND_HEX' '$RAND_BASE64' '$RAND_HEX' '$RAND_BASE64'\n'
    LINE0=$USERHOSTBRANCH'\n'
    LINE1=$SSH'\n'
    LINE2=$PWDRC'\n'
    PS1=$LINE0$LINE_A$LINE1$LINE2 
}
export PROMPT_COMMAND=set_color_prompt

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export GPG_TTY=$(tty)
PATH="${PATH}${HOME}:/zcash/src"

source ~/.git-completion.bash
