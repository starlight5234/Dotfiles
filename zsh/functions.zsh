
# Copyright (C) 2020 Starlight5234

gesetup(){
	curl -Lo .git/hooks/commit-msg https://raw.githubusercontent.com/starlight5234/starlight5234/main/commit-msg && chmod u+x .git/hooks/commit-msg
}

gcontinue(){
	git cherry-pick --continue
}

git_config() {
	#echo "Setup your credentials in function.sh"
	echo -e "Setting up existing credentials.\n"
	git config --global user.name "starlight5234"
	git config --global user.email "starlight5234@protonmail.ch"
	git config --global core.editor vim
	git config --global credential.helper store
	git config --global pull.rebase true
}

gabort(){
	echo "Aborting commit"
	git cherry-pick --abort &>/dev/null
	git merge --abort &>/dev/null
	git am --abort &>/dev/null
}

gskip(){
	echo "Skipping commit"
	git cherry-pick --skip
}

attach_sess(){
	tmux attach-session -t ${1}
}

new_sess(){
	tmux new -s ${1}
}

function adb_push_keys(){
	adb push ~/.android/adbkey.pub /data/misc/adb/adb_keys
}

function fix_drive_mount(){
	sudo umount /dev/${1}
	sudo ntfsfix /dev/${1}
	sudo mount -o rw /dev/${1} /mnt/${2}
}
