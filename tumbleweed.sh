#!/bin/bash

install_vscode() {
    read -p "Do you wish to install Visual Studio Code? [Y/n]" yn
    case $yn in
        [Yy] ) sudo zypper install code -y;;
    esac
}

install_neovim() {
    read -p "Do you wish to install Neovim? [Y/n]" yn
    case $yn in
        [Yy] ) sudo zypper install neovim -y
		load_neovim_config;;
    esac
}

install_sublime_text_3() {
    read -p "Do you wish to install Sublime Text 3? [Y/n]" yn
    case $yn in
        [Yy] ) sudo zypper install sublime-text -y;;
    esac
}

install_intellij_idea_community_edition() {
    read -p "Do you wish to install IntelliJ IDEA Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) sudo zypper install intellij-idea-community -y;;
    esac
}

install_pycharm_community_edition() {
    read -p "Do you wish to install PyCharm Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) sudo zypper install pycharm-community -y;;
    esac
}

install_postman() {
    read -p "Do you wish to install Postman? [Y/n]" yn
    case $yn in
        [Yy] ) sudo zypper install postman -y;;
    esac
}

install_insomnia() {
    read -p "Do you wish to install Insomnia? [Y/n]" yn
    case $yn in
        [Yy] ) sudo zypper install insomnia -y;;
    esac
}

install_android_studio() {
    read -p "Do you wish to install Android Studio? [Y/n]" yn
    case $yn in
        [Yy] ) sudo zypper install android-studio -y;;
    esac
}

install_docker() {
    read -p "Do you wish to install Docker? [Y/n]" yn
    case $yn in
        [Yy] )
            sudo zypper install docker -y

            sudo groupadd docker
            sudo usermod -aG docker $USER

            exec newgrp docker
            ;;
    esac
}

install_ripgrep() {
    read -p "Do you wish to install the latest version of ripgrep? [Y/n]" yn
    case $yn in
        [Yy] )
            latest_version=$(curl -sI https://github.com/BurntSushi/ripgrep/releases/latest | grep -i location | awk -F '/' '{print $NF}' | tr -d '\r\n[:space:]')
            download_url="https://github.com/BurntSushi/ripgrep/releases/download/$latest_version/ripgrep_$latest_version_amd64.rpm"

            curl -LO "$download_url"
            sudo zypper install "ripgrep_$latest_version_amd64.rpm"
            rm -rf "ripgrep_$latest_version_amd64.rpm"
            ;;
    esac
}

install_postgresql() {
    read -p "Do you wish to install PostgreSQL? [Y/n]" yn
    case $yn in
        [Yy] )
            sudo zypper install postgresql postgresql-server -y
            sudo systemctl start postgresql
            sudo systemctl enable postgresql

            sudo zypper install pgadmin4 -y
            ;;
        * )
            echo "PostgreSQL installation canceled."
            ;;
    esac
}

install_redis() {
    sudo zypper install redis -y
}

install_minikube() {
    read -p "Do you wish to install minikube? [Y/n]" yn
    case $yn in
        [Yy] ) 
            sudo zypper install kubectl -y

            curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
            sudo install minikube-linux-amd64 /usr/local/bin/minikube
            rm -rf minikube-linux-amd64
            minikube start
            ;;
    esac
}

install_helm3() {
    read -p "Do you wish to install helm3? [Y/n]" yn
    case $yn in
        [Yy] ) 
            curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
            chmod 700 get_helm.sh
            ./get_helm.sh
            rm -rf get_helm.sh
            ;;
    esac
}

install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo export PATH='$PATH:$HOME/.cargo/bin' >> $HOME/.zshrc
}

initialize_pgp_keys() {
    if [ ! -d "/etc/apt/keyrings" ]; then
        sudo mkdir -m 0755 /etc/apt/keyrings
    fi
}

install_apt_packages() {
    sudo zypper refresh -y
    sudo zypper update -y
    sudo zypper install patterns-devel-base-devel_basis -y
    sudo zypper install curl -y
    sudo zypper install git -y
    sudo zypper install wget -y
    sudo zypper install wl-clipboard -y
    sudo zypper install fzf -y
    sudo zypper install snapd -y
    sudo zypper install zsh -y
    sudo zypper install tmux -y
    sudo zypper install libglvnd-devel -y
    sudo zypper install libX11-devel -y
    sudo zypper install libXrandr-devel -y
    sudo zypper install libXi-devel -y
    sudo zypper install libXcursor-devel -y
    sudo zypper install libXcomposite-devel -y
    sudo zypper install libXtst-devel -y
    sudo zypper install libXss-devel -y
    sudo zypper install libXrandr2 -y
    sudo zypper install libXi6 -y
    sudo zypper install libXtst6 -y
}

install_rpm_packages() {
    install_ripgrep
}

install_snapd_packages() {
    install_vscode
    install_neovim
    install_sublime_text_3
    install_insomnia
    install_postman
    install_android_studio
    install_intellij_idea_community_edition
    install_pycharm_community_edition
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
install_rpm_packages
install_snapd_packages
install_devtools

