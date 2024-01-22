#!/bin/bash

install_vscode() {
    read -p "Do you wish to install Visual Studio Code? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm code;;
    esac
}

install_neovim() {
    read -p "Do you wish to install Neovim? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm neovim
		load_neovim_config;;
    esac
}

install_sublime_text_3() {
    read -p "Do you wish to install Sublime Text 3? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm sublime-text-3;;
    esac
}

install_intellij_idea_community_edition() {
    read -p "Do you wish to install IntelliJ IDEA Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm intellij-idea-community-edition;;
    esac
}

install_pycharm_community_edition() {
    read -p "Do you wish to install PyCharm Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm pycharm-community-edition;;
    esac
}

install_postman() {
    read -p "Do you wish to install Postman? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm postman;;
    esac
}

install_insomnia() {
    read -p "Do you wish to install Insomnia? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm insomnia;;
    esac
}

install_android_studio() {
    read -p "Do you wish to install Android Studio? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm android-studio;;
    esac
}

install_docker() {
    read -p "Do you wish to install Docker? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm docker
            sudo usermod -aG docker $USER;;
    esac
}

install_ripgrep() {
    read -p "Do you wish to install the latest version of ripgrep? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm ripgrep;;
    esac
}


install_postgresql() {
    read -p "Do you wish to install PostgreSQL? [Y/n]" yn
    case $yn in
        [Yy] ) sudo pacman -S --noconfirm postgresql pgadmin4;;
        * ) echo "PostgreSQL installation canceled.";;
    esac
}

install_redis() {
    sudo pacman -S --noconfirm redis
}

install_apt_packages() {
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm base-devel
    sudo pacman -S --noconfirm curl
    sudo pacman -S --noconfirm git
    sudo pacman -S --noconfirm wget
    sudo pacman -S --noconfirm wl-clipboard
    sudo pacman -S --noconfirm fzf
    sudo pacman -S --noconfirm snapd
    sudo pacman -S --noconfirm zsh
    sudo pacman -S --noconfirm tmux
    sudo pacman -S --noconfirm libglvnd
    sudo pacman -S --noconfirm libxrandr
    sudo pacman -S --noconfirm libxss
    sudo pacman -S --noconfirm libxcursor
    sudo pacman -S --noconfirm libxcomposite
    sudo pacman -S --noconfirm libasound
    sudo pacman -S --noconfirm libxi
    sudo pacman -S --noconfirm libxtst
}

install_devtools() {
    install_on_my_zsh
    install_golang
    install_nodejs
    install_docker
    install_jdk
    install_minikube
    install_helm3
    install_postgresql
    install_redis
}

initialize_pgp_keys
install_apt_packages
install_devtools

