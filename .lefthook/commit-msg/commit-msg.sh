#!/bin/zsh
echo "Checking your commit message"

commit_regex='^\[FCA\] .*$'
error_msg="Bad commit message. See example: \"[FCA] some text\""

if ! grep -iqE "$commit_regex" "$1"; then
    echo "$error_msg" >&2
    exit 1
fi
