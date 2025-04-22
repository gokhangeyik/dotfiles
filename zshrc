#use a history file in here
HISTFILE=~/.zsh_history
SAVEHIST=1000000
HISTSIZE=1000000
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

alias history="history 0"

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.krew/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
export BW_SESSION=$(kwallet-query -r BW_SESSION -f Bitwarden kdewallet)
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
# export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=true
export STARSHIP_CONFIG=~/.config/starship.toml
# export CONDA_CHANGEPS1=False
export EDITOR="nvim"
export VISUAL="nvim"


source /usr/share/zsh-antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

autoload -Uz compinit && compinit
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# # FZF Catppuccin Mocha
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
# --color=selected-bg:#45475a \
# --multi"
# FZFTokyo Night
# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
#   --highlight-line \
#   --info=inline-right \
#   --ansi \
#   --layout=reverse \
#   --border=none
#   --color=bg+:#283457 \
#   --color=bg:#1a1b26\
#   --color=border:#27a1b9 \
#   --color=fg:#c0caf5 \
#   --color=gutter:#16161e \
#   --color=header:#ff9e64 \
#   --color=hl+:#2ac3de \
#   --color=hl:#2ac3de \
#   --color=info:#545c7e \
#   --color=marker:#ff007c \
#   --color=pointer:#ff007c \
#   --color=prompt:#2ac3de \
#   --color=query:#c0caf5:regular \
#   --color=scrollbar:#27a1b9 \
#   --color=separator:#ff9e64 \
#   --color=spinner:#ff007c \
# "
# Kanagawa FZF
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#1F1F28 \
  --color=bg:#1F1F28 \
  --color=border:#54546D \
  --color=fg:#DCD7BA \
  --color=gutter:#1F1F28 \
  --color=header:#FFA066 \
  --color=hl+:#7FB4CA \
  --color=hl:#7FB4CA \
  --color=info:#545c7e \
  --color=marker:#D27E99 \
  --color=pointer:#D27E99 \
  --color=prompt:#938AA9 \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#7FB4CA \
  --color=separator:#FFA066 \
  --color=spinner:#D27E99 \
"
# Rose Pine
# export FZF_DEFAULT_OPTS=" \
#   --color=fg:#908caa,bg:#191724,hl:#ebbcba \
#   --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba \
#   --color=border:#403d52,header:#31748f,gutter:#191724 \
#   --color=spinner:#f6c177,info:#9ccfd8 \
#   --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
#
#
function gi(){
    curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ | awk '(!/^#/) && (NF)' ;
}

function repoclean() {
   git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
}

alias ls='eza --icons -l'
alias ll='eza --icons -al'
alias lt='eza --icons -lTg'
alias -g k='kubectl'
alias t='tmux'
alias top='btop'
alias vim='nvim'
alias vi='nvim'
alias docker="podman"
alias gcli='docker run --net=host --rm -it -v $HOME:/home/gokko registry.kodzilla.net/gokko-cli/gokko-cli:latest zsh'
alias argo="docker run --net=host --rm -it -v $HOME:/home/gokko registry.kodzilla.net/gokko-cli/gokko-cli:latest argo"
alias basedpyright="docker run --net=host --rm -it -v $HOME:/home/gokko registry.kodzilla.net/gokko-cli/gokko-cli:latest basedpyright"
alias release-please="docker run --net=host --rm -it -v $HOME:/home/gokko registry.kodzilla.net/gokko-cli/gokko-cli:latest release-please"

alias ollama="podman exec -it ollama ollama"
alias devpod="devpod-cli"

# bindkey -s '^F' 'tmux-sessionzer\n'
bindkey '^R' history-incremental-search-backward
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(flux completion zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(tms --generate zsh)"


# tmux has-session -t=0 2> /dev/null
# if [[ $? -ne 0 ]]; then
#   TMUX='' tmux new-session -d -s "0"
# fi
# if [[ -z "$TMUX" ]]; then
#   tmux attach -t "0"
# else
#   tmux switch-client -t "0"
# fi
