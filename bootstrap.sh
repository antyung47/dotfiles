#!/usr/bin/env bash

# set -exo pipefail # debug mode
set -euo pipefail # production mode

readonly FEATURE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source variables.sh
source generate.sh

overwrite_all=false

confirm_and_copy() {
    local src="$1"
    local dest="$2"

    if [[ -f "$dest" ]]; then
        if [[ "$overwrite_all" = true ]]; then
            cat "$src" > "$dest"
            echo "Overwritten $dest"
            return
        fi

        read -p "Overwrite $dest? [y/N/A]: " answer
        case "$answer" in
            [Yy])
                cat "$src" > "$dest"
                echo "Overwritten $dest"
                ;;
            [Aa])
                overwrite_all=true
                cat "$src" > "$dest"
                echo "Overwritten $dest (ALL mode enabled)"
                ;;
            *)
                echo "Skipped $dest"
                ;;
        esac
    else
        cat "$src" > "$dest"
        echo "Created $dest"
    fi
}

mkdir -p "${HOME}/.ssh"
confirm_and_copy "${FEATURE_DIR}/.ssh/config" "${HOME}/.ssh/config"
confirm_and_copy "${FEATURE_DIR}/.ssh/github" "${HOME}/.ssh/github"
confirm_and_copy "${FEATURE_DIR}/.netrc" "${HOME}/.netrc"
confirm_and_copy "${FEATURE_DIR}/.zshrc" "${HOME}/.zshrc"

# Install zsh
sudo apt-get update
sudo apt-get install -y zsh zsh-common zsh-syntax-highlighting zsh-autosuggestions
sudo chsh -s "$(which zsh)"
echo "Zsh installed and set as default shell."

echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "${HOME}/.zshrc"
echo "source /usr/share/zsh-common/zsh-autosuggestions/zsh-autosuggestions.zsh" >> "${HOME}/.zshrc"
