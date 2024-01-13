#!/bin/bash

load_neovim_config() {
	echo "Do you wish to load default Neovim config of ThePrimeagen modified by Fattesingh Rane"
    read -p "(Caution) This will remove and reload the new config for Neovim? [Y/n]" yn
    case $yn in
        [Yy] )	rm -rf $HOME/.config/nvim
				rm -rf $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
				git clone --depth 1 https://github.com/ranefattesingh/nvim.git $HOME/.config/nvim
				git clone --depth 1 https://github.com/wbthomason/packer.nvim  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
				nvim --headless -n -u $HOME/.config/nvim/lua/ranefattesingh/packer.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync';;
    esac
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
						exec zsh
					2 )	# Upgrade Oh-My-Zsh
						$ZSH/tools/upgrade.sh;;
						exec zsh
					esac
				else
					sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
					exec zsh
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

install_jdk() {
    read -p "Do you wish to install Java Development Kit (JDK) LTS? [Y/n]" yn
    case $yn in
        [Yy] ) 	jdk_url=https://aws.amazon.com/corretto/\?filtered-posts.sort-by\=item.additionalFields.createdDate\&filtered-posts.sort-order\=desc
				version=$(curl -s "$jdk_url" | awk -F 'Download Amazon Corretto'  'gsub(/<\/span> <\/a>/, "", $2) {print $2}' | sort -g | tail -1 | sed 's/ //g')
				curl -OL "https://corretto.aws/downloads/latest/amazon-corretto-$version-x64-linux-jdk.tar.gz"
				tar_file=$(ls | grep amazon-corretto-$version-x64-linux-jdk)
				tar -zxvf $tar_file
				rm -rf $tar_file
				dir_name=$(ls | grep amazon-corretto)
				mv $dir_name java-$version-amazon-corretto-jdk
				sudo mkdir /usr/lib/jvm
				sudo mv java-$version-amazon-corretto-jdk /usr/lib/jvm/
				#sudo echo "export JAVA_HOME=/usr/lib/jvm/java-$version-amazon-corretto-jdk" >> /etc/environment
				echo export JAVA_HOME=/usr/lib/jvm/java-$version-amazon-corretto-jdk >> $HOME/.zshrc
				echo export PATH='$PATH:$JAVA_HOME/bin' >> $HOME/.zshrc
    esac
}

install_minikube() {
    read -p "Do you wish to install minikube? [Y/n]" yn
    case $yn in
        [Yy] ) 	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
				sudo install minikube-linux-amd64 /usr/local/bin/minikube
				rm -rf minikube-linux-amd64
				minikube start
				echo "Enable kube-ps1?"
				read -p "(Important) Needs zsh + oh-my-zsh installed [Y/n]" yn
				case $yn in
					[Yy] ) 	sed -i -e 's/plugins=(git)/plugins=(git)\nplugins=(kube-ps1)/g' $HOME/.zshrc
							sed -i -e 's/source $ZSH\/oh-my-zsh.sh/source $ZSH\/oh-my-zsh.sh\nPROMPT=''$(kube_ps1)''$PROMPT/g' $HOME/.zshrc;;	
				esac;;
    esac
}

install_helm3() {
    read -p "Do you wish to install helm3? [Y/n]" yn
    case $yn in
        [Yy] ) 	curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
				chmod 700 get_helm.sh
				./get_helm.sh
				rm -rf get_helm.sh;;
    esac
}

install_rust() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	echo export PATH='$PATH:.cargo/bin' >> $HOME/.zshrc
}