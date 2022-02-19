#! /usr/bin/env zsh
#! /bin/sh

#Copyright (C) 2020 Starlight5234

# Install Prezto
[ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ] && git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Install Oh My ZSH
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O zsh/zsh-install.sh
sh zsh/zsh-install.sh
rm zsh/zsh-install.sh

# Install ZSH Auto-suggestions
[ ! -d "${ZDOTDIR:-$HOME}/.oh-my-zsh/custom/plugins/zsh-auto-suggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

cp -f $(pwd)/zsh/p10k.zsh ~/.p10k.zsh
cp -f $(pwd)/zsh/zshrc ~/.zshrc
cp -f $(pwd)/zsh/starlight.zsh-theme ~/.oh-my-zsh/themes/

setopt EXTENDED_GLOB
echo "Linking rc files"

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
echo "Linking completed"

cp -f $(pwd)/zsh/zpreztorc ~/.zpreztorc

[ ! -d ~/.zsh ] && mkdir ~/.zsh
cp -f $(pwd)/zsh/config.zsh ~/.zsh/
cp -f $(pwd)/zsh/functions.zsh ~/.zsh/
