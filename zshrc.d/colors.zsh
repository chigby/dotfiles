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
# PS1="$PR_LIGHT_YELLOW(%D{%H:%M})$PR_NO_COLOR [$PR_BLUE%n$PR_NO_COLOR@$PR_GREEN%m$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "