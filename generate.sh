#!/usr/bin/env bash

# set -exo pipefail # debug mode
set -euo pipefail # production mode

echo "Generating files..."

mkdir -p "${FEATURE_DIR}/.ssh"
chmod 700 "${FEATURE_DIR}/.ssh"

# Generate the .zshrc file
cat <<EOF_A > "${FEATURE_DIR}/.zshrc"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
git config --global user.email "${GH_USER_EMAIL}"
git config --global user.name "${GH_USER_NAME}"
EOF_A

# Generate the .netrc file
cat <<EOF_B > "${FEATURE_DIR}/.netrc"
machine github.com
login oauth2
password ${GH_TOKEN}
EOF_B

# Generate the .ssh/config file
cat <<EOF_C > "${FEATURE_DIR}/.ssh/config"
Host github.com
    HostName github.com
    User ${GH_USER_NAME}
    IdentityFile ~/.ssh/github
    IdentitiesOnly yes
EOF_C

# Generate the .ssh/github file
cat <<EOF_D > "${FEATURE_DIR}/.ssh/github"
${GH_SSH_PRIVATE_KEY}
EOF_D
