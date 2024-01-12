#!/bin/bash

main() {
	echo "Select your OS/package manager"
	echo "0) apt"
	echo "1) ubuntu lts 22.04+"
    read -r choice
    case $choice in
        [0-1] ) ./ubuntu.sh;;
    esac
}

main