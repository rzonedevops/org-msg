#!/bin/bash

# Script to sync microsoftgraph repos to local folders
# This creates a monorepo structure by cloning repos and removing .git directories
# to avoid submodules

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
        echo "  - Repository already exists, skipping..."
    else
        echo "  - Cloning repository..."
        if git clone "$repo_url" "$repo_path" 2>/dev/null; then
            echo "  - Removing .git directory to create monorepo structure..."
            rm -rf "$repo_path/.git"
            echo "  - Successfully integrated into monorepo"
        else
            echo "  - Failed to clone $repo (repository may not exist or be inaccessible)"
        fi
    fi
done

echo ""
echo "=================================================="
echo "Sync complete!"
echo "Repositories are integrated into monorepo at: $REPOS_DIR/"
echo "All .git directories have been removed to avoid submodules"
