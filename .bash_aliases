SRC=$(readlink $BASH_SOURCE)
SH=$(dirname "$SRC")
SN=$(basename "$SH")

export EDITOR=vim

################################
# git options
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
. ~/$SN/git-completion.bash
#. ~/$SN/git-prompt.sh
export GIT_PROMPT_ONLY_IN_REPO=1
export GIT_PROMPT_FETCH_REMOTE_STATUS=0
. ~/$SN/bash-git-prompt/gitprompt.sh

alias g=git
alias gl='git l'
alias gll='git ll'
alias glll='git lll'
alias go='git checkout '

#PS1='[\u@\h \W]$(__git_ps1)\$ '
#PS1="\[$GREEN\]\t\[$RED\]-\[$BLUE\]\u\[$YELLOW\]\[$YELLOW\]\w\[\033[m\]\[$MAGENTA\]\$(__git_ps1)\[$WHITE\]\$ "

unset SSH_ASKPASS

alias n=ninja

################################
# Bash Directory Bookmarks
alias m1='alias g1="cd \"`pwd`\""'
alias m2='alias g2="cd \"`pwd`\""'
alias m3='alias g3="cd \"`pwd`\""'
alias m4='alias g4="cd \"`pwd`\""'
alias m5='alias g5="cd \"`pwd`\""'
alias m6='alias g6="cd \"`pwd`\""'
alias m7='alias g7="cd \"`pwd`\""'
alias m8='alias g8="cd \"`pwd`\""'
alias m9='alias g9="cd \"`pwd`\""'
alias mdump='alias|grep -e "alias g[0-9]"|grep -v "alias m" > ~/.my_bookmarks'
alias lma='alias | grep -e "alias g[0-9]"|grep -v "alias m"|sed "s/alias //"'
touch ~/.my_bookmarks
source ~/.my_bookmarks

################################
# vim airline
export TERM=xterm-256color

set -o vi

################################
#GCC_HOME=/usr/local/CC/gcc-4.8.5
#if [ -d $GCC_HOME ]; then
#    export PATH=$GCC_HOME/bin:$PATH
#    export LD_LIBRARY_PATH=$GCC_HOME/lib64:$LD_LIBRARY_PATH
#fi

if [ -d ~/llvm ]; then
    export PATH=~/llvm/bin:$PATH
    export LD_LIBRARY_PATH=~/llvm/lib:$LD_LIBRARY_PATH
fi

export PATH=~/rtags/bin:$PATH

export RTAGS_COMPILE_TIMEOUT=30000

