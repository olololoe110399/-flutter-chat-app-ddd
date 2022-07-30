#!/bin/zsh
echo "Checking your branch name"
LC_ALL=C

local_branch="$(git rev-parse --abbrev-ref HEAD)"

vaild_branch_regex='^(feature|bugfix|improvement|release|hotfix)\/FCA_.*$'

message="$local_branch is bad branch name. See example: feature/FCA_some_text"

if [[ ! $local_branch =~ $vaild_branch_regex ]]
then 
    echo $message
    exit 1
fi

exit 0
