alias vim="nvim"

alias ff="fastfetch"

alias mate="make"

alias paru="yay"

alias chat="nvim ~/desk/chat.typ"
alias zxcv="nvim ~/desk/zxcv.typ"

alias ls="eza -A1 -s type"

alias e="exit"
alias q="exit"
alias wq="exit"
alias s="cd"
alias r="ranger"
alias ..="cd .."
alias rel="omz reload"

alias rin="tmux-sessionizer $WORKSTATION"
alias whore="tmux-sessionizer $HOME"
alias why="tmux-sessionizer $HOME/Documents"

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

alias maple="~/maple2022/bin/xmaple" # should maybe put this in $PATH i suppose, too lazy to do that

psk() {
    for str in "$@"; do
        printf "%-15s %.2f GB\n" "$str" "$(ps -o rss= -p $(pgrep $str) | awk '{s+=$1} END {print s / (1024*1024)}')"
    done
}

t() {
    if [ -z "$1" ]; then
        tmux-sessionizer $(pwd)
    else
        tmux-sessionizer "$(realpath $1)"
    fi
}
complete -o dirnames t

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
    selected=$(fzf)
    command nvim "$selected"
}

open() {
    xdg-open $1 >/dev/null 2>&1 &
    disown
}

openf() {
    selected=$(fzf)
    open "$selected"
}

cursor() {
    command cursor --enable-features=UseOzonePlatform --ozone-platform=wayland "$@" >/dev/null 2>&1 &
}

battery() {
    upower -i /org/freedesktop/UPower/devices/battery_BAT0 |
        awk '/state:/ { s=$2 } /percentage:/ { p=$2 } END { print p " (" s ")" }'
}

y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"

    IFS= read -r -d '' cwd <"$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && tmux -- "$cwd"
    rm -f -- "$tmp"
}
