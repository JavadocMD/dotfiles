#!/bin/bash
set -euo pipefail

# Get installed version (if any)
installed_version=$(apt list --installed 2>/dev/null | grep '^discord/' || true)
if [ -n "$installed_version" ]; then
    installed_version=$(echo "$installed_version" | awk '{print $2}')
else
    installed_version="(none)"
fi
echo "Installed version: $installed_version"

# Discover latest version
response=$(curl -sI https://discord.com/api/download?platform=linux)
status_code=$(echo "$response" | grep -oP '(?<=HTTP/2 )\d+')
if [ "$status_code" != "302" ]; then
    echo "ERROR: unexpected response code: $status_code"
    echo "$response"
    exit 1
fi
location=$(echo "$response" | grep -i "location:" | sed 's|location: ||I' | tr -d '\r')
online_version=$(echo "$location" | sed -n 's|.*linux/\([0-9.]*\)/discord.*|\1|p')
echo "Latest version: $online_version"

if [ "$installed_version" == "$online_version" ]; then
    echo "Discord is up to date."
    exit 0
fi

# Update
echo "Downloading discord from $location"
file="$HOME/Downloads/$(basename "$location")"
wget -qO "$file" $location
echo "Updating discord..."
sudo apt install "$file"
rm "$file"

echo "Updated discord to $online_version"
