#!/bin/bash

install_apt_packages() {
	sudo apt update -y
	sudo apt install build-essential -y
	sudo apt install curl -y
	sudo apt install git -y
	sudo apt install wget -y
	sudo apt install wl-clipboard -y
	sudo apt install fzf -y
	sudo apt install snapd -y
	sudo apt install zsh -y
}

install_vscode() {
    read -p "Do you wish to install Visual Studio Code? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install code --classic;;
    esac
}

load_neovim_config() {
	echo "Do you wish to load default Neovim config of ThePrimeagen modified by Fattesingh Rane"
    read -p "(Caution) This will remove and reload the new config for Neovim? [Y/n]" yn
    case $yn in
        [Yy] )	rm -rf $HOME/.config/nvim
				rm -rf $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
				git clone --depth 1 git@github.com:ranefattesingh/nvim.git $HOME/.config/nvim
				git clone --depth 1 https://github.com/wbthomason/packer.nvim  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
				nvim --headless -n -u $HOME/.config/nvim/lua/ranefattesingh/packer.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync';;
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
    read -p "Do you wish to install Intellij IDEA Community Edition? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install intellij-idea-community --classic;;
    esac
}

install_pycharm_community_edition() {
    read -p "Do you wish to install Android Studio? [Y/n]" yn
    case $yn in
        [Yy] ) sudo snap install android-studio --classic;;
    esac
}


install_snapd_packages() {
	install_vscode
	install_neovim
	install_sublime_text_3
	install_intellij_idea_community_edition
	install_pycharm_community_edition
}

install_on_my_zsh() {
    read -p "Do you wish to install oh-my-zsh? [Y/n]" yn
    case $yn in
        [Yy] )	if [ -d "$ZSH" ]; then
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
				fi;;
    esac
}

install_golang() {
    read -p "Do you wish to install Go(Golang)? [Y/n]" yn
    case $yn in
        [Yy] ) 	release_url='https://go.dev/doc/devel/release'
				version=$(curl -s "$release_url" | awk -F '<p id="' 'gsub(/">/, "", $2)  {print $2}' | awk -F 'go' '{print $2}' | awk -F '.' '{print $1, $2, $3}' | sort -k1 -k2 -k3 -g | tail -1 | awk '{print $1"."$2"."$3}')

				curl -OL "https://go.dev/dl/go$version.linux-amd64.tar.gz"
				sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "go$version.linux-amd64.tar.gz"
				echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.zshrc
				rm -rf "go$version.linux-amd64.tar.gz"
				/usr/local/go/bin/go install github.com/nsf/gocode@latest
				/usr/local/go/bin/go install github.com/tpng/gopkgs@latest
				/usr/local/go/bin/go install github.com/ramya-rao-a/go-outline@latest
				/usr/local/go/bin/go install github.com/acroca/go-symbols@latest
				/usr/local/go/bin/go install golang.org/x/tools/cmd/guru@latest
				/usr/local/go/bin/go install golang.org/x/tools/cmd/gorename@latest
				/usr/local/go/bin/go install github.com/fatih/gomodifytags@latest
				/usr/local/go/bin/go install github.com/josharian/impl@latest
				/usr/local/go/bin/go install golang.org/x/tools/gopls@latest
				/usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest
				/usr/local/go/bin/go install honnef.co/go/tools/cmd/staticcheck@latest
				/usr/local/go/bin/go install honnef.co/go/tools/cmd/keyify@latest
				/usr/local/go/bin/go install honnef.co/go/tools/cmd/structlayout@latest
				/usr/local/go/bin/go install honnef.co/go/tools/cmd/structlayout-optimize@latest
				/usr/local/go/bin/go install honnef.co/go/tools/cmd/structlayout-pretty@latest

				curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh
				echo  export PATH='$PATH:'$HOME/go/bin >> $HOME/.zshrc;;
    esac
}

install_nodejs() {
    read -p "Do you wish to install Node.js? [Y/n]" yn
    case $yn in
        [Yy] ) 	release_url=https://nodejs.org/en/blog/release
				version=$(curl -s "$release_url" | grep -Po "Node v[0-9]+.[0-9]+.[0-9]+ \(LTS\)" | awk -F ' ' 'gsub("v", "", $2) {print $2}' | awk -F '.' '{print $1, $2, $3}' | sort -k1 -k2 -k3 -n | tail -1 | awk '{print $1"."$2"."$3}')

				curl -OL "https://nodejs.org/dist/v20.10.0/node-v$version-linux-x64.tar.xz"
				sudo rm -rf /usr/local/node && sudo tar -C /usr/local -xf node-v$version-linux-x64.tar.xz
				sudo mv /usr/local/node-v$version-linux-x64 /usr/local/node
				rm -rf node-v$version-linux-x64.tar.xz
				echo export PATH='$PATH:'/usr/local/node/bin >> $HOME/.zshrc

				mkdir ~/.npm-global
				export NPM_CONFIG_PREFIX=~/.npm-global
				export PATH=$PATH:~/.npm-global/bin

				mkdir ~/.npm-global
				echo export NPM_CONFIG_PREFIX=~/.npm-global >> $HOME/.zshrc
				echo export PATH='$PATH:'~/.npm-global/bin >> $HOME/.zshrc

				/usr/local/node/bin/npm install --global pnpm;;
    esac
}

install_docker() {
    read -p "Do you wish to install Node.js? [Y/n]" yn
    case $yn in
        [Yy] ) 	sudo apt-get update
				sudo apt-get install ca-certificates curl gnupg
				sudo install -m 0755 -d /etc/apt/keyrings
				curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
				sudo chmod a+r /etc/apt/keyrings/docker.gpg

				# Add the repository to Apt sources:
				echo \
				  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
				  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
				  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

				sudo apt-get update

				sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

				sudo groupadd docker

				sudo usermod -aG docker $USER

				newgrp docker;;
    esac
}

install_jdk() {
    read -p "Do you wish to install Java Development Kit (JDK) LTS? [Y/n]" yn
    case $yn in
        [Yy] ) 	jdk_url=https://aws.amazon.com/corretto/\?filtered-posts.sort-by\=item.additionalFields.createdDate\&filtered-posts.sort-order\=desc
				version=$(curl -s "$jdk_url" | awk -F 'Download Amazon Corretto'  'gsub(/<\/span> <\/a>/, "", $2) {print $2}' | sort -g | tail -1 | sed 's/ //g')

				curl -OL "https://corretto.aws/downloads/latest/amazon-corretto-$version-x64-linux-jdk.deb"

				deb_file=$(ls | grep java-$version-amazon-corretto-jdk)

				sudo dpkg -i $deb_file

				rm -rf amazon-corretto-$version-x64-linux-jdk.deb
    esac
}

install_minikube() {
    read -p "Do you wish to install minikube? [Y/n]" yn
    case $yn in
        [Yy] ) 	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
				sudo install minikube-linux-amd64 /usr/local/bin/minikube
				echo "Enable kube-ps1?"
				read -p "(Important) Needs zsh + oh-my-zsh installed [Y/n]" yn
				case $yn in
					[Yy] ) 	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
							sudo install minikube-linux-amd64 /usr/local/bin/minikube
							minikube start
							rm -rf minikube-linux-amd64;;
				esac;;
    esac
}

install_ripgrep() {
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
	sudo dpkg -i ripgrep_13.0.0_amd64.deb
}


install_deb_packages() {
	install_ripgrep
}


install_devtools() {
	install_golang
	install_nodejs
	install_docker
	install_jdk
	install_minikube
}

install_apt_packages
install_on_my_zsh
install_deb_packages
install_snapd_packages
install_devtools

#files=$(ls ./lib | grep '.sh')
#for file in $files
#do
#    sh $file
#done