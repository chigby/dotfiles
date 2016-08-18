# make zsh globbing more compatible with git's ^ shortcut
# see https://github.com/robbyrussell/oh-my-zsh/issues/449
unsetopt nomatch

# higher util word characters
export WORDCHARS='*?[]~&;!$%^<>'
