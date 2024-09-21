#!/usr/bin/env fish

function sync_submodule
    echo "Syncing Tech submodule..."
    cd Tech
    if test (git status --porcelain | wc -l) -gt 0
        git add .
        git commit -m "Update Tech submodule: $argv"
        git push origin main
    else
        echo "No changes in Tech submodule."
    end
    cd ..
end

function sync_main_repo
    echo "Syncing main repository..."
    if test (git status --porcelain | grep -v "Tech/" | wc -l) -gt 0
        git add .
        git commit -m "Update main repo: $argv"
        git push origin main
    else
        echo "No changes in main repository."
    end
end

function git_sync
    set -l commit_message $argv[1]
    if test -z "$commit_message"
        set commit_message "Sync changes"
    end

    # Check if we're in the root directory
    if not test -d .git
        echo "Please run this script from the root of your git repository."
        return 1
    end

    # Check if Tech submodule exists
    if not test -d Tech
        echo "Tech submodule not found. Please ensure it's properly set up."
        return 1
    end

    # Sync submodule first
    sync_submodule $commit_message

    # Then sync main repo
    sync_main_repo $commit_message

    echo "Sync complete!"
end

# Run the sync function with the provided commit message
git_sync $argv