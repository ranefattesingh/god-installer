#!/bin/sh

sed -i -e 's/plugins=(git)/plugins=(git)\nplugins=(kube-ps1)/g' $HOME/.zshrc
sed -i -e 's/source $ZSH\/oh-my-zsh.sh/source $ZSH\/oh-my-zsh.sh\nPROMPT=''$(kube_ps1)''$PROMPT/g' $HOME/.zshrc
