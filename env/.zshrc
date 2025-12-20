export ZSH="$HOME/.oh-my-zsh"

export GPG_TTY=$(tty)

export EDITOR="nvim"
export VISUAL="$EDITOR"
export MAKEFLAGS="-j12"
export NPROCESSORS_CONF="12"

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/desk/dotfiles/scripts:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"

export WORKSTATION="$HOME/desk/dotfiles"

ZSH_THEME="robbyrussell"

plugins=(
    git
    fzf-tab
    battery
)

source $ZSH/oh-my-zsh.sh


[ -f ~/.aliases.sh ] && source ~/.aliases.sh

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' %F{cyan}[%f%F{red}%b%f%F{cyan}]%f'

setopt PROMPT_SUBST
# %F{yellow};%f
PROMPT='%(?.%F{green}>.%F{red}>)%f %F{cyan}[%f%F{blue}%~%f%F{cyan}]%f${vcs_info_msg_0_}
%F{yellow}%%%f '

# [[ ! -r '/home/kate/.opam/opam-init/init.zsh' ]] || source '/home/kate/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null

bindkey -s ^t "^utmux-sessionizer\n"
bindkey -s ^y "^uyazi-tmux\n"
bindkey -s ^f "^uvfz\n"
# bindkey -s ^e "^ucode .\n" # maybe shouldn't use this, i keep accidentally pressing it, should use some other keybind
bindkey -s ^q "^ukitty sh -c ranger\n"


zstyle ':completion:*:(vim|nvim):*' ignored-patterns '*.pdf'
# [ -f "/home/kate/.ghcup/env" ] && . "/home/kate/.ghcup/env" # ghcup-env

# eval $(thefuck --alias)
