# Path to oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="simple"
COMPLETION_WAITING_DOTS="true"

plugins=(bundler)

# User configuration
source $ZSH/oh-my-zsh.sh

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

# Aliases
alias ls="ls -FG"
alias l="ls -l"
alias la="ls -la"
alias evim='nvim ~/.vimrc'
alias svim='source ~/.zshrc'
alias gp='git push'
alias b="bundle"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias v="nvim"
alias vim="nvim"

# Don't attempt spelling autocorrect
unsetopt correct_all

# fuzzy find
source <(fzf --zsh)
# export FZF_DEFAULT_COMMAND="alias ag='ag . --follow'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# Always in tmux
_not_inside_tmux() { 
  [[ -z "$TMUX" ]] 
}
ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}
ensure_tmux_is_running

# Optimize Ollama for M4 Pro
export OLLAMA_NUM_PARALLEL=2
export OLLAMA_MAX_LOADED_MODELS=2
export OLLAMA_FLASH_ATTENTION=1
