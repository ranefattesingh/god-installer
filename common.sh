#!/bin/bash

load_neovim_config() {
    echo "Do you wish to load the default Neovim config by Fattesingh Rane (modified by ThePrimeagen)?"
    read -p "(Caution) This will remove and reload the new config for Neovim. Continue? [Y/n]" yn
    case $yn in
        [Yy] )
            config_dir="$HOME/.config/nvim"
            packer_dir="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

            # Backup existing Neovim config (optional, you can customize the backup location)
            backup_dir="$HOME/.config/nvim_backup_$(date +'%Y%m%d%H%M%S')"
            mv "$config_dir" "$backup_dir" 2>/dev/null

            # Clone the new Neovim config and Packer.nvim
            git clone --depth 1 https://github.com/ranefattesingh/nvim.git "$config_dir"
            git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_dir"

            # Run PackerSync to install plugins
            nvim --headless -n -u "$config_dir/lua/ranefattesingh/packer.lua" -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
            ;;
        * )
            echo "Neovim configuration update canceled."
            ;;
    esac
}

install_on_my_zsh() {
    read -p "Do you wish to install oh-my-zsh? [Y/n]" yn
    case $yn in
        [Yy] )
            if [ -d "$ZSH" ]; then
                echo "Select an option:"
                echo "1) Reinstall oh-my-zsh (Remove existing oh-my-zsh; Caution: Also removes and creates a new .zshrc file)"
                echo "2) Upgrade oh-my-zsh"
                echo "*) Continue without changes"

                read -r reinstall_zsh
                case "$reinstall_zsh" in
                    1 )
                        # Removing Oh-My-Zsh
                        sh "$ZSH/tools/uninstall.sh"
                        rm -rf "$ZSH/.oh-my-zsh"
                        rm -rf "$HOME/.zshrc"

                        # Installing Oh-My-Zsh
                        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
                        ;;
                    2 )
                        # Upgrade Oh-My-Zsh
                        "$ZSH/tools/upgrade.sh"
                        ;;
                    * )
                        echo "Continuing without changes."
                        ;;
                esac
            else
                sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
            fi
            ;;
        * )
            echo "oh-my-zsh installation canceled."
            ;;
    esac
}


install_golang() {
    read -p "Do you wish to install Go (Golang)? [Y/n]" yn
    case $yn in
        [Yy] )
            release_url='https://go.dev/doc/devel/release'
            version=$(curl -s "$release_url" | awk -F '<p id="' 'gsub(/">/, "", $2) {print $2}' | awk -F 'go' '{print $2}' | awk -F '.' '{print $1, $2, $3}' | sort -k1 -k2 -k3 -g | tail -1 | awk '{print $1"."$2"."$3}')

            curl -OL "https://go.dev/dl/go$version.linux-amd64.tar.gz"
            sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "go$version.linux-amd64.tar.gz"
            echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.zshrc"
            rm -rf "go$version.linux-amd64.tar.gz"

            # Install Go tools
            tools=("github.com/nsf/gocode" "github.com/tpng/gopkgs" "github.com/ramya-rao-a/go-outline" "github.com/acroca/go-symbols" 
                    "golang.org/x/tools/cmd/guru" "golang.org/x/tools/cmd/gorename" "github.com/fatih/gomodifytags" 
                    "github.com/josharian/impl" "golang.org/x/tools/gopls" "github.com/go-delve/delve/cmd/dlv" 
                    "honnef.co/go/tools/cmd/staticcheck" "honnef.co/go/tools/cmd/keyify" "honnef.co/go/tools/cmd/structlayout" 
                    "honnef.co/go/tools/cmd/structlayout-optimize" "honnef.co/go/tools/cmd/structlayout-pretty")

            for tool in "${tools[@]}"; do
                /usr/local/go/bin/go install "$tool@latest"
            done

            # Install golangci-lint
            curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh
            echo 'export PATH=$PATH:'"$HOME/go/bin" >> "$HOME/.zshrc"
            ;;
    esac
}


install_nodejs() {
    read -p "Do you wish to install Node.js? [Y/n]" yn
    case $yn in
        [Yy] )
            release_url="https://nodejs.org/en/blog/release"
            version=$(curl -s "$release_url" | grep -Po "Node v[0-9]+.[0-9]+.[0-9]+ \(LTS\)" | awk -F ' ' 'gsub("v", "", $2) {print $2}' | awk -F '.' '{print $1, $2, $3}' | sort -k1 -k2 -k3 -n | tail -1 | awk '{print $1"."$2"."$3}')

            curl -OL "https://nodejs.org/dist/v$version/node-v$version-linux-x64.tar.xz"
            sudo rm -rf /usr/local/node && sudo tar -C /usr/local -xf "node-v$version-linux-x64.tar.xz"
            sudo mv "/usr/local/node-v$version-linux-x64" "/usr/local/node"
            rm -rf "node-v$version-linux-x64.tar.xz"

            echo 'export PATH=$PATH:/usr/local/node/bin' >> "$HOME/.zshrc"

            mkdir -p "$HOME/.npm-global"
            echo 'export NPM_CONFIG_PREFIX=$HOME/.npm-global' >> "$HOME/.zshrc"
            echo 'export PATH=$PATH:$HOME/.npm-global/bin' >> "$HOME/.zshrc"

            /usr/local/node/bin/npm install --global pnpm
            ;;
    esac
}


install_jdk() {
    read -p "Do you wish to install Java Development Kit (JDK) LTS? [Y/n]" yn
    case $yn in
        [Yy] )
            jdk_url="https://aws.amazon.com/corretto/\?filtered-posts.sort-by\=item.additionalFields.createdDate\&filtered-posts.sort-order\=desc"
            version=$(curl -s "$jdk_url" | awk -F 'Download Amazon Corretto' 'gsub(/<\/span> <\/a>/, "", $2) {print $2}' | sort -g | tail -1 | sed 's/ //g')
            curl -OL "https://corretto.aws/downloads/latest/amazon-corretto-$version-x64-linux-jdk.tar.gz"
            
            tar_file="amazon-corretto-$version-x64-linux-jdk.tar.gz"
            tar -zxvf "$tar_file"
            rm -rf "$tar_file"
            
            dir_name=$(ls | grep "amazon-corretto")
            mv "$dir_name" "java-$version-amazon-corretto-jdk"

            jdk_install_dir="/usr/lib/jvm"
            sudo mkdir -p "$jdk_install_dir"
            sudo mv "java-$version-amazon-corretto-jdk" "$jdk_install_dir/"

            echo "export JAVA_HOME=$jdk_install_dir/java-$version-amazon-corretto-jdk" >> "$HOME/.zshrc"
            echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> "$HOME/.zshrc"
            ;;
    esac
}


install_minikube() {
    read -p "Do you wish to install minikube? [Y/n]" yn
    case $yn in
        [Yy] )
            minikube_url="https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"
            kube_ps1_enabled=false
            
            curl -LO "$minikube_url"
            sudo install "minikube-linux-amd64" "/usr/local/bin/minikube"
            rm -rf "minikube-linux-amd64"

            curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
            sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
            
            sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
            sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
            sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

            minikube start
            
            read -p "Enable kube-ps1? (Requires zsh + oh-my-zsh) [Y/n]" yn
            case $yn in
                [Yy] ) kube_ps1_enabled=true ;;
            esac
            
            if [ "$kube_ps1_enabled" = true ]; then
                sed -i -e 's/plugins=(git)/plugins=(git)\nplugins=(kube-ps1)/g' "$HOME/.zshrc"
                sed -i -e 's/source $ZSH\/oh-my-zsh.sh/source $ZSH\/oh-my-zsh.sh\nPROMPT=''$(kube_ps1)''$PROMPT/g' "$HOME/.zshrc"
            fi
            ;;
    esac
}

install_helm3() {
    read -p "Do you wish to install Helm 3? [Y/n]" yn
    case $yn in
        [Yy] )
            helm_install_script="https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
            
            curl -fsSL -o "get_helm.sh" "$helm_install_script"
            chmod 700 "get_helm.sh"
            ./get_helm.sh
            rm -rf "get_helm.sh"
            ;;
    esac
}


install_rust() {
    read -p "Do you wish to install Rust? [Y/n]" yn
    case $yn in
        [Yy] )
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

            # Adding Rust binaries to the PATH
            echo 'export PATH=$PATH:$HOME/.cargo/bin' >> "$HOME/.zshrc"
            ;;
    esac
}

