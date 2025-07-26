#!/usr/bin/env bash

set -exo pipefail

$(which sudo) apt-get update
DEBIAN_FRONTEND=noninteractive $(which sudo) apt-get install -y --no-install-recommends gettext

mkdir -p $HOME/.zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.zsh/zsh-autosuggestions

curl -fsSL https://raw.githubusercontent.com/antyung47/dotfiles/refs/heads/main/user_data/.zshrc.template \
| envsubst > $HOME/.zshrc

curl -fsSL https://raw.githubusercontent.com/antyung47/dotfiles/refs/heads/main/user_data/.netrc.template \
| envsubst > $HOME/.netrc

mkdir -p $HOME/.aws
curl -fsSL https://raw.githubusercontent.com/antyung47/dotfiles/refs/heads/main/user_data/.aws/credentials.template \
| envsubst > $HOME/.aws/credentials

mkdir -p $HOME/.ssh
curl -fsSL https://raw.githubusercontent.com/antyung47/dotfiles/refs/heads/main/user_data/.ssh/config.template \
> $HOME/.ssh/config
