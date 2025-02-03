#!/usr/bin/env bash

# Get absolute path to the dotfiles directory
pdir=$(pwd)
cdir=$(dirname "$0" | sed -e 's/^\.//g')    # remove leading .
dir=$(echo "$pdir/$cdir/dotfiles" | sed -e 's/\/\/*/\//g') # remove double slashes

# Make sure dotfiles directory actually exists
if [ ! -d "$dir" ]; then
  echo "Error: '$dir' does not exist or is not a directory."
  exit 1
fi

# Recursively process everything under dotfiles/
# -mindepth 1 ensures we skip the top-level directory itself
find "$dir" -mindepth 1 -print0 | while IFS= read -r -d '' entry; do
  # Strip the $dir prefix from the path to get the relative path
  rel="${entry#$dir/}"
  
  # Construct the corresponding target in the home directory,
  # prepending a dot to the top-level item
  # e.g., if rel = "config/nvim/init.vim", target = ~/.config/nvim/init.vim
  target="$HOME/.$rel"

  # If it's a directory, ensure the target directory exists
  if [ -d "$entry" ]; then
    if [ ! -d "$target" ]; then
      echo "Creating directory: $target"
      mkdir -p "$target"
    fi
  else
    # If it's a file (or symlink, etc.), create a symlink if it doesn't already exist
    if [ ! -e "$target" ]; then
      echo "Symlinking: $target -> $entry"
      ln -s "$entry" "$target"
    else
      echo "Already exists: $target (skipping)"
    fi
  fi
done
