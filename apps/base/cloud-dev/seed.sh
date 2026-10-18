#!/usr/bin/env bash
set -e

mkdir -p /mnt/scratch/{brew,cache,npm,vscode-server,mise}

if [ ! -e /mnt/home/.seeded ]; then
    cp -af /home/vscode/. /mnt/home/
    touch /mnt/home/.seeded
fi

if [ ! -e /mnt/scratch/brew/.seeded ]; then
    cp -af /home/linuxbrew/.linuxbrew/. /mnt/scratch/brew/
    touch /mnt/scratch/brew/.seeded
fi