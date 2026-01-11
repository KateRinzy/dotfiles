alias vim="nvim"

alias ff="fastfetch"

alias p="python"

alias mutt="neomutt"

alias chat="nvim ~/notes/chat"
alias zxcv="nvim ~/notes/zxcv"

alias ls="eza --no-quotes -s type"

alias t="tmux-goway"

alias e="exit"
alias q="exit"
alias wq="exit"
alias s="cd"
alias r="yazi"
alias ..="cd .."
alias rel="omz reload"

alias g="git"
alias gs="git status"
alias ga="git add ."
alias gd="git diff"
alias gc="git commit"
alias gcm="git commit -m"
alias gac="git commit -a"
alias gacm="git commit -am"
alias gpush="git push"
alias gpull="git pull"
alias gstat="git log --graph --stat"

alias maple="~/maple2022/bin/xmaple"

psk() {
    for str in "$@"; do
        printf "%-15s %.2f GB\n" "$str" "$(ps -o rss= -p $(pgrep $str) | awk '{s+=$1} END {print s / (1024*1024)}')"
    done
}

_twink_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=()

    # directories (unfiltered)
    COMPREPLY+=($(compgen -d -- "$cur"))

    # .typ files only
    COMPREPLY+=($(compgen -f -X '!*.typ' -- "$cur"))
}

complete -o filenames -F _twink_complete twink

tl() {
    tmux list-sessions
}

vfz() {
    selected=$(fzf) || return
    realselected=$(realpath -- "$selected")
    print -s "vim $realselected"
    nvim "$selected"
}

open() {
    xdg-open $1 >/dev/null 2>&1 &
    disown
}

openf() {
    selected=$(fzf)
    open "$selected"
}

battery() {
    upower -i /org/freedesktop/UPower/devices/battery_BAT0 |
        awk '/state:/ { s=$2 } /percentage:/ { p=$2 } END { print p " (" s ")" }'
}

y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"

    IFS= read -r -d '' cwd <"$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && cd -- "$cwd"
    rm -f -- "$tmp"
}
