eval "$(starship init zsh)"
source <(kubectl completion zsh)
autoload -Uz compinit && compinit
