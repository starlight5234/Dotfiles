
# Copyright (C) 2020 Starlight5234

# shell settings
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# bash & zsh completion
autoload bashcompinit && bashcompinit
autoload -U compinit && compinit

### Aliases ###
# Git
alias gcl="git clone"
alias gpull="git pull"
alias gca="git commit --amend"
alias gcm="git commit -m"
alias gm="git merge"
alias gi="git init"
alias ga="git add"
alias gam="git am"
alias gra="git remote add"
alias grh="git reset --hard"
alias gb="git branch"
alias gbd="git branch -D"
alias gsw="git switch"
alias gs="git status"
alias gl="git log"
alias glo="git log --pretty=oneline"
alias gco="git checkout"
alias gri="git rebase -i"
alias fetch="git fetch"
alias push="git push"
alias upush="git push -u"
alias fpush="git push -f"
alias fupush="git push -fu"
alias adbk="adb kill-server && sudo adb start-server"
alias gcp="git cherry-pick"

# Misc
alias py="python3"
alias l="ls -CAF"

# Package manager
alias cleanc="sudo apt autoclean" # Clean partial package
alias cleanOr="sudo apt autoremove" # Clean unused dependencies
alias install="sudo apt install -y"
alias rem="sudo apt autoremove"
alias search="sudo apt search"
alias show="sudo apt show"
alias upd="sudo apt update"
alias upg="sudo apt upgrade"

