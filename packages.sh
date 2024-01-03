#!/bin/sh

is_yes() {
    case $YES in
        y|Y ) 	echo "Setting default -y for apt installation"
            return 0;; # true in bash = 0
        *)	return 1;; # false in bash = 1
    esac
}

command_exists() {
    command -v "$@" >/dev/null 2>&1
}



setup_zsh() {
    if [ -d "$ZSH" ]; then
        echo "Select any one option from the following"
        echo "1) Reinstall oh-my-zsh by removing existing oh-my-zsh \n (Caution) Will also remove and create new .zshrc file"
        echo "2) Upgrade oh-my-zsh"
        echo "*) Anything else to continue"
        read -r reinstall_zsh
        case "$reinstall_zsh" in
            1 ) 	# Removing Oh-My-Zsh
                sh $ZSH/tools/uninstall.sh
                rm -rf $ZSH/.oh-my-zsh
                rm -rf .zshrc

            # Installing Oh-My-Zsh
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";;
        2 )	# Upgrade Oh-My-Zsh
            $ZSH/tools/upgrade.sh;;
        esac
    else
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}

install_neovim_config() {
    rm -rf $HOME/.config/nvim
    rm -rf $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone --depth 1 git@github.com:ranefattesingh/nvim.git $HOME/.config/nvim
    git clone --depth 1 https://github.com/wbthomason/packer.nvim  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    nvim --headless -n -u $HOME/.config/nvim/lua/ranefattesingh/packer.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

# Below section deals with installation of custom config for neovim
setup_neovim_config() {
        if [ "$HOME/.config/nvim" ]; then
            echo " Reload neovim config from github?\n (Caution) Will remove current neovim profile from ${HOME}/.config/nvim. Proceed?[Y/n] "	
            read -p "Reload neovim config?[Y/n] " reloadnvim
            case "$reloadnvim" in
                Y|y )	#Delete and reload nvim profile"
                        install_neovim_config
            esac
        else
            install_neovim_config
        fi 
}



read -p "Do you wish to set default -y for apt packages during installation?[Y/n] " YES

is_yes && sudo apt upgrade -y || sudo apt upgrade
is_yes && sudo apt update -y || sudo apt update
is_yes && sudo apt install git -y || sudo apt install git 
is_yes && sudo apt install wget -y || sudo apt install wget 
is_yes && sudo apt install zsh -y || sudo apt install zsh 
is_yes && sudo apt install wl-clipboard -y || sudo apt install wl-clipboard
is_yes && sudo apt install snapd -y || sudo apt install snapd

# Below packages will be installed from snapd since they are regurlarly updated.
sudo snap install code --classic
sudo snap install nvim --classic

setup_zsh
setup_neovim_config

sh goinstall.sh
