#!/bin/bash

#set -x

dir=$(dirname $(realpath "$0"))
os=$(uname -a | cut -d ' ' -f 1)
mini_install=""

cd $dir

echo "Setting up on $os..."
if [ "$os" != "Darwin" ] && [ "$os" != "Linux" ]
then
	echo "Setup for $os is not supported"
	exit 1
fi

if [[ "$@" =~ "mini" ]]
then
	mini_install="mini"
fi

function setup_vimrc() {
	mini_ver=$1
	if [[ "$mini_ver" == "mini" ]]
	then
		mkdir -p ~/.vim/undo-dir
		mkdir -p ~/.vim/plugin/
		cp ./vim_plugin/auto-pairs.vim ~/.vim/plugin
		cp ./.vimrc.mini ~/
		echo "source ~/.vimrc.mini" >> ~/.vimrc
	else
		cp ./.vimrc.local ~/
		echo "source ~/.vimrc.local" >> ~/.vimrc
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		vim +PlugInstall +qall
	fi
}

function get_tools() {
	echo "Downloading tools..."
	if [[ "$os" == "Darwin" ]]
	then
		brew install gdb tig tmux tree vim wget watch grep htop ctags curl
	elif [[ "$os" == "Linux" ]]
	then
		apt update
		apt install -y build-essential tmux tree tig htop vim universal-ctags \
			silversearcher-ag curl
	else
		exit 1
	fi
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

function setup_others() {
	cp ./.tmux.conf ~/
	cp ./.ctags ~/
}

get_tools
setup_vimrc $mini_install
setup_others
