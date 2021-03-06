#!/bin/sh

CUR_DIR="$(pwd)"

# YUM_CMD=$(which yum)
APT_CMD=$(which apt)

printf "\n===== Installing build-essential cmake vim.. ====="
# if [ ! -z $YUM_CMD ]; then
# 	sudo yum update -y
# 	sudo yum install -y build-essential cmake vim-gtk
# elif [ ! -z $APT_CMD ]; then 
if [ ! -z $APT_CMD ]; then 
	sudo apt update -y && sudo apt upgrade -y
	sudo add-apt-repository ppa:jonathonf/vim -y
	sudo apt update -y && sudo apt upgrade -y
	sudo apt install -y build-essential cmake
	sudo apt install -y vim-gtk
else
	printf "\nNOT SUPPORT :))"
	exit 1
fi

printf "\n===== Copying config files.. ====="
cp .bashrc ~/.bashrc
cp .bash_aliases ~/.bash_aliases
cp .vimrc ~/.vimrc
cp .ycm_extra_conf.py ~/.ycm_extra_conf
cp .inputrc ~/.inputrc
cp .tmux.conf ~/.tmux.conf

printf "\n===== Setup YouCompleteMe.. ====="
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
python3 install.py


cd $CUR_DIR
printf "\n===== Copy vim template ====="
cp -r templates ~/.vim/templates


printf "\n===== Install fzf.. ====="
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
bash ~/.fzf/install --all


printf "\n==== DONE ===="
