release_url=https://nodejs.org/en/blog/release
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

/usr/local/node/bin/npm install --global pnpm
