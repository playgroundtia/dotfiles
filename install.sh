#!/usr/bin/env bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

case "$(uname)" in
  Linux)
    ############################################################################
    # Disable prompts
    ############################################################################
    export DEBIAN_FRONTEND=noninteractive

    ############################################################################
    # Update / upgrade
    ############################################################################
    sudo apt update
    sudo apt dist-upgrade -y

    ############################################################################
    # Purge
    ############################################################################
    sudo apt purge -y \
      apport \
      chromium-* \
      cmdtest \
      docker \
      docker-engine \
      docker.io \
      firefox \
      nodejs \
      ubuntu-web-launchers \
      virtualbox

    ############################################################################
    # Basic packages
    ############################################################################
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

    ############################################################################
    # Enable exFat
    ############################################################################
    sudo apt install -y \
      exfat-fuse \
      exfat-utils

    ############################################################################
    # Enable universe repository
    ############################################################################
    sudo add-apt-repository universe
    sudo apt update

    ############################################################################
    # 7Zip
    ############################################################################
    sudo apt install -y \
      p7zip-full \
      p7zip-rar

    ############################################################################
    # Docker
    ############################################################################
    # Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y \
      docker-ce
    sudo usermod -a -G docker "$USER"

    # Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    ############################################################################
    # Node.js / Yarn
    ############################################################################
    # Node.js
    curl -fsSL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt update
    sudo apt install -y \
      nodejs

    # Yarn
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install -y \
      yarn

    ############################################################################
    # Python / Pip
    ############################################################################
    sudo apt install -y \
      python3-pip \
      python3.7

    ############################################################################
    # Spotify
    ############################################################################
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
    echo "deb [arch=amd64] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update
    sudo apt install -y \
      spotify-client

    ############################################################################
    # Chrome
    ############################################################################
    curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update
    sudo apt install -y \
      google-chrome-stable

    ############################################################################
    # VirtualBox / Vagrant
    ############################################################################
    curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
    curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc | sudo apt-key add -
    sudo add-apt-repository -y "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
    sudo apt update
    sudo apt install -y \
      virtualbox \
      vagrant

    ############################################################################
    # DBeaver
    ############################################################################
    sudo add-apt-repository -y ppa:serge-rider/dbeaver-ce
    sudo apt update
    sudo apt install -y \
      dbeaver-ce

    ############################################################################
    # Vim / gVim / Neovim / Plugins dependencies
    ############################################################################
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

    ############################################################################
    # Atom
    ############################################################################
    sudo add-apt-repository -y ppa:webupd8team/atom
    sudo apt update
    sudo apt install -y \
      atom

    ############################################################################
    # Visual Studio Code
    ############################################################################
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    sudo apt update
    sudo apt install -y \
      code \
      code-insiders

    ############################################################################
    # Terraform
    ############################################################################
    curl -fsSL https://tjend.github.io/repo_terraform/repo_terraform.key | sudo apt-key add -
    echo "deb [arch=amd64] https://tjend.github.io/repo_terraform stable main" | sudo tee /etc/apt/sources.list.d/terraform.list
    sudo apt update
    sudo apt install -y \
      terraform

    ############################################################################
    # Gnome
    ############################################################################
    sudo apt install -y \
      gnome-screensaver \
      gnome-shell-extensions \
      gnome-tweak-tool

    ############################################################################
    # GPG
    ############################################################################
    sudo apt install -y \
      gpg \
      gnupg-agent

    ############################################################################
    # Shellcheck
    ############################################################################
    sudo apt install -y \
      shellcheck

    ############################################################################
    # Dropbox
    ############################################################################
    sudo apt install -y \
      nautilus-dropbox

    ############################################################################
    # Hack Nerd Font
    ############################################################################
    sudo apt install -y \
      fonts-hack-ttf
    curl -fLo \
      "$HOME/.local/share/fonts/Hack Regular Nerd Font Complete.ttf" \
      --create-dirs https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
    sudo fc-cache -fv

    ############################################################################
    # Tilix
    ############################################################################
    sudo apt install -y \
      tilix
    curl -fLo \
      "$HOME/.config/tilix/schemes/Afterglow.json" \
      --create-dirs https://raw.githubusercontent.com/storm119/Tilix-Themes/master/Themes/afterglow.json

    ############################################################################
    # Conky
    ############################################################################
    sudo apt install -y \
      conky-all

    ############################################################################
    # VLC
    ############################################################################
    sudo apt install -y \
      vlc

    ############################################################################
    # Transmission
    ############################################################################
    sudo apt install -y \
      transmission

    ############################################################################
    # Steam
    ############################################################################
    sudo apt install -y \
      steam

    ############################################################################
    # Filezilla
    ############################################################################
    sudo apt install -y \
      filezilla

    ############################################################################
    # Asciinema
    ############################################################################
    sudo apt install -y \
      asciinema

    ############################################################################
    # Preload
    ############################################################################
    sudo apt install -y \
      preload

    ;;
  Darwin)
    ############################################################################
    # xCode
    ############################################################################
    xcode-select -p || exit 1
    sudo xcodebuild -license accept
    sudo xcode-select --install

    ############################################################################
    # Homebrew
    ############################################################################
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    ############################################################################
    # Taps
    ############################################################################
    brew tap caskroom/cask
    brew tap buo/cask-upgrade
    brew tap caskroom/drivers
    brew tap caskroom/fonts

    ############################################################################
    # Bottles
    ############################################################################
    brew install \
      asciinema \
      cmake \
      coreutils \
      curl \
      findutils \
      git \
      gpg \
      htop \
      lynx \
      mas \
      mc \
      moreutils \
      nodejs \
      openssl \
      python3 \
      readline \
      reattach-to-user-namespace \
      shellcheck \
      terraform \
      tmux \
      urlview \
      vim \
      wget \
      yarn \
      zlib \
      zsh

    ############################################################################
    # Casks
    ############################################################################
    brew cask install \
      atom \
      authy \
      coconutbattery \
      dbeaver-community \
      docker \
      dropbox \
      filezilla \
      firefox \
      flixtools \
      folx \
      font-hack-nerd-font \
      google-chrome \
      itau \
      iterm2 \
      java \
      keka \
      macvim \
      plex-media-server \
      robo-3t \
      silicon-labs-vcp-driver \
      sizeup \
      soda-player \
      spotify \
      steam \
      transmission \
      vagrant \
      virtualbox \
      visual-studio-code \
      vlc \
      wch-ch34x-usb-serial-driver

    ############################################################################
    # iTerm 2
    ############################################################################
    curl -fLo \
      "/tmp/Afterglow.itermcolors" \
      --create-dirs https://raw.githubusercontent.com/YabataDesign/afterglow-itermcolors/master/Afterglow.itermcolors
    open "/tmp/Afterglow.itermcolors"

    ############################################################################
    # App Store
    ############################################################################
    # Amphetamine
    mas install 937984704

    # Valentina Studio
    mas install 604825918

    # Clean My Drive 2
    mas install 523620159

    # Todoist
    mas install 585829637

    ############################################################################
    # Hostname
    ############################################################################
    sudo scutil --set HostName macbook
    sudo scutil --set LocalHostName macbook
    sudo scutil --set ComputerName macbook

    ;;
  *)
    echo "Invalid system."
    exit 1

    ;;
esac

################################################################################
# Atom packages
################################################################################
apm install \
  sync-settings

################################################################################
# Node.js packages
################################################################################
sudo yarn global add \
  create-react-app \
  eslint \
  fkill-cli \
  jest \
  ngrok \
  nodemon \
  prettier \
  tern \
  ts-node \
  typescript \
  vtop \
  --ignore-optional

################################################################################
# Python packages
################################################################################
pip3 install --user \
  pipenv \
  black \
  vim-vint

################################################################################
# Clone dotfiles
################################################################################
if [ -d ~/.dotfiles ] || [ -h ~/.dotfiles ]; then
  mv ~/.dotfiles /tmp/dotfiles-old
fi
git clone --recursive https://github.com/gufranco/dotfiles.git ~/.dotfiles --depth=1
cd ~/.dotfiles || exit 1
git remote set-url origin git@github.com:gufranco/dotfiles.git

################################################################################
# Zsh config
################################################################################
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
  mv ~/.zshrc /tmp/zshrc-old
fi
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
command -v zsh | sudo tee -a /etc/shells
if [[ "$(uname)" == "Linux" ]]; then
  sudo sed -i -- 's/auth       required   pam_shells.so/# auth       required   pam_shells.so/g' /etc/pam.d/chsh
  sudo chsh "$USER" -s "$(command -v zsh)"
elif [[ "$(uname)" == "Darwin" ]]; then
  chsh -s "$(command -v zsh)"
fi

################################################################################
# Git config
################################################################################
if [ -f ~/.gitconfig ] || [ -h ~/.gitconfig ]; then
  mv ~/.gitconfig /tmp/gitconfig-old
fi
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig

################################################################################
# Vim / Neovim config
################################################################################
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

################################################################################
# GPG config
################################################################################
if [ -d ~/.gnupg ] || [ -h ~/.gnupg ]; then
  mv ~/.gnupg /tmp/gnupg-old
fi
ln -s ~/.dotfiles/gnupg ~/.gnupg
if [[ "$(uname)" == "Linux" ]]; then
  echo "pinentry-program /usr/bin/pinentry-curses" > ~/.gnupg/gpg-agent.conf
elif [[ "$(uname)" == "Darwin" ]]; then
  echo "pinentry-program /usr/local/bin/pinentry-curses" > ~/.gnupg/gpg-agent.conf
fi
chmod 700 ~/.gnupg
chmod 400 ~/.gnupg/keys/*
# gpg --import ~/.gnupg/keys/personal.public
# gpg --import ~/.gnupg/keys/personal.private

################################################################################
# SSH config
################################################################################
if [ -d ~/.ssh ] || [ -h ~/.ssh ]; then
  mv ~/.ssh /tmp/ssh-old
fi
ln -s ~/.dotfiles/ssh ~/.ssh
chmod 400 ~/.ssh/id_rsa

################################################################################
# Tmux config
################################################################################
if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
  mv ~/.tmux.conf /tmp/tmux.conf-old
fi
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
if [ -d ~/.tmux ] || [ -h ~/.tmux ]; then
  mv ~/.tmux /tmp/tmux-old
fi
ln -s ~/.dotfiles/tmux ~/.tmux

################################################################################
# Curl config
################################################################################
if [ -f ~/.curlrc ] || [ -h ~/.curlrc ]; then
  mv ~/.curlrc /tmp/curlrc-old
fi
ln -s ~/.dotfiles/.curlrc ~/.curlrc

################################################################################
# Wget config
################################################################################
if [ -f ~/.wgetrc ] || [ -h ~/.wgetrc ]; then
  mv ~/.wgetrc /tmp/wgetrc-old
fi
ln -s ~/.dotfiles/.wgetrc ~/.wgetrc

################################################################################
# Readline config
################################################################################
if [ -f ~/.inputrc ] || [ -h ~/.inputrc ]; then
  mv ~/.inputrc /tmp/inputrc-old
fi
ln -s ~/.dotfiles/.inputrc ~/.inputrc

############################################################################
# Conky config
############################################################################
if [[ "$(uname)" == "Linux" ]]; then
  if [ -f ~/.conkyrc ] || [ -h ~/.conkyrc ]; then
    mv ~/.conkyrc /tmp/conkyrc-old
  fi
  ln -s ~/.dotfiles/.conkyrc ~/.conkyrc
fi

################################################################################
# Finish
################################################################################
case "$(uname)" in
  Linux)
    # Clean the mess
    sudo apt autoremove -y
    sudo apt clean all -y

    # Reboot
    sudo shutdown -r now

  ;;
  Darwin)
    # Clean the mess
    brew cleanup -s
    brew prune

    # Enable TRIM and reboot
    sudo trimforce enable

  ;;
esac
