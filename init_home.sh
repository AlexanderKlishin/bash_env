
SH=$(cd `dirname $0` && pwd)

FILES=".vim .vimrc .gitconfig .bash_aliases .tmux.conf .inputrc"

for F in $FILES; do
    F_=$(basename $F)
    echo "alias $F_ -> $F"
	rm -rf ~/$F_
	ln -s "$SH/$F" ~/$F_ || exit 1
done

cd "$SH"
git submodule init || exit 2
git submodule update --init --recursive || exit 2

./fonts/install.sh || exit 3

echo "done"
