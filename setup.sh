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



###!/bin/bash
##
##pdir=$(pwd)
##cdir=$(dirname $0 | sed -e 's/^\.//g')
##dir=$(echo $pdir/$cdir/dotfiles | sed -e 's/\/\/*/\//g')
##
### Function to create symlinks recursively
##create_symlinks() {
##    local source_dir="$1"
##    local target_dir="$2"
##    
##    for item in "$source_dir"/*; do
##        # Get the relative path from the dotfiles directory
##        local rel_path="${item#$dir/}"
##        local target="$target_dir/.$rel_path"
##        
##        if [ -d "$item" ]; then
##            # If it's a directory, create it if it doesn't exist and recurse
##            if [ ! -d "$target" ]; then
##                echo "creating directory $target"
##                mkdir -p "$target"
##            fi
##            create_symlinks "$item" "$target_dir"
##        else
##            # If it's a file, create symlink if it doesn't exist
##            if [ ! -e "$target" ]; then
##                echo "creating symlink for $rel_path"
##                # Create parent directory if it doesn't exist
##                mkdir -p "$(dirname "$target")"
##                ln -s "$item" "$target"
##            else
##                echo "$rel_path already exists"
##            fi
##        fi
##    done
##}
##
### Start the recursive symlink creation from the dotfiles directory to home
##create_symlinks "$dir" "$HOME"
