#!/bin/zsh

# set up github env

git config --global user.name "Emory Lundberg"
git config --global user.email "emory@hellyeah.com"
git config --global github.user emory
echo "get your API key and add it with: git config --global github.token blahblahtoken"
git remote add origin git@github.com:emory/dotfiles.git
