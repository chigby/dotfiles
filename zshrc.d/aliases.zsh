# -*- mode: shell-script -*-
alias man='LC_ALL=C LANG=C man'
alias f=finger
alias ll='ls -alh'
alias la='ls -a'

if [[ $(uname -s) == 'Darwin' ]]; then
    alias ls='ls -FGsk'
else
    alias ls='ls -Fsk --color'
fi

# Directory navigation, e.g.:
# cd by .. or ... or ... or mv file ..../.
alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

if command_exists exa; then
    alias e="exa"
    alias el="exa -l"
fi

alias svnst="svn --ignore-externals status | grep ^[ACDGMR?]"
alias svndi="svn diff|colordiff"

alias portup='sudo port selfupdate && sudo port upgrade outdated'
alias portc="sudo port clean --all installed"
alias portuni="sudo port uninstall inactive"

alias sdf='ssh tty.sdf.org -l chigby'
alias sverige='ssh sverige.freeshell.org -l chigby'
alias svalbard='ssh svalbard.freeshell.org -l chigby'
alias otaku='ssh otaku.freeshell.org -l chigby'
alias iceland='ssh iceland.freeshell.org -l chigby'

alias j='jobs'
alias s='sudo -s'
alias xterm='xterm -fa Monaco -fs 11 &'
alias df='df -h'
alias du='du -h'

alias thes='dict -d moby-thes'
alias wcopy='wget --adjust-extension --span-hosts --convert-links --backup-converted --page-requisites --no-clobber'
alias ytd="youtubedown.pl --progress"

alias dstopall='docker stop $(docker ps -a -q)'

# find all installed packages that depends on a given package.
function rdep () {
    apt-cache rdepends $1|sed '1,2d'|sort|uniq|xargs apt-cache policy |grep "Installed: [0-9]" -B1
}

function tng() {
    subcommand=$1
    revfile=~/Documents/tng/tng_all.tar.bz2
    if [[ $subcommand == 'rev' ]]; then
        file="$2.rev"
        gnutar -xjvOf $revfile $file | less
    elif [[ $subcommand == 'search' ]]; then
        term=$2
        gnutar -tf $revfile | grep $term
    elif [[ $subcommand == 'help' ]]; then
        echo "Available subcommands:"
        echo "tng rev [name] -- Display review with name [name]."
        echo "tng search [name] -- List review names matching [name]."
        echo "tng help -- Display this help."
    else
      echo "Subcommand '$subcommand' not found."
    fi
}

alias vless='vim -u /usr/share/vim/vim71/macros/less.vim'

alias dnsreset='sudo launchctl stop org.macports.dnsmasq && sudo launchctl start org.macports.dnsmasq && sudo dscacheutil -flushcache'

###
# functions
###

# Human readable mtime of file(s).
lmod () {
    if test -n "$1"; then
        td $(( `date '+%s'` - `stat -f '%m' "$1"` )) | sed "s#^#$1    modified #" | sed 's/$/ ago/'
    else
      lines=$(while read line; do echo "$line"; done)
      longest=$(echo $lines | awk '{print length(), $0 | "sort -nr"}' | head | awk '{print $1}' | head -n1)
    for line in $(echo $lines | xargs); do
      lmod "$line" | awk "{printf \"%-${longest}s    %s\n\", \$1,\$2}" FS='    '
    done
    fi
}

decruft () {
    for ext in .pyc \~; do
      rm -f **/*$ext(N)
    done
}

# Colorize tail output for log monitoring.
ctail () {
    tail "$@" | perl -pe 'sub c {%c=("ERROR",31,"INFO",32,"DEBUG",36,"WARNING",33,"CRITICAL",35);"\e[1;".$c{@_[0]}."m".@_[1]}s/.*\b(ERROR|WARNING|CRITICAL|DEBUG|INFO)\b.*/c($1,$&)/ge;'
}

# Strip ANSI formatting from text
function noansi () {
    perl -pe "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

# Convert epoch timestamp to human readable format
function epoch2date() {
    `date --version &> /dev/null` && DATEVER=gnu || DATEVER=bsd
    if test -n "$1"
    then
        if [[ "$DATEVER" = bsd ]]; then
            date -r "$1"
        else
          date -d "1970-01-01 $1 sec GMT"
        fi
    else
      while read line
      do
        if [[ "$DATEVER" = bsd ]]; then
            date -r "$line"
        else
          date -d "1970-01-01 $line sec GMT"
        fi
      done
    fi
}

function irssi () {
    if [[ $TERM != xterm-color ]]; then
        TERM=xterm-color
    fi
    /opt/local/bin/irssi
    TERM=xterm
}

# https://gist.github.com/1525217
#alias server='open http://localhost:8000 && python -m SimpleHTTPServer'
function server() { # via https://gist.github.com/1525217
  local host="localhost"
  local port="${1:-8888}"
  (sleep 1 && open "http://${host}:${port}/")&
  python -m http.server "$port"
}

#alias mkwhitelist='cat ~/Mail/* /var/mail/chigby |grep -iv -f ~/badheaders.txt |egrep -oi '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\b'|tr "A-Z" "a-z"|sort|uniq > ~/.whitelist'

alias pserve="`which php` -S 127.0.0.1:8080"

alias love="/Applications/love.app/Contents/MacOS/love"

p() {
    cd $(find ~/projects ~/fpf ~/git ~/hg -maxdepth 1 -type d | selecta)
}

if ! command_exists pbpaste && command_exists xclip; then
    alias pbpaste='xclip -selection clipboard -o'
fi

if ! command_exists pbcopy && command_exists xclip; then
    alias pbcopy='xclip -selection clipboard'
fi

finame() { find . -iname "*$1*"; }

if [ -f /Applications/VLC.app/Contents/MacOS/VLC ]; then
    alias vlc="/Applications/VLC.app/Contents/MacOS/VLC -I rc"
fi

alias oldshot='find ~/Pictures -maxdepth 1 -iname "Screenshot*" -ctime +7 -exec mv -t ~/Pictures/old-screenshots {} +'

# requires "npm install -g tiddlywiki"
alias tiddly="tiddlywiki ~/Dropbox/codex --server 8009"
