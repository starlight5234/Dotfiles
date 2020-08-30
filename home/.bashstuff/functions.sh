#!/bin/bash

shopt -s expand_aliases
source ~/.bashstuff/aliases

gcp(){
	git cherry-pick ${1} ${2} ${3} ${4} ${5} ${6}
}

continue(){
	gcp --continue
}
git_config() {

	echo "Setup your credentials in function.sh"
	#echo -e "Setting up existing credentials.\n"
	#git config --global user.name "username"
	#git config --global user.email "your@email"

}

sshvm(){

	echo "Setup SSH key path & username in ~/.bashstuff/functions.sh"
	#ssh -i ~/.ssh/yourkey yourkey@${1}
	
}

abort(){
	
	echo "Aborting commit"
	gcp --abort &>/dev/null
	git merge --abort &>/dev/null
	git am --abort &>/dev/null
	
}

skip(){

	echo "Skipping commit"
	gcp --skip &>/dev/null

}
