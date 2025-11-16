# org-msg

Organization repository that maps Microsoft Graph repositories to local folders.

## Overview

This repository provides a mapping system to sync and track repositories from the [Microsoft Graph GitHub organization](https://github.com/microsoftgraph) into organized folders within this repository structure.

## Structure

- `repos-config.json` - Configuration file defining which microsoftgraph repos to map
- `sync-repos.sh` - Script to sync/clone the mapped repositories into local folders
- `repos/` - Directory where mapped repositories are cloned (excluded from git via .gitignore)

## Usage

### Syncing Repositories

To sync repositories from microsoftgraph organization to local folders:

```bash
./sync-repos.sh
```

This script will:
1. Read the repository list from `repos-config.json`
2. Clone or update each repository into the `repos/` directory
3. Maintain the latest version of each mapped repository

### Configuration

Edit `repos-config.json` to add or remove repositories to map:

```json
{
  "source_org": "microsoftgraph",
  "target_org": "rzonedevops/org-msg",
  "repos": [
    {
      "name": "repository-name",
      "description": "Repository description"
    }
  ]
}
```

### Requirements

- Git
- jq (JSON processor)
- Bash

Install jq on Ubuntu/Debian:
```bash
sudo apt-get install jq
```

Install jq on macOS:
```bash
brew install jq
```

## Mapped Repositories

The following Microsoft Graph repositories are currently mapped:

- [msgraph-sdk-dotnet](https://github.com/microsoftgraph/msgraph-sdk-dotnet) - Microsoft Graph .NET SDK
- [msgraph-sdk-javascript](https://github.com/microsoftgraph/msgraph-sdk-javascript) - Microsoft Graph JavaScript SDK
- [msgraph-sdk-python](https://github.com/microsoftgraph/msgraph-sdk-python) - Microsoft Graph Python SDK
- [msgraph-sdk-java](https://github.com/microsoftgraph/msgraph-sdk-java) - Microsoft Graph Java SDK
- [msgraph-sdk-php](https://github.com/microsoftgraph/msgraph-sdk-php) - Microsoft Graph PHP SDK

## License

This mapping repository follows the licenses of the individual mapped repositories from the Microsoft Graph organization.