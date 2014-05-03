
SH=$(cd `dirname $0` && pwd)
GN=$(basename "$SH")

FILES=".vim .vimrc .gitconfig .bash_aliases"

for F in $FILES; do
    F_=$(basename $F)
    echo "alias $F_ -> $F"
	rm -rf ~/$F_
	ln -s "$SH/$F" ~/$F_ || exit 1
done

#cd "$SH"
#git submodule init || exit 2
#git submodule update || exit 3

$SH/fonts/install.sh || exit 4

echo "done"
