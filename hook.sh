#!/bin/bash

set -e

main() {
    # Get last merge-commit hash and iterate through commits from it to last commit.
    last_merge_commit_hash="$(git log --merges --oneline -1 --format=%H)"
    total_commit_messages=()
    while read -r commit_message; do
        total_commit_messages+=("${commit_message}")
    done < <(git log --oneline --reverse "$last_merge_commit_hash"..HEAD --format=%s)

    # Prepare commit messages for multiline commit.
    total_commands=""
    for i in "${total_commit_messages[@]}"; do
        total_commands+=" -m '$i'"
    done
    echo "Total commands: ${total_commands}"

    # Reset git HEAD to last merge commit, squash all commits with multiline commit message.
    git reset --soft "${last_merge_commit_hash}"
    # Preparing git commit command with disabled hooks.
    git_command="git commit --no-verify ${total_commands}"

    eval "${git_command}"
}


main
