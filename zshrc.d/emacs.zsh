[[ $TERM == "dumb" ]] && unsetopt zle && PS1='%~ $ '
[[ $EMACS = t ]] && unsetopt zle

# See :http://stackoverflow.com/questions/3508387/how-can-i-have-term-el-ansi-term-track-directories-if-using-anyhting-other-than
if [ "$TERM" = "eterm-color" ]; then
    chpwd() { print -P "\033AnSiTc %d" }

    print -P "\033AnSiTu %n"
    print -P "\033AnSiTc %d"
    export TERM=xterm
fi
