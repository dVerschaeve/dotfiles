#!/bin/bash

ohmyposh() {
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh

    mkdir ${HOME}/.poshthemes
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ${HOME}/.poshthemes/themes.zip
    unzip ${HOME}/.poshthemes/themes.zip -d ${HOME}/.poshthemes
    chmod u+rw ${HOME}/.poshthemes/*.omp.*
    rm ${HOME}/.poshthemes/themes.zip
}

zshrc () {
    cat linux/.zshrc > $HOME/.zshrc
}

ohmyposh
zshrc
