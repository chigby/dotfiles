# make zsh globbing more compatible with git's ^ shortcut
# see https://github.com/robbyrussell/oh-my-zsh/issues/449
unsetopt nomatch

# modify word chars to exclude certain characters to easier editing
# with backward-word-kill and similar commands:
# "/" so we don't remove entire paths at once
# "." for finer-grained address/extension manipulation
# "_" and "-" for delimited words within filenames
# "(){}" for shell scripts in-line
# "=" for defining environment variable values
# "~" since it appears in many paths
export WORDCHARS='*?[]~&;!#$%^<>'
