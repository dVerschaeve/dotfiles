#!/bin/bash

ohmyposh() {
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh

    mkdir ${HOME}/.poshthemes
    cat ohmyposh/ohmyposh.omp.json > $HOME/.poshthemes/ohmyposh.omp.json
}

zshrc () {
    cat linux/.zshrc > $HOME/.zshrc
}

ohmyposh
zshrc
