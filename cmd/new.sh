#!/usr/bin/env bash

NPM_ROOT=$(npm run env | awk -F"=" '$1 ~ /PWD/ {print $2}')
CONFIG_DIR="/Users/yu/Documents/Git/Configurations/TiddlyWiki"

# 1. Copy config files from Repo

if [ -z $1 ]; then
    echo "Please provide me a folder name!"
    return 1
fi

if [ -f ${CONFIG_DIR}/tiddlywiki.info ]; then
    mkdir ${NPM_ROOT}/$1
    cp ${CONFIG_DIR}/tiddlywiki.info ${NPM_ROOT}/$1/tiddlywiki.info
    mkdir ${NPM_ROOT}/$1/tiddlers/
    cp -r ${CONFIG_DIR}/global-conf ${NPM_ROOT}/$1/tiddlers/wiki-conf
    echo "Wiki creation done!"
else
    echo "Cannot create new wiki, Please check your configuration files at $CONFIG_DIR"
    return 1
fi