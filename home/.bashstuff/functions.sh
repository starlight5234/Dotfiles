#!/bin/bash

gesetup(){
	curl -Lo .git/hooks/commit-msg https://raw.githubusercontent.com/starlight5234/starlight5234/main/commit-msg && chmod u+x .git/hooks/commit-msg
}

gcps(){
	git cherry-pick -s
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

sshvm(){

	echo "Setup SSH key path & username in ~/.bashstuff/functions.sh"
	#ssh -i ~/.ssh/yourkey yourkey@${1}
	
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

function tg_msg() {

        export BOT="$BOT_TOKEN"
	curl -s "https://api.telegram.org/bot$BOT/sendMessage" \
		-d "parse_mode=html" \
		-d text="${1}" \
		-d chat_id="-342084368" \
		-d "disable_web_page_preview=true"
}

function compile-vince(){

        . build/env*sh
        make installclean
        rm out/target/product/vince/*.zip
        lunch ${1}_vince-userdebug
        make bacon && tg_msg "Compilation Completed" || tg_msg "Compilation Failed"

}                                                          

function shut(){
	sudo shutdown -h 1
}

function adb_push_keys(){

	adb push ~/.android/adbkey.pub /data/misc/adb/adb_keys

}

function gdrive_download() {
          CONFIRM=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$1" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
            wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$CONFIRM&id=$1" -O $2
              rm -rf /tmp/cookies.txt
      }


function fix_drive_mount(){
	sudo umount /dev/${1}
	sudo ntfsfix /dev/${1}
	sudo mount -o rw /dev/${1} /mnt/${2}
}

PATH="/home/starlight/.google-drive-upload/bin:${PATH}"
