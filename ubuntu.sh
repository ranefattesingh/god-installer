#!/bin/bash

install_vscode() {
    read -p "Do you wish to install Visual Studio Code? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install code --classic;;
    esac
}

install_neovim() {
    read -p "Do you wish to install Neovim? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install nvim --classic
		load_neovim_config;;
    esac
}

install_sublime_text_3() {
    read -p "Do you wish to install Sublime Text 3? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install sublime-text --classic;;
    esac
}

install_intellij_idea_community_edition() {
    read -p "Do you wish to install Intellij IDEA Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install intellij-idea-community --classic;;
    esac
}

install_pycharm_community_edition() {
    read -p "Do you wish to install Pycharm Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install pycharm-community --classic;;
    esac
}

install_postman() {
    read -p "Do you wish to install Postman? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install postman;;
    esac
}

install_insomnia() {
    read -p "Do you wish to install Insomnia? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install insomnia;;
    esac
}


install_android_studio() {
    read -p "Do you wish to install Android Studio? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install android-studio --classic;;
    esac
}

install_docker() {
    read -p "Do you wish to install Docker? [Y/n]" yn
    case $yn in
        [Yy] ) 	sudo apt-get update -y
				sudo apt-get install ca-certificates curl gnupg -y
				sudo install -m 0755 -d /etc/apt/keyrings
				curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
				sudo chmod a+r /etc/apt/keyrings/docker.gpg

				# Add the repository to Apt sources:
				echo \
				  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
				  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
				  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

				sudo apt-get update

				sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

				# sudo groupadd docker

				sudo usermod -aG docker $USER

				newgrp docker;;
    esac
}

install_ripgrep() {
    read -p "Do you wish to install ripgrep? [Y/n]" yn
    case $yn in
        [Yy] ) 	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
				sudo dpkg -i ripgrep_13.0.0_amd64.deb
				rm -rf ripgrep_13.0.0_amd64.deb;;
    esac
	

}

install_apt_packages() {
	sudo apt update -y
	sudo apt updgrade -y
	sudo apt install build-essential -y
	sudo apt install curl -y
	sudo apt install git -y
	sudo apt install wget -y
	sudo apt install wl-clipboard -y
	sudo apt install fzf -y
	sudo apt install snapd -y
	sudo apt install zsh -y
	sudo apt install tmux -y
}


source ./common.sh

install_deb_packages() {
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
}

install_apt_packages
install_deb_packages
install_snapd_packages
install_devtools