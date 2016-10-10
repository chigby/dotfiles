# -*- mode: shell-script -*-

export DOTFILES_ROOT="$HOME/git/dotfiles"

# Additional function path:
if [ -d "$DOTFILES_ROOT"/zshrc.d/functions ]; then
    fpath=("$DOTFILES_ROOT"/zshrc.d/functions $fpath)
fi

# Set custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt chn

path=(~/bin /usr/local/bin /opt/local/bin /opt/local/sbin $path /bin /usr/bin /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin /opt/local/libexec/perl5.12/sitebin /usr/local/texlive/2013/bin/x86_64-darwin)
#WORDCHARS="${WORDCHARS:s#/#}"

for file in "$DOTFILES_ROOT"/functions/*; do
  source "$file"
done

for file in "$DOTFILES_ROOT"/zshrc.d/*.zsh; do
  source "$file"
done

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
