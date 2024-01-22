#!/bin/bash

install_vscode() {
    read -p "Do you wish to install Visual Studio Code? [Y/n]" yn
    case $yn in
        [Yy] ) brew install --cask visual-studio-code;;
    esac
}

install_neovim() {
    read -p "Do you wish to install Neovim? [Y/n]" yn
    case $yn in
        [Yy] ) brew install neovim
		load_neovim_config;;
    esac
}

install_sublime_text_3() {
    read -p "Do you wish to install Sublime Text 3? [Y/n]" yn
    case $yn in
        [Yy] ) brew install --cask sublime-text;;
    esac
}

install_intellij_idea_community_edition() {
    read -p "Do you wish to install IntelliJ IDEA Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) brew install --cask intellij-idea-ce;;
    esac
}

install_pycharm_community_edition() {
    read -p "Do you wish to install PyCharm Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) brew install --cask pycharm-ce;;
    esac
}

install_postman() {
    read -p "Do you wish to install Postman? [Y/n]" yn
    case $yn in
        [Yy] ) brew install --cask postman;;
    esac
}

install_insomnia() {
    read -p "Do you wish to install Insomnia? [Y/n]" yn
    case $yn in
        [Yy] ) brew install --cask insomnia;;
    esac
}

install_android_studio() {
    read -p "Do you wish to install Android Studio? [Y/n]" yn
    case $yn in
        [Yy] ) brew install --cask android-studio;;
    esac
}

install_docker() {
    read -p "Do you wish to install Docker? [Y/n]" yn
    case $yn in
        [Yy] ) brew install --cask docker;;
    esac
}

install_ripgrep() {
    read -p "Do you wish to install the latest version of ripgrep? [Y/n]" yn
    case $yn in
        [Yy] ) brew install ripgrep;;
    esac
}

install_postgresql() {
    read -p "Do you wish to install PostgreSQL? [Y/n]" yn
    case $yn in
        [Yy] ) brew install postgresql
            brew install --cask pgadmin4;;
        * )
            echo "PostgreSQL installation canceled."
            ;;
    esac
}

install_redis() {
    brew install redis
}

install_minikube() {
    read -p "Do you wish to install minikube? [Y/n]" yn
    case $yn in
        [Yy] ) brew install minikube
            minikube start;;
    esac
}

install_helm3() {
    read -p "Do you wish to install helm3? [Y/n]" yn
    case $yn in
        [Yy] ) brew install helm;;
    esac
}

install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo export PATH='$PATH:$HOME/.cargo/bin' >> $HOME/.zshrc
}

install_golang() {
    read -p "Do you wish to install Go(Golang)? [Y/n]" yn
    case $yn in
        [Yy] ) brew install go;;
    esac
}

install_nodejs() {
    read -p "Do you wish to install Node.js? [Y/n]" yn
    case $yn in
        [Yy] ) brew install node;;
    esac
}

initialize_pgp_keys() {
    # No initialization needed for Homebrew on macOS
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

install_apt_packages() {
    # No equivalent for apt packages on macOS
}

install_rpm_packages() {
    # No equivalent for rpm packages on macOS
}

install_snapd_packages() {
    # No equivalent for snap packages on macOS
}

initialize_pgp_keys
install_apt_packages
install_rpm_packages
install_snapd_packages
install_devtools

