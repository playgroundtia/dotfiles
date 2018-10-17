#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

case "$(uname)" in
  Linux)
    ############################################################################
    # Repositories
    ############################################################################
    # Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    # Node.js
    curl -fsSL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    # Yarn
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    # Spotify
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
    echo "deb [arch=amd64] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    # Chrome
    curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    # VirtualBox
    curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
    curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc | sudo apt-key add -
    sudo add-apt-repository -y "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
    # Atom
    sudo add-apt-repository -y ppa:webupd8team/atom
    # DBeaver
    sudo add-apt-repository -y ppa:serge-rider/dbeaver-ce

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
      docker \
      docker-engine \
      docker.io \
      cmdtest \
      nodejs \
      chromium-* \
      virtualbox

    ############################################################################
    # Install packages
    ############################################################################
    sudo apt install -y \
      curl \
      git \
      wget \
      exfat-fuse \
      exfat-utils \
      zsh \
      vim \
      vim-gnome \
      gnupg-agent \
      tilix \
      lynx \
      neomutt \
      urlview \
      tmux \
      xsel \
      filezilla \
      transmission \
      vlc \
      steam \
      apt-transport-https \
      ca-certificates \
      software-properties-common \
      docker-ce \
      gcc \
      g++ \
      make \
      build-essential \
      nodejs \
      yarn \
      awscli \
      spotify-client \
      google-chrome-stable \
      dkms \
      virtualbox \
      virtualbox-ext-pack \
      vagrant \
      atom \
      shellcheck \
      ruby \
      fonts-hack-ttf \
      nautilus-dropbox \
      asciinema \
      python-dev \
      python3-dev \
      python3.7 \
      python3-pip \
      dbeaver-ce \
      cmake \
      corebird \
      htop

    ############################################################################
    # Hack Nerd Font
    ############################################################################
    curl -fLo \
      "$HOME/.config/tilix/schemes/Hack Regular Nerd Font Complete.ttf" \
      --create-dirs https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
    sudo fc-cache -fv

    ############################################################################
    # Tilix
    ############################################################################
    curl -fLo \
      "$HOME/.config/tilix/schemes/Dracula.json" \
      --create-dirs https://raw.githubusercontent.com/krzysztofzuraw/dracula-tilix/master/Dracula.json

    ############################################################################
    # Docker
    ############################################################################
    sudo usermod -a -G docker "$USER"

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
    brew doctor

    ############################################################################
    # Taps
    ############################################################################
    brew tap \
      caskroom/cask \
      buo/cask-upgrade \
      caskroom/drivers \
      caskroom/fonts

    ############################################################################
    # Bottles
    ############################################################################
    brew install \
      awscli \
      curl \
      git \
      gpg \
      lynx \
      mas \
      neomutt/homebrew-neomutt/neomutt \
      nodejs \
      reattach-to-user-namespace \
      ruby \
      shellcheck \
      tmux \
      urlview \
      vim \
      wget \
      yarn \
      zsh \
      python3 \
      cmake \
      htop

    ############################################################################
    # Casks
    ############################################################################
    brew cask install \
      applepi-baker \
      atom \
      authy \
      cleanmymac \
      cloudapp \
      coconutbattery \
      filezilla \
      firefox \
      flixtools \
      font-hack-nerd-font \
      google-chrome \
      itau \
      iterm2 \
      keka \
      lastpass \
      macvim \
      plex-media-server \
      robo-3t \
      silicon-labs-vcp-driver \
      sizeup \
      spotify \
      transmission \
      vlc \
      steam \
      wch-ch34x-usb-serial-driver \
      folx \
      virtualbox \
      virtualbox-extension-pack \
      vagrant \
      docker \
      dropbox \
      asciinema \
      java \
      dbeaver-community

    ############################################################################
    # iTerm 2
    ############################################################################
    curl -fLo \
      "/tmp/Dracula.itermcolors" \
      --create-dirs https://raw.githubusercontent.com/dracula/iterm/master/Dracula.itermcolors
    open "/tmp/Dracula.itermcolors"

    ############################################################################
    # App Store
    ############################################################################
    # Amphetamine
    mas install 937984704
    # Valentina Studio
    mas install 604825918
    # Clean My Drive 2
    mas install 523620159

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
  prettier \
  eslint \
  fkill-cli \
  tern \
  --ignore-optional

################################################################################
# Python packages
################################################################################
pip3 install \
  pipenv \
  black \
  vim-vint \
  --user

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
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
command -v zsh | sudo tee -a /etc/shells
sudo sed -i -- 's/auth       required   pam_shells.so/# auth       required   pam_shells.so/g' /etc/pam.d/chsh
sudo chsh "$USER" -s "$(command -v zsh)"

################################################################################
# Git config
################################################################################
if [ -f ~/.gitconfig ] || [ -h ~/.gitconfig ]; then
  mv ~/.gitconfig /tmp/gitconfig-old
fi
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig

################################################################################
# Vim config
################################################################################
if [ -d ~/.vim ] || [ -h ~/.vim ]; then
  mv ~/.vim /tmp/vim-old
fi
ln -s ~/.dotfiles/vim ~/.vim
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
  mv ~/.vimrc /tmp/vimrc-old
fi
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc

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
gpg --import ~/.gnupg/keys/personal.public
gpg --import ~/.gnupg/keys/personal.private

################################################################################
# SSH config
################################################################################
if [ -d ~/.ssh ] || [ -h ~/.ssh ]; then
  mv ~/.ssh /tmp/ssh-old
fi
ln -s ~/.dotfiles/ssh ~/.ssh
chmod 400 ~/.ssh/id_rsa

################################################################################
# NeoMutt config
################################################################################
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
# Finish
################################################################################
case "$(uname)" in
  Linux)
    sudo apt autoremove -y
    sudo apt clean all -y

  ;;
  Darwin)
    brew cleanup
    brew prune

  ;;
esac
