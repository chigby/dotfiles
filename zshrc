# -*- mode: shell-script -*-

# Set custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt grb

path=(~/bin /usr/local/bin /opt/local/bin /opt/local/sbin $path /bin /usr/bin /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin /opt/local/libexec/perl5.12/sitebin /usr/local/texlive/2013/bin/x86_64-darwin /Applications/Postgres.app/Contents/Versions/9.4/bin)
#WORDCHARS="${WORDCHARS:s#/#}"

export DOTFILES_ROOT="$HOME/git/dotfiles"

for file in "$DOTFILES_ROOT"/functions/*; do
  source "$file"
done

for file in "$DOTFILES_ROOT"/zshrc.d/*; do
  source "$file"
done

# Additional function path:
if [ -d ~/.zfunc ]; then
    fpath=(~/.zfunc $fpath)
fi
