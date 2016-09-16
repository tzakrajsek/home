# .bashrc

# Decades of evolution have made the rules for shell startup file processing
# a tangled web.
#
# Bash chooses .bash_profile over .bashrc in the following cases:
#   OSX terminal windows
#   Linux interactive login shells (via SSH, console)
#
# Bash chooses .bashrc over .bash_profile in the following cases:
#   Cygwin terminal windows
#   Linux SSH command execution
#   Non-interactive shells
#
# In order to guarantee a functioning environment, we rely only on the
# precedence rules we implement ourselves.  We put all logic in bashrc and
# have .bash_profile do nothing but source .bashrc.
#
# BASHRC_ONCE guards environment variable settings.  It is inherited by child
#     shells along with other environment variables.
#
# PS1 guards interactive shell settings (aliases, etc.) since it should be
#     unset in non-interactive shells.
#

#--------------------------------
# Environment Variables
#--------------------------------

if [ -z "$BASHRC_ONCE" ] ; then
    export BASHRC_ONCE=1

    # export EDITOR="${EDITOR:-emacsclient}"
    # export ALTERNATE_EDITOR=emacs
    # export P4CONFIG=.p4

    if [ -f /etc/bashrc ]; then
        . /etc/bashrc
    fi

    # Conditionally add directories to path
    # It's ok to add os specific ones since missing ones are bypassed.

    for P in \
        /usr/local/develop/adt-bundle/sdk/platform-tools \
        /usr/local/develop/depot_tools \
        /usr/local/bin \
        $HOME/local/bin \
        $HOME/bin \
        $HOME/bin/osx \
        /opt/local/sbin \
        /opt/local/bin
    do
        if [ -d "$P" ] ; then PATH="$P:$PATH" ; fi
    done

    if [ "${OSTYPE:0:6}" = "darwin" ]; then
        export MANPATH="/opt/local/share/man:$MANPATH"
        export myls='gls'
    elif [ "$OSTYPE" = "cygwin" ]; then
        export TMPDIR="/tmp"
        export myls='ls'
    elif [ "${OSTYPE:0:5}" = "linux" ]; then
        export myls='ls'
    fi

    # host-specific environment settings

    if [ -f ~/.bashrc-local ]; then
    . ~/.bashrc-local
    fi
fi


#--------------------------------
# Every time
#--------------------------------

export GYP_CHROMIUM_NO_ACTION=1 # don't process gyp
export CHROME_HEADLESS=1 # don't prompt for EULA

export GREP_COLOR='1;32'

# Might turn out to be machine specific?

export DEV=/usr/local/develop
export WORK=/workspace
export TOOLS=/workspace/tools

# export CCACHE_DIR=/usr/local/develop/ccache
# [[ -f ${CCACHE_DIR}/ccacherc ]] && . ${CCACHE_DIR}/ccacherc

if [ "$OSTYPE" = "cygwin" ]; then
  # Ignore CRs, and make sure this is set for every shell.
  # Set BASH_ENV to ensure this gets set when running shell scripts.
  # BASH_ENV is not already set when bash is invoked via SSH on Cygwin.
  set -o igncr
  export BASH_ENV="$HOME/.bashrc"
fi

#--------------------------------
# Interactive Shell Settings
#--------------------------------

if [ -z "$PS1" ] ; then
   return
fi

# PS1='\w] '
#
# if [ -n "$SSH_CLIENT" ] ; then
#   PS1='['"$HOSTNAME"'] \w: '
# fi

if [ "${OSTYPE:0:6}" = "darwin" ]; then
    if [ -n "$SSH_CLIENT" ] ; then
        export EDITOR=vi
    else
        export EDITOR=/Applications/Emacs.app/Contents/MacOS/Emacs
        alias emacs='emacs_osx'
    fi
elif [ "${OSTYPE:0:5}" = "linux" ]; then
  if [ -n "$SSH_CLIENT" ] ; then
    if [ "$EDITOR" != "emacsclient" ] ; then
      export EDITOR=/usr/bin/emacs
    fi
    alias emacs="$EDITOR"
  else
    alias emacs='emacs_linux'
  fi
fi

export EDITOR=vi  # override: for now, always use VI

emacs_osx() {
    { nohup /Applications/Emacs.app/Contents/MacOS/Emacs "$@" & disown; }  1>/dev/null 2>/dev/null
    # (nohup /Applications/Emacs.app/Contents/MacOS/Emacs "$@" 1>/dev/null 2>/dev/null &)
}

emacs_linux() {
    { nohup /usr/local/bin/emacs "$@" & disown; }  1>/dev/null 2>/dev/null
    # (nohup /usr/local/bin/emacs $@ 1>/dev/null 2>/dev/null &)
}

# recycle
re() {
  mv "$@" ~/.Trash/
}

pathedit() {
  echo "$PATH" | lua -e 'io.write((io.read("*a"):gsub(":","\n")))' > /tmp/path.txt
  ${EDITOR} /tmp/path.txt
  export PATH=`lua -e 'io.write((io.read("*a"):gsub("\n",":")))' < /tmp/path.txt`
}

# cds: cd to saved directory by selecting from a list.  Directories
#    are preserved across shell sessions.
#
cds() {
  touch ~/.cds
  if [ -z "$1" ] ; then
    # no arg: list
    n=0
    while read a && (( n < 9 )) ; do
      echo "$((++n)) $a"
    done < ~/.cds
    echo 'Use -v to see variables'
  elif [ "$1" == "-v" ]; then
    IFS='   '
    while read b a ; do
      echo "$b = $a"
    done < ~/.cdvars
  elif [ -z "${1/[0-9]*/}" ] ; then
    # numeric arg: retrieve & cd
    n="$1"
    while (( n > 0 )) ; do (( --n )) ; read a ; done < ~/.cds
    'cd' "$a"
  elif [ -d "${1}" ] ; then
    # directory arg: cd & save / move to top
    'cd' "$1"
    d=`pwd`
    echo "$d" > ~/.cds.new
    while read a ; do
      if [ "$a" != "$d" ] ; then echo "$a" ; fi
    done < ~/.cds >> ~/.cds.new
    mv -f ~/.cds.new ~/.cds
  elif [ "$1" == "-e" ] ; then
    $EDITOR ~/.cds
  elif [ "$1" == "-ev" ] ; then
    $EDITOR ~/.cdvars
  elif [ "$1" == "-h" ] ; then
    echo 'Usage:'
    echo '  cds        List saved directories'
    echo '  cds <n>    cd to saved dir #n'
    echo '  cds <dir>  cd to dir and add to list'
  else
    # else: look for match
    IFS='   '
    while read b a ; do
      if [ "$b" = "$1" ] ; then break ; fi
    done < ~/.cdvars
    if [ -z "$a" ] ; then
      while read a ; do
        if [ -z "${a/*$1*/}" ] ; then break ; fi
      done < ~/.cds
    fi
    if [ -z "$a" ] ; then
       echo "cds: not a directory: $1;  try 'cds -h' for help, or one of these:"
       cds
    else
       'cd' "$a"
    fi
  fi
}

alias luai="lua -l ix -i"

# MacPorts location of git:
if [ "$EMACS" != "t" -a -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi


# black:   30       dark gray:     90
# red:     31       light red:     91
# green:   32       light green:   92
# yellow:  33       light yellow:  93
# blue:    34       light blue:    94
# magenta: 35       light magenta: 95
# cyan:    36       light cyan:    96
# gray:    37       white:         97

export LS_COLORS="di=94:ln=90:so=37:pi=93:ex=97:bd=37:cd=37:su=37:sg=37:tw=92:ow=32:"
#echo "TERM=$TERM";

#if [ $TERM = emacs ]; then
#    TERM=dumb
#fi

case "$TERM" in
    dumb | emacs)
        alias ls='$myls --group-directories-first -BFh'
    ;;
    *)
        alias ls='$myls --group-directories-first -BFh --color'    # add colors for filetype recognition
        ;;
esac

if [ "$TERM" == "dumb" ] ; then
   export NODE_NO_READLINE=1
fi

# host-specific interactive settings

alias vce="python ~/local/bin/vce/vce.py"


# ##############################################################################
# Shell Options
# #############

# See man bash for more options...

set -o notify       # Don't wait for job termination notification
set -o ignoreeof    # Don't use ^D to exit
shopt -s nocaseglob # Use case-insensitive filename globbing


shopt -s histappend histreedit histverify   # Make bash history append on disk
#set -o noclobber
#set -o nounset

shopt -s cdspell    # resolve typos in cd
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion  # bash>=2.04 only
shopt -s cmdhist
shopt -s extglob    # necessary for programmable completion

case $- in
  *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
esac

. ~/bash/git-completion.sh

if [ -f ~/bash/.complete ]; then
    . ~/bash/.complete
fi

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoreboth"

# Ignore some controlling instructions
export HISTIGNORE="[   ]*:&:bg:fg:exit"

# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"


# ==========================================

if [ "${OSTYPE:0:5}" = "linux" ]; then
    alias open='kde-open'
fi

alias e='emacs'
alias en='subl -n'
alias quic='git config user.email "tomz@quicinc.com"'
alias caf='git config user.email "tomz@codeaurora.org"'
alias gitwho='git config --get user.email'
alias changeid='scp -P 29418 review-webtech.quicinc.com:hooks/commit-msg .git/hooks/'
alias showfree='df -h | grep "local\|Filesystem"'
#alias lkgr='curl -sS http://chromium-status.appspot.com/lkgr && printf "\n"'
alias lkgr='git ls-remote ssh://review-webtech.quicinc.com:29418/webtech-chrome/chromium/src lkgr | cut -f1'
alias act='source /workspace/venv/venv2/bin/activate'
alias act2='source /workspace/venv/venv2/bin/activate'
alias act3='source /workspace/venv/venv3/bin/activate'
alias deact='deactivate'

alias todo='/opt/todo.txt-cli/todo.sh -t -d $HOME/Dropbox/todo/todo.cfg'
alias todo.sh='/opt/todo.txt-cli/todo.sh -t -d $HOME/Dropbox/todo/todo.cfg'
source /opt/todo.txt-cli/todo_completion
complete -F _todo todo

alias t='subl -n $HOME/Dropbox/todo/todo.txt'
# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias igrep='grep -i'
alias pwd='pwd -P'  # "resolve" symbolic links
#alias pwd='pwd | sed -e "s_/cygdrive/\([a-z]\)_\1:/_g" -e "s_//_/_"'
# alias less='less -r'                          # raw control characters
alias whence='type -a'                          # where, of a sort
alias path='echo -e ${PATH//:/\\n}'
alias print='/usr/bin/lp -o nobanner -d $LPDEST'   # Assumes LPDEST is defined
alias pjet='enscript -h -G -fCourier9 -d $LPDEST'  # Pretty-print using enscript
alias background='xv -root -quit -max -rmode 5'    # Put a picture in the background
#alias top='xtitle Processes on $HOST && top'
#alias make='xtitle Making $(basename $PWD) ; make'

# Some shortcuts for different directory listings
alias ll='ls -B -l'                                # long list
alias la='ls -B -Al'                               # all but . and ..
alias dir='ls -B -Al'              # show hidden files, long format

alias mkdir='mkdir -p'
alias md='mkdir -p'
alias rd='rmdir'

# tailoring 'less'
alias more='less'

# spelling typos - highly personnal :-)
alias dri='dir'
alias idr='dir'
alias di='dir'
alias mkae='make'

alias send='adb shell input text'

# publish markdown to html: pubmd foo.md
alias pubmd='grip --wide --export --gfm'

alias xssh='ssh -X'
alias grimm='ssh grimm.qualcomm.com'

alias cip1='ssh webtech-ci-p1.qualcomm.com'
alias cip2='ssh webtech-ci-p2.qualcomm.com'
alias cip3='ssh webtech-ci-p3.qualcomm.com'
alias cip4='ssh webtech-ci-p4.qualcomm.com'
alias wb01='ssh webtech-bld-01.qualcomm.com'
alias wb02='ssh webtech-bld-02.qualcomm.com'
alias wb03='ssh webtech-bld-03.qualcomm.com'
alias wb04='ssh webtech-bld-04.qualcomm.com'
alias wb05='ssh webtech-bld-05.qualcomm.com'
alias wb06='ssh webtech-bld-06.qualcomm.com'
alias wb07='ssh webtech-bld-07.qualcomm.com'
alias wb08='ssh webtech-bld-08.qualcomm.com'
alias wb09='ssh webtech-bld-09.qualcomm.com'
alias wb10='ssh webtech-bld-10.qualcomm.com'
alias wb11='ssh webtech-bld-11.qualcomm.com'
alias wb12='ssh webtech-bld-12.qualcomm.com'
alias wb13='ssh webtech-bld-13.qualcomm.com'
alias wb14='ssh webtech-bld-14.qualcomm.com'
alias wb15='ssh webtech-bld-15.qualcomm.com'
alias wb16='ssh webtech-bld-16.qualcomm.com'
alias map01='mkdir -p $DEV/wb01 && sshfs tomz@webtech-bld-01:/local/mnt/workspace/webtech/users/tomz $DEV/wb01'
alias map02='mkdir -p $DEV/wb02 && sshfs tomz@webtech-bld-02:/local/mnt/workspace/webtech/users/tomz $DEV/wb02'
alias map03='mkdir -p $DEV/wb03 && sshfs tomz@webtech-bld-03:/local/mnt/workspace/webtech/users/tomz $DEV/wb03'
alias map04='mkdir -p $DEV/wb04 && sshfs tomz@webtech-bld-04:/local/mnt/workspace/webtech/users/tomz $DEV/wb04'
alias map05='mkdir -p $DEV/wb05 && sshfs tomz@webtech-bld-05:/local/mnt/workspace/webtech/users/tomz $DEV/wb05'
alias map06='mkdir -p $DEV/wb06 && sshfs tomz@webtech-bld-06:/local/mnt/workspace/webtech/users/tomz $DEV/wb06'
alias map07='mkdir -p $DEV/wb07 && sshfs tomz@webtech-bld-07:/local/mnt/workspace/webtech/users/tomz $DEV/wb07'
alias map08='mkdir -p $DEV/wb08 && sshfs tomz@webtech-bld-08:/local/mnt/workspace/webtech/users/tomz $DEV/wb08'
alias map09='mkdir -p $DEV/wb09 && sshfs tomz@webtech-bld-09:/local/mnt/workspace/webtech/users/tomz $DEV/wb09'
alias map10='mkdir -p $DEV/wb10 && sshfs tomz@webtech-bld-10:/local/mnt/workspace/webtech/users/tomz $DEV/wb10'
alias map11='mkdir -p $DEV/wb11 && sshfs tomz@webtech-bld-11:/local/mnt/workspace/webtech/users/tomz $DEV/wb11'
alias map12='mkdir -p $DEV/wb12 && sshfs tomz@webtech-bld-12:/local/mnt/workspace/webtech/users/tomz $DEV/wb12'
alias map13='mkdir -p $DEV/wb13 && sshfs tomz@webtech-bld-13:/local/mnt/workspace/webtech/users/tomz $DEV/wb13'
alias map14='mkdir -p $DEV/wb14 && sshfs tomz@webtech-bld-14:/local/mnt/workspace/webtech/users/tomz $DEV/wb14'
alias map15='mkdir -p $DEV/wb15 && sshfs tomz@webtech-bld-15:/local/mnt/workspace/webtech/users/tomz $DEV/wb15'
alias map16='mkdir -p $DEV/wb16 && sshfs tomz@webtech-bld-16:/local/mnt/workspace/webtech/users/tomz $DEV/wb16'

alias mapnet='sshfs webtech-bld-02.qualcomm.com:/net/ /net -o compression=no -o Ciphers=arcfour -o allow_other; sshfs webtech-bld-02.qualcomm.com:/prj/ /prj -o compression=no -o Ciphers=arcfour -o allow_other'
alias unmapnet='sudo umount /net; sudo umount /prj'

function bitly() {
    curl -X GET "https://api-ssl.bitly.com/v3/shorten?access_token=1b3fab542611dd31d4f0dcdc9c6e9ddb059d8ccd&longUrl=$1&format=txt"
}

# fast directory (or ssh) jumps
alias web='cd /Library/WebServer/Documents'

function join() {
    # Thank you, Rob!
    local IFS=${1}
    shift
    printf %s "${*}"
    #[[ $(join / foo bar baz) == foo/bar/baz ]] || echo error: ${0}:${LINENO}
}

function goto() {
    # cd $1/$2
    cd $(join / $@)
}

# inpsired by http://atechnicaltravesty.blogspot.com/2011/05/custom-tab-complete-and-bash-functions.html
__cd_completer() {
    local cur opts dir=${1}
    shopt -s dotglob
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts=$(/bin/ls -d $dir/$cur*/. 2> /dev/null | sed 's|\.$||' | sed "s|$dir/||")
    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
    # For debugging future changes
    #echo
    #echo "---------------------------------------------------------------"
    #echo "dir: $dir"
    #echo "\$COMP_CWORD: $COMP_CWORD"
    #echo "cur: $cur"
    #echo "opts: $opts"
    #echo "---------------------------------------------------------------"
    #echo
}

# Try to figure out a way to use a mapping like this to expand to the
# definitions below
#   .. -> ..
#   dev -> $DEV
#   swe -> $DEV/swe

alias ..='goto ..'
#_..() { __cd_completer ..; }
#complete -o nospace -F _.. ..
_upcompleter() { __cd_completer ..; }
complete -o nospace -F _upcompleter ..

alias work='goto $WORK'
_work() { __cd_completer $WORK; }
complete -o nospace -F _work work

alias tools='goto $TOOLS'
_tools() { __cd_completer $TOOLS; }
complete -o nospace -F _tools tools

alias dev='goto $DEV'
_dev() { __cd_completer $DEV; }
complete -o nospace -F _dev dev

# alias swe='goto $DEV/swe'
# _swe() { __cd_completer $DEV/swe; }
# complete -o nospace -F _swe swe

alias m46='goto $WORK/builds/m46'
_m46() { __cd_completer $WORK/builds/m46; }
complete -o nospace -F _m46 m46

alias m42='goto $WORK/builds/m42'
_m42() { __cd_completer $WORK/builds/m42; }
complete -o nospace -F _m42 m42

KSP_DIR="$HOME/.steam/steam/SteamApps/common/Kerbal Space Program"

alias ksp='cd "$KSP_DIR"'
#_ksp() { __cd_completer $KSP_DIR; }
#complete -o nospace -F _ksp ksp

if [ $TERM == 'xterm' ]
then
    alias clear='clear && printf "\e]50;ClearScrollback\a"' # osx iTerm
else
    alias clear='clear && printf "\e[3J"'  #osx terminal
fi
alias cls='clear'
alias celar='clear'


function nr { # next-resolve
    export current=$(git status -s | grep UU | sed -e "s/^UU //g;" | tail -1) && echo "$(git status -s | grep UU | sed -e 's/^UU //g;' | wc -l) remaining conflicts"
}


function stamp {
    stamp_usage() { echo "stamp: [-r -v -d -s -m msg]" 1>&2; return; }

    local OPTIND o m
    local msg review verified developer_verified submit
    while getopts ":m:rvds" o; do
        case "${o}" in
            s)
                submit="--submit"
                ;;
            r)
                review="--code-review +2"
                ;;
            d)
                developer_verified="--developer-verified +1"
                ;;
            v)
                verified="--verified +1"
                ;;
            m)
                m="${OPTARG}"
                msg="-m \"$m\""
                ;;
            *)
                stamp_usage
                ;;
        esac
    done
    shift $((OPTIND-1))

    echo "ssh -p 29418 webtech-bld-svc@review-webtech.quicinc.com gerrit review $msg $review $verified $developer_verified $submit $*"
    ssh -p 29418 webtech-bld-svc@review-webtech.quicinc.com gerrit review $msg $review $verified $developer_verified $submit $*
}

function whoisin() {
    #myoutput=$(ldapsearch -h ldap.qualcomm.com -p 389 -x -LLL -b "o=qualcomm" "(&(objectclass=group)(cn=$1))" member | grep member | cut -d"=" -f2 | cut -d"," -f1 | sort # | column)
    if [ -t 1 ]
    then
        # stdout is a tty
        ldapsearch -h ldap.qualcomm.com -p 389 -x -LLL -b "o=qualcomm" "(&(objectclass=group)(cn=$1))" member | grep member | cut -d"=" -f2 | cut -d"," -f1 | sort | column
    else
        ldapsearch -h ldap.qualcomm.com -p 389 -x -LLL -b "o=qualcomm" "(&(objectclass=group)(cn=$1))" member | grep member | cut -d"=" -f2 | cut -d"," -f1 | sort
    fi
}

function showgroups() {
    output=$(ldapsearch -h ldap.qualcomm.com -p 389 -x -LLL -b "o=qualcomm" "(&(objectclass=group)(cn=$1))" cn | grep "^cn:" | cut -d" " -f2 | sort)
    if [ -t 1 ]
    then
        # stdout is a tty
        ldapsearch -h ldap.qualcomm.com -p 389 -x -LLL -b "o=qualcomm" "(&(objectclass=group)(cn=$1))" cn | grep "^cn:" | cut -d" " -f2 | sort | column
    else
        ldapsearch -h ldap.qualcomm.com -p 389 -x -LLL -b "o=qualcomm" "(&(objectclass=group)(cn=$1))" cn | grep "^cn:" | cut -d" " -f2 | sort
    fi
}

function pph() {
    if [ $# -eq 0 ]
    then
        open "http://people.qualcomm.com"
    else
        for param in $@
        do
            open "http://people.qualcomm.com/People?query=$param"
        done
    fi
}

function lists() {
    if [ $# -eq 0 ]
    then
        open "http://lists.qualcomm.com"
    else
        for param in $@
        do
            open "http://lists.qualcomm.com/ListManager?query=$param"
        done
    fi
}

function server() {
    if [ $# -eq 0 ]
    then
        screen -S http8080 -d -m python -m SimpleHTTPServer 8080
    else
        for port in $@
        do
            screen -S "http-$port" -d -m python -m SimpleHTTPServer "$port"
        done
    fi
}

function studio() {
    IBUS_ENABLE_SYNC_MODE=1 ibus-daemon -xrd
    screen -S studio -d -m /opt/android-studio/bin/studio.sh
}

# timestamp log output inline
# usage: command | tlog
function tlog() {
    while IFS= read -r line; do
        echo "[$(date +"%F %T")] $line"
    done
}

alias trac='open http://trac.webkit.org/browser/trunk'
alias committers='open http://trac.webkit.org/browser/trunk/Tools/Scripts/webkitpy/common/config/committers.py'
alias salesforce='open https://qualcomm-cdmatech-support.my.salesforce.com/home/home.jsp'

# #################################################################################
# Functions
# #########

alias vimcolors='sudo vi /usr/share/vim/vim74/colors/desert-tomz.vim'


alias fcount='for pid in /proc/[0-9]*/fd; do     echo "$(sudo ls $pid | wc -l) for $pid"; done | grep -v "^0 " | sort -rn | head'

function pycharm()
{
    (nohup /opt/pycharm-5.0/bin/pycharm.sh $@ 1>/dev/null 2>/dev/null &)
}


# Some example functions
# function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

function setjava() {
    sudo update-alternatives --auto java
    sudo update-alternatives --auto javac
    sudo update-alternatives --auto javap
}

function show-caf() {
    open https://www.codeaurora.org/cgit/quic/chrome4sdp/chromium/src/commit/?id=$1
}

function show-gerrit() {
    open https://git-webtech.quicinc.com/cgit/webtech-chrome/chromium/src/commit/?id=$1
}

function show-chromium() {
    open https://chromium.googlesource.com/chromium/src/+/$1
}

function salesforce() {
    open https://qualcomm-cdmatech-support.my.salesforce.com/home/home.jsp
}

function support() {
    #https://qualcomm-cdmatech-support.my.salesforce.com/search/SearchResults?str=01740005
    if [ $# -eq 0 ]
    then
        open https://qualcomm-cdmatech-support.my.salesforce.com/home/home.jsp
    else
        for CASE in $@
        do
            open https://qualcomm-cdmatech-support.my.salesforce.com/search/SearchResults?str=$CASE
        done
    fi
}

function jira() {
    if [ $# -eq 0 ]
    then
        open https://jira-quic.qualcomm.com/jira/secure/Dashboard.jspa
    else
        for ISSUE in $@
        do
            open https://jira-quic.qualcomm.com/jira/browse/$ISSUE
        done
    fi
}

function gerrit() {
    if [ $# -eq 0 ]
    then
        open https://review-webtech.quicinc.com
    else
        for CHANGE in $@
        do
            open https://review-webtech.quicinc.com/#/c/$CHANGE
        done
    fi
}

function sendkeys() {
    echo adb shell input keyboard text '"'$@'"'
}

function runall() {
    local RUN_OR_ECHO= #echo
    for n in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16"
    do
        echo -e "\nwebtech-bld-$n\n==============\n"
        ssh webtech-bld-$n.qualcomm.com ${RUN_OR_ECHO} $@
    done
    for n in "1" "2" "3" "4"
    do
        echo -e "\nwebtech-ci-p$n\n==============\n"
        ssh webtech-ci-p$n.qualcomm.com ${RUN_OR_ECHO} $@
    done
    for n in "1" "2" "3" "4" "5" "6" "7" "8" "9" "1" "11" "12" "13" "14" "15" "16"
    do
        echo -e "\nwebtech-swe-$n\n==============\n"
        ssh webtech-swe-$n.qualcomm.com ${RUN_OR_ECHO} $@
    done
}

function findfree() {
    echo 'Filesystem           Size  Used Avail Use% Mounted on'
    for n in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16"
    do
        ssh webtech-bld-$n.qualcomm.com df -h -l "/local" \| grep "local" \| sed -r -e "s_/dev/sda[0-9]+_webtech-bld-"$n"_g;"
    done
}

function findusage() {
    for n in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16"
    do
        echo -e "\nwebtech-bld-$n\n==============\n"
        ssh webtech-bld-$n.qualcomm.com du -h --max-depth=1 "/local/mnt/workspace/webtech/users" 2\> /dev/null \| grep -v "users$" \| grep "[0-9][0-9]G" \| sort -n -r
    done
}

function findusage2() {
    for n in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16"
    do
        echo -e "\nwebtech-bld-$n\n==============\n"
        if [ $# -eq 0 ]
        then
            ssh webtech-bld-$n.qualcomm.com du -h --max-depth=1 "/local/mnt/workspace/webtech/users" 2\> /dev/null \| grep -v "users$" \| grep "[0-9][0-9]G" \| sort -n -r
        else
            for USER in $@
            do
                ssh webtech-bld-$n.qualcomm.com du -h -s "/local/mnt/workspace/webtech/users/$USER" 2\> /dev/null \| grep -v "users$" \| grep "[0-9][0-9]G" \| sort -n -r
            done
        fi
    done
}

function src {
    treeroot=$(gclient recurse -j1 pwd 2> /dev/null | sort -r | tail -1)
    if [[ "$treeroot" =~ .*/src$ ]]; then
        cd $treeroot
    else
        echo $treeroot
    fi
}

function q()
{
    printf '%q' "$@"
}

# launch gui progrom from the command line without blocking or dropping text in the console
function run()
{
    ($@ 1>/dev/null 2>/dev/null &)
}

#function salesforce() {
#    run firefox https://qualcomm-cdmatech-support.my.salesforce.com/home/home.jsp
#}

function tmacs()
{
    #(/Applications/Emacs.app/Contents/MacOS/Emacs "$@" &);
    unset DISPLAY
    /usr/bin/emacs $@
}

function builds() {
    local bld
    for pattern in "$@"; do
        bld="$bld*$pattern"
    done
    bld="$bld*"
    ls -d --indicator-style=none //qcdfs/qct/builds-sd/builds/prod/*/*$bld* 2>&1 | grep -v "No such file or directory" | grep "/"
    ls -d --indicator-style=none //qcdfs/qct/builds-sd/builds/test/*/*$bld* 2>&1 | grep -v "No such file or directory" | grep "/"
}

if [ -f ~/bash/.func ]; then
    . ~/bash/.func
fi

#pathprompt     # choose fastprompt or powerprompt
#fastprompt
gitprompt

# Enable bash completion for the swe command
eval "$(register-python-argcomplete swe)"

#if [ $EMACS ]; then
#  # Emit the PWD in the prompt, taking care that it doesn't
#  # get truncated.
#  PS1='%30000<<|Pr0mPT|%0d|[%n@%m]%~%# '
#  # my default terminal, 'dumb', keeps resetting the COLUMNS value
#  # all the time, which triggers zsh to truncate the prompt anyway.
#  COLUMNS=30000
#fi


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


PERL_MB_OPT="--install_base \"/home/tomz/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/tomz/perl5"; export PERL_MM_OPT;

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
