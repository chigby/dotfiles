# setopt NOHUP
# setopt NOTIFY
# setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST		# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME		# tries to resume command of same name
unsetopt BG_NICE		# do NOT nice bg commands
setopt EXTENDED_HISTORY		# puts timestamps in the history
# setopt HASH_CMDS		# turns on hashing
#
unsetopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset  shell options
setopt   notify globdots pushdtohome autolist
unsetopt cdablevars correct_all # for some reason setting this puts users in my cd completion
setopt   autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
#zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfil
zmodload -a zsh/mapfile mapfile

precmd () { }

path=(~/bin /usr/local/bin /opt/local/bin /opt/local/sbin $path /bin ~/svn/trunk/code/local /usr/bin /opt/awutil /opt/awbin /opt/local/Library/Frameworks/Python.framework/Versions/2.6/bin)
TZ="America/New_York"
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="`hostname`"
PAGER='less'
EDITOR='emacsclient'
ALTERNATE_EDITOR="emacs -Q"
WORDCHARS="${WORDCHARS:s#/#}"
    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="$PR_LIGHT_YELLOW(%D{%H:%M})$PR_NO_COLOR [$PR_BLUE%n$PR_NO_COLOR@$PR_GREEN%m$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
if [[ $USER == "cameronh" ]]; then
    if [[ $HOSTNAME == "macbook" ]]; then
        PS1="$PR_LIGHT_YELLOW(%D{%H:%M})$PR_NO_COLOR $PR_RED%2c$PR_NO_COLOR %(!.#.$) "
    fi
fi

#LANGUAGE=
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C

[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '
[[ $EMACS = t ]] && unsetopt zle

# See :http://stackoverflow.com/questions/3508387/how-can-i-have-term-el-ansi-term-track-directories-if-using-anyhting-other-than
if [ "$TERM" = "eterm-color" ]; then
    chpwd() { print -P "\033AnSiTc %d" }

    print -P "\033AnSiTu %n"
    print -P "\033AnSiTc %d"
    export TERM=xterm
fi

if [ $SSH_TTY ]; then
  MUTT_EDITOR=emacs
else
  MUTT_EDITOR=emacsclient.emacs-snapshot
fi

unsetopt ALL_EXPORT

# Source aliases.
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

if [ -f ~/.aliases-aw ]; then
    . ~/.aliases-aw
fi

autoload -U compinit
compinit
bindkey "^?" backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

bindkey '^X\b' backward-kill-word

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps ax -o pid,s,nice,stime,args | sed "/ps/d"'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e "s/,.*//g" | uniq | grep -v "\["`;)
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# Additional function path:
if [ -d ~/.zfunc ]; then
    fpath=(~/.zfunc $fpath)
fi

# Complete packages.
[ -d ~/svn/packages ] && compctl -g "~/svn/packages/*/(:t)" pkg
[ -d /opt/packages ] && compctl -g "/opt/packages/*/(:t)" pkg

# Set an auto-logout for critical servers or root sessions.
case "$HOSTNAME" in
    dev*)
        export SERVERTYPE='dev'
        ;;
    *)
        export SERVERTYPE='critical'
        ;;
esac


# Set auto-logout in seconds.
if [ "`id -u`" -eq 0 ] || [[ "$SERVERTYPE" == critical ]]; then
   # 15 min timeout
   TMOUT=900
fi

# Initiate screen.
if [ -n "$SSH_TTY" ]; then
    if [[ "$TERM" != screen* ]]; then
        if which screen > /dev/null; then
            screen -xRR && [ ! -e /tmp/stayloggedin ] && exit
            [ -e /tmp/stayloggedin ] && rm -f /tmp/stayloggedin
        fi
    else
        [ -f /etc/motd ] && [ "$EUID" != 0 ] && cat /etc/motd
    fi
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
