#!/usr/bin/env bash

# Exit on error
set -o errexit

# Build a local .ssh folder on Render
mkdir -p ~/.ssh

# Add GitHub as a known host so it does not prompt you to add
# GitHub's IP address to known_hosts
ssh-keyscan -H github.com >> ~/.ssh/known_hosts 2> /dev/null

# Copy your secret file to the local .ssh folder and chmod it.
# This grabs the SSH_KEY from your environment group and
# reverses the Base64 encoding to transform it back into a file
echo "$SSH_KEY" | base64 -d > ~/.ssh/id_ecdsa
chmod 400 ~/.ssh/id_ecdsa

# This next piece sets up your SSH configuration for all
# hosts. More info about these commands is available on the web.
cat > ~/.ssh/config << EOF
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile /dev/null
   LogLevel ERROR
EOF

# Finally, we run our "pip" command.
# Replace this with "npm install" or any other command you
# use to install your dependencies
pip install -r requirements.txt
