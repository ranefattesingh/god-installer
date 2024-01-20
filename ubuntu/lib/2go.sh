#!/bin/sh

release_url='https://go.dev/doc/devel/release'
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
echo  export PATH='$PATH:'$HOME/go/bin >> $HOME/.zshrc