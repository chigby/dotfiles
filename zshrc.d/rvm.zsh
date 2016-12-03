# This loads RVM into a shell session.
if [[ -d "$HOME/.rvm/bin" ]]; then
    path=("$HOME/.rvm/bin" $path)
fi

function _activate_rvm () {
  unalias rvm

  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
  # Load RVM into a shell session *as a function*
}

# lazy load
alias rvm='_activate_rvm; rvm'
