dir=$(dirname $0)
for filename in $dir/dotfiles/*; do
    file=$(basename $filename)
    if [ ! -e ~/.$file ]
        then
	echo "copying $file"
        ln -s $dir/dotfiles/$file ~/.$file
    else
        echo "$file already copied"
    fi
done
