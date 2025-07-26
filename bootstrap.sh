#!/usr/bin/env bash

set -exo pipefail

mkdir -p $HOME/.zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.zsh

curl -fsSL https://raw.githubusercontent.com/antyung47/dotfiles/refs/heads/main/user_data/.zshrc.template \
| envsubst > ~/.zshrc

curl -fsSL https://raw.githubusercontent.com/antyung47/dotfiles/refs/heads/main/user_data/.netrc.template \
| envsubst > ~/.netrc

mkdir -p $HOME/.aws
curl -fsSL https://raw.githubusercontent.com/antyung47/dotfiles/refs/heads/main/user_data/.aws/credentials.template \
| envsubst > $HOME/.aws/credentials

mkdir -p $HOME/.ssh
curl -fsSL https://raw.githubusercontent.com/antyung47/dotfiles/refs/heads/main/user_data/.ssh/config.template \
> $HOME/.ssh/config
