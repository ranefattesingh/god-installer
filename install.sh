#!/bin/bash

install_apt_packages() {
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get install build-essential curl git wget wl-clipboard fzf snapd zsh tmux libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 -y
    ./ubuntu.sh
}

install_pacman_packages() {
    sudo pacman -Syu --noconfirm base-devel curl git wget fzf snapd zsh tmux libgl libxrandr libxss libxcursor libxcomposite alsa-lib libxi libxtst
    ./arch.sh
}

install_dnf_packages() {
    sudo dnf update -y
    sudo dnf install -y curl git wget wl-clipboard fzf snapd zsh tmux libglvnd-glx libdrm libX11 libXext libXrandr libXss libXcursor libXcomposite libasound libXi libXtst
    ./fedora.sh
}

install_zypper_packages() {
    sudo zypper update -y
    sudo zypper install -y curl git wget fzf snapd zsh tmux libGL1 libdrm libX11 libXext libXrandr libXss libXcursor libXcomposite libasound2 libXi6 libXtst6
    ./tumbleweed.sh
}

install_macos() {
    ./macos.sh
}

main() {
    echo "Select your OS/package manager"
    echo "0) apt [Debian/Ubuntu] (Tested)"
    echo "1) pacman [Arch] (Not Tested)"
    echo "2) dnf [Fedora] (Not Tested)"
    echo "3) zypper [OpenSUSE Tumbleweed] (Not Tested)"
    echo "4) macOS (Not Tested)"
    read -r choice
    case $choice in
        0 ) install_apt_packages ;;
        1 ) install_pacman_packages ;;
        2 ) install_dnf_packages ;;
        3 ) install_zypper_packages ;;
        4 ) install_zypper_packages ;;
        * ) echo "Invalid choice";;
    esac
}

main

