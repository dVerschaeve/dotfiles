#!/bin/bash

copyFiles(){

    if [ -d ${HOME}/.dotfiles ] 
    then
        rm ${HOME}/.dotfiles -r
    fi

    mkdir ${HOME}/.dotfiles
    cp * ${HOME}/.dotfiles -r

}

ohmyposh() {
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh    
}

zshrc () {
    cat linux/.zshrc > $HOME/.zshrc
}

pwshConfig(){
    if ! command -v pwsh &> /dev/null
    then
        echo "<the_command> could not be found"
        exit
    else 
        echo "pwsh located"
        pwsh install-linux.ps1
    fi
}

copyFiles
ohmyposh
zshrc
pwshConfig
