#!/bin/sh

if [ -d $ZSH ]; then
	read -p "oh-my-zsh is already installed. Do you want to remove it and reinstall latest version?[Y/n]" reinstall_zsh
	case "$reinstall_zsh" in
		y|Y ) echo "removing oh-my-zsh";;
	esac
fi
