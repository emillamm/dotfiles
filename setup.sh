pdir=$(pwd)
cdir=$(dirname $0 | sed -e 's/^\.//g') # remove leading .
dir=$(echo $pdir/$cdir/dotfiles | sed -e 's/\/\/*/\//g') # remove double slashes
for filename in $dir/*; do
    file=$(basename $filename)
    if [ ! -e ~/.$file ]
        then
	echo "copying $file"
        ln -s $dir/$file ~/.$file
    else
        echo "$file already copied"
    fi
done

