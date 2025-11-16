# org-msg

Organization monorepo that contains Microsoft Graph repositories as unified source code.

## Overview

This repository provides a monorepo structure to sync and integrate repositories from the [Microsoft Graph GitHub organization](https://github.com/microsoftgraph) into a single repository. All cloned repositories have their `.git` directories removed to avoid submodules and create a true monorepo.

## Structure

- `repos-config.json` - Configuration file defining which microsoftgraph repos to include
- `repos.md` - Tab-separated data file listing all available Microsoft Graph repositories
- `sync-repos.sh` - Script to clone the repositories and integrate them into the monorepo
- `repos/` - Directory where repositories are cloned and integrated (committed to git)
- `.github/workflows/sync-repos.yml` - GitHub Actions workflow to automate syncing

## Usage

### Syncing Repositories

To sync repositories from microsoftgraph organization into the monorepo:

```bash
./sync-repos.sh
```

This script will:
1. Read the repository list from `repos-config.json`
2. Clone each repository into the `repos/` directory
3. Remove all `.git` directories to create a true monorepo (no submodules)
4. Integrate the source code directly into this repository

**Note:** The GitHub Actions workflow automatically runs this script daily and commits any new repositories.

### Configuration

The `repos-config.json` file is automatically generated from `repos.md`. To update it:

```bash
# Parse repos.md and regenerate repos-config.json
awk -F'\t' 'BEGIN {
    print "{"
    print "  \"source_org\": \"microsoftgraph\","
    print "  \"target_org\": \"rzonedevops/org-msg\","
    print "  \"repos\": ["
    first = 1
}
NR > 1 && $2 != "" {
    desc = $4
    gsub(/"/, "\\\"", desc)
    if (!first) print ","
    first = 0
    printf "    {\n"
    printf "      \"name\": \"%s\",\n", $2
    printf "      \"description\": \"%s\"\n", desc
    printf "    }"
}
END {
    print "\n  ]"
    print "}"
}' repos.md > repos-config.json
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

## Monorepo Approach

This repository uses a **true monorepo** approach:
- All Microsoft Graph repositories are cloned into the `repos/` directory
- The `.git` directories are removed from each cloned repository
- This avoids git submodules and creates a unified source tree
- All code is committed directly to this repository
- The GitHub Actions workflow automatically syncs new repositories daily

### Benefits

- Single git history for all Microsoft Graph code
- No submodule complexity
- Easy to search across all repositories
- Simplified dependency management
- Centralized issue tracking

## Mapped Repositories

This monorepo currently includes 235 repositories from the Microsoft Graph organization. See `repos-config.json` for the complete list.

Some notable repositories included:
- Microsoft Graph SDKs (.NET, JavaScript, Python, Java, PHP, Go, PowerShell, etc.)
- Microsoft Graph samples and training modules
- Microsoft Graph documentation
- Microsoft Graph tooling and utilities

## Automation

The repository uses GitHub Actions to automatically:
1. Run the sync script daily at 00:00 UTC
2. Clone any new repositories listed in `repos-config.json`
3. Remove `.git` directories from cloned repositories
4. Commit and push changes to the main branch

Manual sync can also be triggered via the GitHub Actions UI.

## License

This mapping repository follows the licenses of the individual mapped repositories from the Microsoft Graph organization.