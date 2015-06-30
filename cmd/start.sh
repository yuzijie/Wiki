#!/usr/bin/env bash

NPM_ROOT=$(npm run env | awk -F"=" '$1 ~ /PWD/ {print $2}')
BIN_DIR="${NPM_ROOT}/node_modules/.bin/"

# 1. Check if tiddlywiki is installed

if [ ! -d ${NPM_ROOT}/node_modules ]; then
    echo "Running npm install"
    npm install
else
    if [ ${BIN_DIR} != $(echo $PATH | awk -F":" '{ print $1 }') ]; then
        PATH=${NPM_ROOT}/node_modules/.bin/:$PATH
    fi
fi

# 2. Start tiddlywiki by given folder name

if [ -z "$1" ]; then
    echo "Please provide the name of the wiki (folder)"
    return 1
fi

if [ -d "${NPM_ROOT}/$1" ]; then
    tiddlywiki ${NPM_ROOT}/$1 --server &
    sleep 1
    open http://127.0.0.1:8080/
    fg %-
else
    echo "Wiki name not found!"
    return 1
fi