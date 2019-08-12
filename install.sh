#!/usr/bin/env bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

################################################################################
# Disable prompts
################################################################################
export DEBIAN_FRONTEND=noninteractive

################################################################################
# Update / upgrade
################################################################################
sudo apt update
sudo apt dist-upgrade -y

################################################################################
# Purge
################################################################################
sudo apt purge -y \
  apport \
  chromium-* \
  cmdtest \
  laptop-mode-tools \
  ubuntu-web-launchers

################################################################################
# Basic packages
################################################################################
sudo apt install -y \
  apt-transport-https \
  curl \
  git \
  software-properties-common \
  tmux \
  ubuntu-restricted-extras \
  wget \
  xsel \
  zsh

################################################################################
# Enable universe repository
################################################################################
sudo add-apt-repository universe
sudo apt update

################################################################################
# Enable exFat
################################################################################
sudo apt install -y \
  exfat-fuse \
  exfat-utils

################################################################################
# 7Zip
################################################################################
sudo apt install -y \
  p7zip-full \
  p7zip-rar

################################################################################
# Rar
################################################################################
sudo apt install -y \
  unrar \
  rar

################################################################################
# Zip
################################################################################
sudo apt install -y \
  unzip \
  zip

################################################################################
# Docker
################################################################################
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y \
  docker-ce
sudo usermod -a -G docker "$USER"

################################################################################
# Node.js / Yarn / Packages
################################################################################
# Node.js
curl -fsSL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt update
sudo apt install -y \
  nodejs

# Yarn
curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo -e "deb [arch=amd64] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y \
  yarn

# Node.js packages
sudo yarn global add \
  eslint \
  fkill-cli \
  neovim \
  ngrok \
  prettier \
  tslint \
  typescript \
  vtop \
  --ignore-optional

################################################################################
# Python / Pip / Packages
################################################################################
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get update
sudo apt install -y \
  python3-pip \
  python3.8

pip3 install --user \
  pipenv \
  black \
  vim-vint

################################################################################
# Ruby / Packages
################################################################################
sudo apt install -y \
  ruby-full

sudo gem install \
  bundler \
  neovim \
  rails

bundle config --global jobs $(($(grep -c processor < /proc/cpuinfo) - 1))

################################################################################
# Spotify
################################################################################
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo -e "deb [arch=amd64] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install -y \
  spotify-client

################################################################################
# Chrome
################################################################################
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo -e "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install -y \
  google-chrome-stable

################################################################################
# Firefox
################################################################################
sudo apt install -y \
  firefox

################################################################################
# Opera
################################################################################
curl -fsSL https://deb.opera.com/archive.key | sudo apt-key add -
echo -e "deb [arch=amd64] https://deb.opera.com/opera-stable/ stable non-free" | sudo tee /etc/apt/sources.list.d/opera-stable.list
sudo apt update
sudo apt install -y \
  opera-stable

################################################################################
# VirtualBox / Vagrant
################################################################################
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
sudo apt update
sudo apt install -y \
  virtualbox-6.0
sudo adduser "$USER" vboxusers

sudo apt install -y \
  vagrant

################################################################################
# DBeaver
################################################################################
sudo add-apt-repository -y ppa:serge-rider/dbeaver-ce
sudo apt update
sudo apt install -y \
  dbeaver-ce

################################################################################
# MySQL Workbench
################################################################################
sudo apt install -y \
  mysql-workbench

################################################################################
# Vim / gVim / Neovim / Plugins dependencies
################################################################################
# Vim / gVim
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt update
sudo apt install -y \
  vim \
  vim-gnome

# Neovim
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y \
  python-dev \
  python-pip \
  python3-dev \
  python3-pip \
  neovim

# YouCompleteMe
sudo apt install -y \
  build-essential \
  cmake \
  python3-dev

# CtrlP
sudo add-apt-repository -y ppa:x4121/ripgrep
sudo apt update
sudo apt install \
  ripgrep

# Tagbar
sudo add-apt-repository -y ppa:hnakamur/universal-ctags
sudo apt update
sudo apt install \
  universal-ctags

################################################################################
# Atom / Packages
################################################################################
curl -fsSL https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
echo -e "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" | sudo tee /etc/apt/sources.list.d/atom.list
sudo apt update
sudo apt install -y \
  atom

apm install \
  sync-settings

################################################################################
# Visual Studio Code
################################################################################
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo -e "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y \
  code \
  code-insiders

################################################################################
# IntelliJ IDEA
################################################################################
sudo add-apt-repository -y ppa:mmk2410/intellij-idea
sudo apt update
sudo apt install -y \
  intellij-idea-community

################################################################################
# Sublime Text 3 / packages
################################################################################
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo -e "deb [arch=amd64] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y \
  sublime-text

curl -fLo \
  "$HOME/.config/sublime-text-3/Installed\ Packages\ Package\ Control.sublime-package" \
  --create-dirs https://packagecontrol.io/Package%20Control.sublime-package

################################################################################
# Terraform
################################################################################
curl -fsSL https://tjend.github.io/repo_terraform/repo_terraform.key | sudo apt-key add -
echo -e "deb [arch=amd64] https://tjend.github.io/repo_terraform stable main" | sudo tee /etc/apt/sources.list.d/terraform.list
sudo apt update
sudo apt install -y \
  terraform

################################################################################
# Gnome
################################################################################
sudo apt install -y \
  gnome-screensaver \
  gnome-shell-extensions \
  gnome-sushi \
  gnome-tweak-tool

################################################################################
# VeraCrypt
################################################################################
sudo add-apt-repository -y ppa:unit193/encryption
sudo apt update
sudo apt install -y \
  veracrypt

################################################################################
# GnuCash
################################################################################
sudo add-apt-repository -y ppa:sicklylife/gnucash
sudo apt update
sudo apt install -y \
  gnucash

################################################################################
# GPG
################################################################################
sudo apt install -y \
  gpg \
  gnupg-agent

################################################################################
# Mutt
################################################################################
sudo apt install -y \
  neomutt

################################################################################
# Lynx
################################################################################
sudo apt install -y \
  lynx

################################################################################
# Shellcheck
################################################################################
sudo apt install -y \
  shellcheck

################################################################################
# Dropbox
################################################################################
sudo apt install -y \
  nautilus-dropbox

################################################################################
# Hack Nerd Font
################################################################################
sudo apt install -y \
  fonts-hack-ttf
curl -fLo \
  "$HOME/.local/share/fonts/Hack Regular Nerd Font Complete.ttf" \
  --create-dirs https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
sudo fc-cache -fv

################################################################################
# Tilix
################################################################################
sudo apt install -y \
  tilix

curl -fLo \
  "$HOME/.config/tilix/schemes/Dracula.json" \
  --create-dirs https://raw.githubusercontent.com/krzysztofzuraw/dracula-tilix/master/Dracula.json

################################################################################
# Conky
################################################################################
sudo apt install -y \
  conky-all

################################################################################
# VLC
################################################################################
sudo apt install -y \
  vlc

################################################################################
# Transmission
################################################################################
sudo apt install -y \
  transmission

################################################################################
# Steam
################################################################################
sudo apt install -y \
  steam

################################################################################
# Filezilla
################################################################################
sudo apt install -y \
  filezilla

################################################################################
# Asciinema
################################################################################
sudo apt install -y \
  asciinema

################################################################################
# Preload
################################################################################
sudo apt install -y \
  preload

################################################################################
# Neofetch
################################################################################
sudo apt install -y \
  neofetch

################################################################################
# TLP
################################################################################
sudo add-apt-repository -y ppa:linrunner/tlp
sudo apt update
sudo apt install -y \
  tlp

################################################################################
# Touchpad Indicator
################################################################################
sudo add-apt-repository -y ppa:atareao/atareao
sudo apt-get update
sudo apt-get install -y \
  touchpad-indicator

################################################################################
# Gimp
################################################################################
sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
sudo apt update
sudo apt install -y \
  gimp \
  gimp-data \
  gimp-data-extras \
  gimp-gmic \
  gimp-plugin-registry \
  gmic

################################################################################
# Inkscape
################################################################################
sudo add-apt-repository -y ppa:inkscape.dev/stable
sudo apt update
sudo apt install -y \
  inkscape

################################################################################
# Krita
################################################################################
sudo add-apt-repository -y ppa:kritalime/ppa
sudo apt update
sudo apt install -y \
  krita \
  krita-l10n
  krita-nautilus-thumbnailer

################################################################################
# Shotcut
################################################################################
sudo add-apt-repository -y ppa:haraldhv/shotcut
sudo apt update
sudo apt install -y \
  shotcut

################################################################################
# Blender
################################################################################
sudo add-apt-repository -y ppa:thomas-schiex/blender
sudo apt update
sudo apt install -y \
  blender \
  nvidia-modprobe
sudo adduser "$USER" video

################################################################################
# My Weather Indicator
################################################################################
sudo add-apt-repository -y ppa:atareao/atareao
sudo apt update
sudo apt install -y \
  my-weather-indicator

################################################################################
# Caffeine
################################################################################
sudo apt install -y \
  caffeine

################################################################################
# Variety
################################################################################
sudo apt install -y \
  variety

################################################################################
# Stacer
################################################################################
sudo add-apt-repository -y ppa:oguzhaninan/stacer
sudo apt update
sudo apt install -y \
  stacer

################################################################################
# Handbrake
################################################################################
sudo add-apt-repository -y ppa:stebbins/handbrake-releases
sudo apt update
sudo apt install -y \
  handbrake-cli \
  handbrake-gtk

################################################################################
# Brasero
################################################################################
sudo apt install -y \
  brasero

################################################################################
# Okular
################################################################################
sudo apt install -y \
  okular

################################################################################
# uGet
################################################################################
sudo add-apt-repository -y ppa:plushuang-tw/uget-stable
sudo apt update
sudo apt install -y \
  uget

################################################################################
# Shutter
################################################################################
sudo apt install -y \
  shutter

################################################################################
# Peek
################################################################################
sudo add-apt-repository -y ppa:peek-developers/stable
sudo apt update
sudo apt install -y \
  peek

################################################################################
# Diodon
################################################################################
sudo add-apt-repository -y ppa:diodon-team/stable
sudo apt update
sudo apt install -y \
  diodon

################################################################################
# Retro games and emulators
################################################################################
sudo add-apt-repository -y ppa:samoilov-lex/retrogames
sudo apt update
sudo apt install -y \
  citra \
  ioquake3 \
  mgba-sdl \
  ppsspp \
  reicast \
  reicast-joyconfig \
  retroarch \
  snes9x

################################################################################
# Drivers
################################################################################
# Mesa
sudo add-apt-repository -y ppa:oibaf/graphics-drivers

# nVIDIA
sudo add-apt-repository -y ppa:graphics-drivers/ppa

sudo apt update
sudo apt upgrade -y
sudo apt install -y \
  mesa-vulkan-drivers \
  vulkan-utils

################################################################################
# Settings
################################################################################
# Move /tmp to RAM
echo -e "# Move /tmp to RAM" | sudo tee -a /etc/fstab
echo -e "tmpfs /tmp tmpfs defaults,exec,nosuid 0 0,size=128M" | sudo tee -a /etc/fstab

# Move /var/tmp to RAM
echo -e "# Move /var/tmp to RAM" | sudo tee -a /etc/fstab
echo -e "tmpfs /var/tmp tmpfs defaults,exec,nosuid 0 0,size=128M" | sudo tee -a /etc/fstab

# Move /var/log to RAM
echo -e "# Move /var/log to RAM" | sudo tee -a /etc/fstab
echo -e "tmpfs /var/log tmpfs defaults,noexec,nosuid 0 0,size=16M" | sudo tee -a /etc/fstab

# Run fstrim daily
echo -e "#\!/bin/sh\n" | sudo tee /etc/cron.daily/fstrim
echo -e "/sbin/fstrim --all || exit 1" | sudo tee -a /etc/cron.daily/fstrim
sudo chmod +x /etc/cron.daily/fstrim

# Update and upgrade hourly
echo -e "#\!/bin/sh\n" | sudo tee /etc/cron.hourly/apt
echo -e "apt update" | sudo tee -a /etc/cron.hourly/apt
echo -e "apt dist-upgrade -y" | sudo tee -a /etc/cron.hourly/apt
echo -e "apt autoremove -y" | sudo tee -a /etc/cron.hourly/apt
echo -e "apt clean all -y" | sudo tee -a /etc/cron.hourly/apt
sudo chmod +x /etc/cron.hourly/apt

# Install dotfiles
if [ -d ~/.dotfiles ] || [ -h ~/.dotfiles ]; then
  mv ~/.dotfiles /tmp/dotfiles-old
fi
git clone --recursive https://github.com/gufranco/dotfiles.git ~/.dotfiles --depth=1
cd ~/.dotfiles || exit 1
git remote set-url origin git@github.com:gufranco/dotfiles.git

# Zsh
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
  mv ~/.zshrc /tmp/zshrc-old
fi
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
command -v zsh | sudo tee -a /etc/shells
sudo sed -i -- 's/auth       required   pam_shells.so/# auth       required   pam_shells.so/g' /etc/pam.d/chsh
sudo chsh "$USER" -s "$(command -v zsh)"

# Git
if [ -f ~/.gitconfig ] || [ -h ~/.gitconfig ]; then
  mv ~/.gitconfig /tmp/gitconfig-old
fi
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig

# Vim / Neovim config
if [ -d ~/.vim ] || [ -h ~/.vim ]; then
  mv ~/.vim /tmp/vim-old
fi
ln -s ~/.dotfiles/vim ~/.vim

if [ -d ~/.config/nvim ] || [ -h ~/.config/nvim ]; then
  mv ~/.config/nvim /tmp/nvim-old
fi
ln -s ~/.dotfiles/vim ~/.config/nvim

if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
  mv ~/.vimrc /tmp/vimrc-old
fi
ln -s ~/.dotfiles/vim/init.vim ~/.vimrc

# GPG config
if [ -d ~/.gnupg ] || [ -h ~/.gnupg ]; then
  mv ~/.gnupg /tmp/gnupg-old
fi
ln -s ~/.dotfiles/gnupg ~/.gnupg
chmod 700 ~/.gnupg
chmod 400 ~/.gnupg/keys/*
# gpg --import ~/.gnupg/keys/personal.public
# gpg --import ~/.gnupg/keys/personal.private

# SSH
if [ -d ~/.ssh ] || [ -h ~/.ssh ]; then
  mv ~/.ssh /tmp/ssh-old
fi
ln -s ~/.dotfiles/ssh ~/.ssh
chmod 400 ~/.ssh/id_rsa

# NeoMutt
if [ -f ~/.muttrc ] || [ -h ~/.muttrc ]; then
  mv ~/.muttrc /tmp/muttrc-old
fi
ln -s ~/.dotfiles/mutt/.muttrc ~/.muttrc
if [ -d ~/.mutt ] || [ -h ~/.mutt ]; then
  mv ~/.mutt /tmp/mutt-old
fi
ln -s ~/.dotfiles/mutt ~/.mutt
if [ -f ~/.mailcap ] || [ -h ~/.mailcap ]; then
  mv ~/.mailcap /tmp/mailcap-old
fi
ln -s ~/.dotfiles/mutt/.mailcap ~/.mailcap

# Tmux
if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
  mv ~/.tmux.conf /tmp/tmux.conf-old
fi
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
if [ -d ~/.tmux ] || [ -h ~/.tmux ]; then
  mv ~/.tmux /tmp/tmux-old
fi
ln -s ~/.dotfiles/tmux ~/.tmux

# Curl
if [ -f ~/.curlrc ] || [ -h ~/.curlrc ]; then
  mv ~/.curlrc /tmp/curlrc-old
fi
ln -s ~/.dotfiles/.curlrc ~/.curlrc

# Wget
if [ -f ~/.wgetrc ] || [ -h ~/.wgetrc ]; then
  mv ~/.wgetrc /tmp/wgetrc-old
fi
ln -s ~/.dotfiles/.wgetrc ~/.wgetrc

# Readline
if [ -f ~/.inputrc ] || [ -h ~/.inputrc ]; then
  mv ~/.inputrc /tmp/inputrc-old
fi
ln -s ~/.dotfiles/.inputrc ~/.inputrc

# Conky
if [ -f ~/.conkyrc ] || [ -h ~/.conkyrc ]; then
  mv ~/.conkyrc /tmp/conkyrc-old
fi
ln -s ~/.dotfiles/.conkyrc ~/.conkyrc

################################################################################
# Clean up
################################################################################
sudo apt autoremove -y
sudo apt clean all -y
