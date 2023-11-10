#!/run/current-system/sw/bin/bash

# Source the Github Personal Access Token
source ~/.config/polybar/scripts/github-pat.sh

# Replace these variables with your actual values
GITHUB_USERNAME="NixOS"
GITHUB_REPO="nixpkgs"
GITHUB_BRANCH="nixos-unstable"

# API endpoints
BRANCH_URL="https://api.github.com/repos/${GITHUB_USERNAME}/${GITHUB_REPO}/branches/${GITHUB_BRANCH}"
COMMIT_URL="https://api.github.com/repos/${GITHUB_USERNAME}/${GITHUB_REPO}/commits"

# Function to fetch commits
get_latest_commit_info() {
  local url="$1"
  curl -s -H "Authorization: token ${YOUR_GITHUB_PAT}" "$url" | jq -r '.commit.sha'
}

# Function to compare the latest commit with the stored one
is_new_commit() {
  local latest_commit="$1"
  local old_commit="$2"

  [ "$latest_commit" != "$old_commit" ]
}

# Get the latest commit SHA
read -r latest_commit <<< "$(get_latest_commit_info "$BRANCH_URL")"

# Retrieve old commit SHA
if [ -f ~/.config/polybar/scripts/latest_commit_temp.txt ]; then
  read -r old_commit < ~/.config/polybar/scripts/latest_commit.txt
  old_commit=$(echo "$old_commit" | tr -d '\n')  # Remove newline characters
else
  old_commit=""
fi

# Compare the latest commit SHA with the previous one
if is_new_commit "$latest_commit" "$old_commit"; then
  echo "%{F#fab387}󱧘  %{F-}NixOS: Update Available! "

  # Store the latest commit information in a temporary file
  echo "$latest_commit" > ~/.config/polybar/scripts/latest_commit_temp.txt
else
  echo "%{F#a6e3a1}  %{F-}Latest "
fi
