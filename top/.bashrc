#!/bin/bash

alias cls='clear'

for D in \
    /local/mnt/workspace/webtech/users/tomz \
    /local/mnt/workspace/tomz \
    /local/mnt/workspace \
    /workspace \
    /work \
    /usr/local/develop
do
  if [ -d "$D" ]; then
    export WORK="$D"
    break
  fi
done

export TOOLS=$WORK/tools

for P in \
    /usr/local/bin \
    $HOME/local/bin \
    $HOME/bin \
    $HOME/bin/osx \
    /opt/local/sbin \
    /opt/local/bin \
    /opt/local/libexec/gnubin \
    /prj/qct/asw/qctss/linux/bin \
    $WORK/ssg_automation/docker_config \
    $TOOLS/ssg_automation/docker_config \
    $HOME/.cargo/bin


do
    if [ -d "$P" ] ; then export PATH="$P:$PATH" ; fi
done


export EDITOR=vim

if [ -f "/local/mnt/workspace/tz/.repo/repo/repo" ]; then
  alias repo='/local/mnt/workspace/tz/.repo/repo/repo'
fi

export P4PORT=qctp401:1666
export P4USER=tomz
export P4MERGE=p4merge
export P4CONFIG=.p4
export SSGBIN='/prj/qct/asw/qctss/linux/bin'
export TOOLS=$WORK/tools
export SSGAUTO=$TOOLS/ssg-automation
export PYTHONPATH=$PYTHONPATH:$SSGAUTO
export PATH=$PATH:$SSGAUTO/bin
export PERL5LIB=$PERL5LIB:~/bin:~/perl5/lib/perl5

export HISTCONTROL=erasedups:ignoreboth
export HISTSIZE=5000

alias open="kde-open"
alias spincrm='python /local/mnt/workspace/tomz/tools/ssg-automation/integration/crmtools/SpinCRM.py'
alias wpath='pwd | sed -e "s:^/local/mnt/workspace://tomz-ubuntu/workspace:g;" | tr "/" "\\\\"'
alias lpath='pwd | sed -e "s:^/local/mnt/workspace:/net/tomz-ubuntu/local/mnt/workspace:g;"'

function attest_all() {
    if [ $# -eq 1 ]
    then
        FindBuild -in linuxpath $1 | grep "/snowcone" | xargs -I '{}' find '{}'/trustzone_images/build/ms -name tz.mbn | xargs strings | grep -i attest
    elif [ $# -eq 2 ]
    then
        FindBuild -in linuxpath $1 | grep "/snowcone" | xargs -I '{}' find '{}'/trustzone_images/build/ms -name $2 | xargs strings | grep -i attest
    else
        echo "Provide a build ID and optionally an mbn name"
    fi
}

function attest() {
    if [ $# -eq 1 ]
    then
        FindBuild -in linuxpath $1 | grep "/snowcone" | xargs -I '{}' find '{}'/trustzone_images/build/ms -name tz.mbn | tail -1 | xargs strings | grep -i attest
    elif [ $# -eq 2 ]
    then
        FindBuild -in linuxpath $1 | grep "/snowcone" | xargs -I '{}' find '{}'/trustzone_images/build/ms -name $2 | tail -1 | xargs strings | grep -i attest
    else
        echo "Provide a build ID and optionally an mbn name"
    fi
}

function target_main_plf() {
    if [ $# -eq 1 ]
    then
        FindBuild -in linuxpath $1 | grep "/snowcone" | xargs -I '{}' ls '{}'/target_main.plf
    else
        echo "Provide a build ID"
    fi
}

alias da='/pkg/qct/software/llvm/release/arm/3.7.6/bin/llvm-objdump -D'
elffunc() { da $1 | grep ":$" | sort; }

alias harv='ssh -X tomz-ubuntu'
alias irc='irssi'
alias vce='python /prj/qct/asw/qctss/linux/bin/vce/vce.py'
alias banner='figlet -f banner'
alias mycharm='nohup /opt/pycharm-community-2018.1.1/bin/pycharm.sh </dev/null >/dev/null 2>&1 &'

alias ls='ls --group-directories-first -F --color'
alias la='ls -aF --color'
alias ll='ls -lF --color'
alias dir='ls -alF --color'
alias dri='ls -alF --color'

alias quic='git config --global user.email "tomz@quicinc.com"'
alias qti='git config --global user.email "tomz@qti.qualcomm.com"'
alias caf='git config --global user.email "tomz@codeaurora.org"'
alias gitwho='git config --get user.email'
alias showfree='df -h | grep " /local\|Filesystem"'

alias apps='find `pwd`/out -name *.apk | grep -v "\-un"'
alias engbuilds='cd /prj/qct/webtech/archive02/webtech-devx/RELEASES/swe/engbuilds/'

newssgauto() { git clone ssh://review-android.quicinc.com:29418/ssg/automation $1; cd $1; source ./setenv.sh; gitdir=$(git rev-parse --git-dir); scp -p -P 29418 `whoami`@review-android.quicinc.com:hooks/commit-msg ${gitdir}/hooks/; git checkout -b dev; }

alias lkgr='git ls-remote ssh://review-webtech.quicinc.com:29418/webtech-chrome/chromium/src lkgr | cut -f1'

export GYP_CHROMIUM_NO_ACTION=1 # don't process gyp
export CHROME_HEADLESS=1 # don't prompt for EULA

# black:   30       dark gray:     90
# red:     31       light red:     91
# green:   32       light green:   92
# yellow:  33       light yellow:  93
# blue:    34       light blue:    94
# magenta: 35       light magenta: 95
# cyan:    36       light cyan:    96
# gray:    37       white:         97


#export LS_COLORS='rs=0:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;30:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
#export LS_COLORS='rs=0:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;30';
export LS_COLORS='rs=0:di=01;94:ln=01;33:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;43:ow=30;43:st=37;44:ex=37';

#[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"

# Execute $@ as a command in a shell with build/android/envsetup.sh
# set up environment variables set.  This is useful when trying to keep a
# shell clean for other uses while working in Chromium
#function cba()
#{
#     declare src=${CHROME_SRC}
#     if [[ -n ${src} && ${src:${#src}-1} != / ]]
#     then
#         src=${src}/
#     fi
#
#     if ! [[ -f ${src}build/android/envsetup.sh ]]
#     then
#         echo Error: either set CHROME_SRC or run from CHROME_SRC
#         return 1
#     fi
#
#     # envsetup eats ${@}, so save it....
#     declare -a _run=( "${@}" )
#     (
#         . ${src}build/android/envsetup.sh
#         "${_run[@]}"
#     )
#}


[[ -f /local/mnt/workspace/webtech/ccache/ccacherc ]] && . /local/mnt/workspace/webtech/ccache/ccacherc


alias sv='sudo su webteksv'

function winmount() {
    # args are $1 = unix-style UNC path, $2 = local mount folder
    sudo mount -t cifs $1 $2 -o userid=`whoami`,dir_mode=0777,file_mode=0777
}

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

alias ..='goto ..'
alias dev='goto /usr/local/develop'
alias webtech='goto /prj/qct/webtech/archive02/users/tomz'
alias workspace="goto $WORK"
alias work="goto $WORK"
alias builds="goto $WORK/builds"
alias tools="goto $TOOLS"
alias users='goto /local/mnt/workspace/webtech/users'
alias fucking='sudo '
alias doit='$(history -p !!)'
# Misc :)
#alias emacs='runemacs'
#alias lua='cmd /c c:\\luarocks\\0.5.2\\lua5.1.exe -lluarocks.require'
#alias rocks='c:/luarocks/0.5.2/luarocks.bat'
alias cls='clear'


alias wokr=work

function approve() {
    if [ $# -eq 0 ]
    then
        echo "try approve TZ.XF.5.0-01600-S845AAAAANAZT-1 (or another software image build)"
    else
        for param in $@
        do
            #open "https://tiberium.qualcomm.com/BA/Index/$param"
            echo "https://tiberium.qualcomm.com/BA/Index/$param"
        done
    fi
}

function manage() {
    if [ $# -eq 0 ]
    then
        echo "try manage core.tz.1.0 (or another package warehouse)"
    else
        for param in $@
        do
            open "https://pw.qualcomm.com/index.php?p=sysadmin&a=manage_warehouse&pwname=$param"
        done
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


alias trac='open http://trac.webkit.org/browser/trunk'
alias committers='open http://trac.webkit.org/browser/trunk/Tools/Scripts/webkitpy/common/config/committers.py'

# #################################################################################
# Functions
# #########

# Some example functions
function title() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

function jira() {
    if [ $# -eq 0 ]
    then
        open https://jira.qualcomm.com/jira/secure/Dashboard.jspa
    else
        for ISSUE in $@
        do
            open https://jira.qualcomm.com/jira/browse/$ISSUE
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

function findfree() {
    echo 'Filesystem           Size  Used Avail Use% Mounted on'
    for n in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
    do
        ssh webtech-bld-$n.qualcomm.com df -h -l "/local" \| grep "local" \| sed -e "s_/dev/sda6_webtech-bld-"$n"_g;"
    done
}

function findusage() {
    for n in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
    do
        echo -e "\nwebtech-bld-$n\n==============\n"
        ssh webtech-bld-$n.qualcomm.com du -h --max-depth=1 "/local/mnt/workspace/webtech/users" 2\> /dev/null \| grep -v "users$" \| grep "[0-9][0-9]G" \| sort -n -r
    done
}

function findusers() {
    for n in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16"
    do
        echo -e "\nwebtech-bld-$n\n==============\n"
        ssh webtech-bld-$n.qualcomm.com who
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

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ("${ref#refs/heads/}")"
}

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

PS1="\u@\h:\w\$(parse_git_branch)\$ "
#tomz@webtech-bld-02:/prj/qct/webtech/archive02/users/tomz/validate$


alias gcstat='for p in $(gclient revinfo | grep -v ": None" | cut -d":" -f1 | sed -e "s%^src%.%g"); do echo $p; git --work-tree=$p --git-dir=$p/.git status --porcelain | sed -e "s%^\([^\.]\)%   \1%"; done | grep --no-group-separator -B1 "^   "'
alias gcheads='for p in $(gclient revinfo | grep -v ": None" | cut -d":" -f1 | sed -e "s%^src%.%g"); do ref=$(git --work-tree=$p --git-dir=$p/.git symbolic-ref HEAD 2> /dev/null) && echo $p:${ref#refs/heads/} ; done'

PERL_MB_OPT="--install_base \"/usr2/tomz/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/usr2/tomz/perl5"; export PERL_MM_OPT;


alias vce='/prj/qct/asw/qctss/linux/bin/vce/vce.py'
alias p4diff2='p4 diff2 -q '
alias f='/prj/qct/asw/qctss/linux/bin/FindBuild'
alias fl='/prj/qct/asw/qctss/linux/bin/FindBuild -lo'

#source /local/mnt/workspace/tomz/setenv.sh
#cd /local/mnt/workspace/tomz/builds

# added by Anaconda2 4.2.0 installer
export PATH="/local/mnt/workspace/anaconda2/bin:$PATH"

