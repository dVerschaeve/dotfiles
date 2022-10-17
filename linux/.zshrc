export ZSH=$HOME/.oh-my-zsh
OHMYPOSH=$HOME/.dotfiles/common/ohmyposh/terminalprompt.omp.json
ZSH_THEME="codespaces"
plugins=(git)
source $ZSH/oh-my-zsh.sh
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true

eval "$(oh-my-posh init zsh --config $OHMYPOSH)"
