#!/usr/bin/env bash
set -e
shopt -s dotglob nullglob

mkdir -p /mnt/scratch/{brew,cache,npm,vscode-server,mise}

if [ ! -e /mnt/home/.seeded ]; then
    files=(/home/vscode/*)
    if [ ${#files[@]} -gt 0 ]; then
        cp -rf --preserve=mode,links "${files[@]}" /mnt/home/
    fi
    touch /mnt/home/.seeded
fi

if [ ! -e /mnt/scratch/brew/.seeded ]; then
    cp -rf --preserve=mode,links /home/linuxbrew/.linuxbrew/* /mnt/scratch/brew/
    touch /mnt/scratch/brew/.seeded
fi