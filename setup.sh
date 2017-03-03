files="ctags gitignore profile vimrc vim/"
dir=~/dotfiles
for file in $files; do
    if [ ! -e ~/.$file ]
        then
        ln -s $dir/$file ~/.$file
    fi
done
