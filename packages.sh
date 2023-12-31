#!/bin/sh

#udo su

LOG_HOME=$HOME/.oh-my-zsh

echo $LOG_HOME

read -p "Do you wish to set default -y for apt packages during installation?[Y/n] " YES

is_yes() {
	case $YES in
		y|Y ) 	echo "Setting default -y for apt installation"
			return 0;; # true in bash = 0
		*)	return 1;; # false in bash = 1
	esac
}

is_yes && sudo apt install neovim -y || sudo apt install neovim
is_yes && sudo apt update -y || sudo apt update
is_yes && sudo apt upgrade -y || sudo apt upgrade
is_yes && sudo apt install git -y || sudo apt install git 
is_yes && sudo apt install wget -y || sudo apt install wget 
is_yes && sudo apt install zsh -y || sudo apt install zsh 

if [ -d "$ZSH" ]; then
	echo "Select any one option from the following"
	echo "1) Reinstall oh-my-zsh by removing existing oh-my-zsh \n (Caution) Will also remove and create new .zshrc file"
	echo "2) Upgrade oh-my-zsh"
	echo "Anything else to continue"
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

