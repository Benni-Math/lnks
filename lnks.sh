#!/usr/bin/env bash

# NOTE: Nix will set the appropriate dependent packages in the $PATH
# (for this script, it puts `vim` and `fzf` in the $PATH)
# and set these flags:
# set -o errexit
# set -o nounset
# set -o pipefail

# Setup optional variables
keep_open=false
dir="$HOME/.bookmarks"
edit_file=""

# Usage print, for when --help is specified
usage () {
    echo "Usage: $(basename "$0") [OPTIONS...]"
    echo "  -k         --keep-open     Keep lnks open after selecting a bookmark"
    echo "  -d <dir>   --dir <dir>     Specify a directory where bookmarks files are stored"
    echo "  -e <file>  --edit <file>   Edit the specified bookmarks file (with vim)"
    exit 0
}

# Check for flags
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -k|--keep-open) keep_open=true ;;
        -d|--dir) dir="$2"; shift ;;
        -h|--help) usage ;;
        -e|--edit) [[ "$2" = *.txt ]] && edit_file="$2" || edit_file="$2.txt"; shift ;;
        *) echo "Unknown parameter passed: $1" >&2; exit 1 ;;
    esac
    shift
done

# Setup command for opening URLs in browser
if type explorer.exe &> /dev/null; then
    open_command="explorer.exe"
elif type open &> /dev/null; then
    open_command="open"
elif type xdg-open &> /dev/null; then
    open_command="xdg-open"
fi

enter_command="enter:execute-silent(${open_command} {-1})"

if [ "$keep_open" = true ]; then
    enter_command="${enter_command}+clear-query"
else
    enter_command="${enter_command}+abort"
fi

# Create directory if it doesn't exist
if [ ! -d "$dir" ]; then
  mkdir -p "$dir"
fi

# Edit bookmark file
if [[ -n "$edit_file" ]]; then
    vim "$dir/$edit_file"
    exit 0
fi

# Use fzf to search the bookmark files
cat "$dir"/*.txt | fzf \
    --border=rounded \
    --prompt="Search Bookmarks > " \
    --with-nth='1..-2' \
    --bind="${enter_command}" \
    --preview='echo {-1}' \
    --preview-window='up,1'
