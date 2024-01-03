#!/bin/bash

release_url='https://go.dev/doc/devel/release'
version=$(curl -s "$release_url" | awk -F '<p id="' 'gsub(/">/, "", $2)  {print $2}' | awk -F 'go' '{print $2}' | awk -F '.' '{print $1, $2, $3}' | sort -k1 -k2 -k3 -g | tail -1 | awk '{print $1"."$2"."$3}')

curl -OL "https://go.dev/dl/go$version.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "go$version.linux-amd64.tar.gz"
echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.zshrc
source $HOME/.zshrc
rm -rf "go$version.linux-amd64.tar.gz"
