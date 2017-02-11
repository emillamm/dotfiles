files="ctags gitconfig gitignore profile vimrc"
dir=~/dotfiles
for file in $files; do
    ln -s $dir/$file ~/.$file
done
