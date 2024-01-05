#!/bin/sh

jdk_url=https://aws.amazon.com/corretto/\?filtered-posts.sort-by\=item.additionalFields.createdDate\&filtered-posts.sort-order\=desc
version=$(curl -s "$jdk_url" | awk -F 'Download Amazon Corretto'  'gsub(/<\/span> <\/a>/, "", $2) {print $2}' | sort -g | tail -1 | sed 's/ //g')

# curl -OL "https://corretto.aws/downloads/latest/amazon-corretto-$version-x64-linux-jdk.deb"

deb_file=$(ls | grep java-$version-amazon-corretto-jdk)

sudo dpkg -i $deb_file

# rm -rf amazon-corretto-$version-x64-linux-jdk.deb