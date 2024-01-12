#!/bin/bash

main() {
    read -p "Select your OS/package manager? " choice
	echo "0) apt"
	echo "1) ubuntu lts 22.04+"
    case $choice in
        [0-1] ) ./ubuntu.sh;;
    esac
}

main