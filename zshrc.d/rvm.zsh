# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [[ -d "$HOME/.rvm/bin" ]]; then
    path=("$HOME/.rvm/bin" $path)
fi
