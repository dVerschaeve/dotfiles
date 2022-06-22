#!/bin/bash

ohmyposh() {
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh

    mkdir ${HOME}/.poshthemes
    cat common/terminalprompt.omp.json > $HOME/.poshthemes/terminalprompt.omp.json
    
}

zshrc () {
    cat linux/.zshrc > $HOME/.zshrc
}

ohmyposh
zshrc
