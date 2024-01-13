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

				exec newgrp docker;;
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

install_postgresql() {
    read -p "Do you wish to install postgresql? [Y/n]" yn
    case $yn in
		sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
		wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/ACCC4CF8.asc
		sudo apt-get update
		sudo apt-get install postgresql -y
		
		curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
		sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
		sudo apt install pgadmin4
		sudo apt install pgadmin4-desktop
		sudo apt install pgadmin4-web;;
    esac
}

install_redis() {
	curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

	echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

	sudo apt-get update
	sudo apt-get install redis
}

initialize_pgp_keys() {
	if [ ! -d "/etc/apt/keyrings" ]; then	
		sudo mkdir -m 0755 /etc/apt/keyrings
	fi
}

install_apt_packages() {
	sudo apt-get update -y
	sudo apt-get upgrade -y
	sudo apt-get install build-essential -y
	sudo apt-get install curl -y
	sudo apt-get install git -y
	sudo apt-get install wget -y
	sudo apt-get install wl-clipboard -y
	sudo apt-get install fzf -y
	sudo apt-get install snapd -y
	sudo apt-get install zsh -y
	sudo apt-get install tmux -y
	sudo apt-get install libgl1-mesa-glx -y
	sudo apt-get install libegl1-mesa -y
	sudo apt-get install libxrandr2 -y
	sudo apt-get install libxrandr2 -y
	sudo apt-get install libxss1 -y
	sudo apt-get install libxcursor1 -y
	sudo apt-get install libxcomposite1 -y
	sudo apt-get install libasound2 -y
	sudo apt-get install libxi6 -y
	sudo apt-get install libxtst6 -y
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
	install_postgresql
}

initialize_pgp_keys
install_apt_packages
install_deb_packages
install_snapd_packages
install_devtools