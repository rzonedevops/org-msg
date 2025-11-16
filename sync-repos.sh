#!/bin/bash

# Script to sync microsoftgraph repos to local folders
# This creates a mapping of repos to folders within this org-msg repository

set -e

CONFIG_FILE="repos-config.json"
REPOS_DIR="repos"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed. Please install jq to continue."
    exit 1
fi

# Read configuration
SOURCE_ORG=$(jq -r '.source_org' "$CONFIG_FILE")
REPOS=$(jq -r '.repos[].name' "$CONFIG_FILE")

echo "Syncing repositories from github.com/$SOURCE_ORG to $REPOS_DIR/"
echo "=================================================="

# Create repos directory if it doesn't exist
mkdir -p "$REPOS_DIR"

# Process each repository
for repo in $REPOS; do
    echo ""
    echo "Processing: $repo"
    repo_path="$REPOS_DIR/$repo"
    repo_url="https://github.com/$SOURCE_ORG/$repo.git"
    
    if [ -d "$repo_path" ]; then
        echo "  - Updating existing repository..."
        cd "$repo_path"
        git fetch --all
        git pull origin main || git pull origin master || echo "  - Could not pull, branch might not exist"
        cd - > /dev/null
    else
        echo "  - Cloning repository..."
        git clone "$repo_url" "$repo_path" || echo "  - Failed to clone $repo"
    fi
done

echo ""
echo "=================================================="
echo "Sync complete!"
echo "Repositories are mapped to folders in: $REPOS_DIR/"
