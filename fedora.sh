#!/bin/bash

install_vscode() {
    read -p "Do you wish to install Visual Studio Code? [Y/n]" yn
    case $yn in
        [Yy] ) sudo dnf install code -y;;
    esac
}

install_neovim() {
    read -p "Do you wish to install Neovim? [Y/n]" yn
    case $yn in
        [Yy] ) sudo dnf install neovim -y
		load_neovim_config;;
    esac
}

install_sublime_text_3() {
    read -p "Do you wish to install Sublime Text 3? [Y/n]" yn
    case $yn in
        [Yy] ) sudo dnf install sublime-text -y;;
    esac
}

install_intellij_idea_community_edition() {
    read -p "Do you wish to install IntelliJ IDEA Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) sudo dnf install intellij-idea-community -y;;
    esac
}

install_pycharm_community_edition() {
    read -p "Do you wish to install PyCharm Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) sudo dnf install pycharm-community -y;;
    esac
}

install_postman() {
    read -p "Do you wish to install Postman? [Y/n]" yn
    case $yn in
        [Yy] ) sudo dnf install postman -y;;
    esac
}

install_insomnia() {
    read -p "Do you wish to install Insomnia? [Y/n]" yn
    case $yn in
        [Yy] ) sudo dnf install insomnia -y;;
    esac
}

install_android_studio() {
    read -p "Do you wish to install Android Studio? [Y/n]" yn
    case $yn in
        [Yy] ) sudo dnf install android-studio -y;;
    esac
}

install_docker() {
    read -p "Do you wish to install Docker? [Y/n]" yn
    case $yn in
        [Yy] )
            sudo dnf install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
            sudo dnf install docker-ce docker-ce-cli containerd.io -y
            sudo usermod -aG docker $USER

            exec newgrp docker
            ;;
    esac
}

install_ripgrep() {
    read -p "Do you wish to install the latest version of ripgrep? [Y/n]" yn
    case $yn in
        [Yy] ) sudo dnf install ripgrep -y;;
    esac
}


install_postgresql() {
    read -p "Do you wish to install PostgreSQL? [Y/n]" yn
    case $yn in
        [Yy] ) sudo dnf install postgresql pgadmin4 -y;;
        * ) echo "PostgreSQL installation canceled.";;
    esac
}

install_redis() {
    sudo dnf install redis -y
}

install_apt_packages() {
    sudo dnf update -y
    sudo dnf group install "Development Tools" -y
    sudo dnf install curl -y
    sudo dnf install git -y
    sudo dnf install wget -y
    sudo dnf install wl-clipboard -y
    sudo dnf install fzf -y
    sudo dnf install snapd -y
    sudo dnf install zsh -y
    sudo dnf install tmux -y
    sudo dnf install libglvnd -y
    sudo dnf install libxrandr -y
    sudo dnf install libxss -y
    sudo dnf install libxcursor -y
    sudo dnf install libxcomposite -y
    sudo dnf install libasound -y
    sudo dnf install libxi -y
    sudo dnf install libxtst -y
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

