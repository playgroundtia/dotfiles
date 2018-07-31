#!/bin/bash

case "$(uname)" in
  Linux)
    #
    # Repositories
    #
    # Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    # Node.js
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    # Yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    # Spotify
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
    echo "deb [arch=amd64] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    # Chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    # VirtualBox
    sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    # Atom
    sudo add-apt-repository ppa:webupd8team/atom

    # Update / upgrade
    sudo apt update
    sudo apt dist-upgrade -y

    # Purge
    sudo apt purge -y \
      apport \
      docker \
      docker-engine \
      docker.io \
      cmdtest \
      nodejs \
      chromium-* \
      virtualbox

    # Install
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
      linux-image-extra-"$(uname -r)" \
      linux-image-extra-virtual \
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
      ruby

    # Tilix
    mkdir -p ~/.config/tilix/schemes
    ln -s ~/.dotfiles/themes/Tilix/Dracula.json ~/.config/tilix/schemes/Dracula.json

    # Atom packages
    apm install \
      sync-settings

    # Ruby packages
    sudo gem install \
      bundler \
      rails

    # Node.js packages
    sudo yarn global add \
      eslint --ignore-optional

    # Nerd fonts
    git clone https://github.com/ryanoasis/nerd-fonts.git --depth=1 /tmp/fonts
    ./tmp/fonts/install.sh

    ;;
  Darwin)
    # xCode
    xcode-select -p || exit 1
    sudo xcodebuild -license accept
    sudo xcode-select --install

    # Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor

    # Taps
    brew tap \
      caskroom/cask \
      buo/cask-upgrade \
      caskroom/drivers \
      caskroom/fonts

    # Bottles
    brew install \
      mas \
      curl \
      git \
      wget \
      zsh \
      vim \
      gpg \
      neomutt/homebrew-neomutt/neomutt \
      lynx \
      urlview \
      tmux \
      reattach-to-user-namespace \
      nodejs \
      yarn \
      awscli \
      shellcheck \
      ruby

    # Casks
    brew cask install \
      iterm2 \
      filezilla \
      transmission \
      vlc \
      steam \
      wch-ch34x-usb-serial-driver \
      silicon-labs-vcp-driver \
      cleanmymac \
      coconutbattery \
      flixtools \
      folx \
      itau \
      sizeup \
      spotify \
      google-chrome \
      virtualbox \
      virtualbox-extension-pack \
      vagrant \
      atom \
      macvim \
      font-hack-nerd-font \
      applepi-baker

    # Atom packages
    apm install \
      sync-settings

    # Ruby packages
    gem install \
      bundler \
      rails

    # Node.js packages
    sudo yarn global add \
      eslint \
      --ignore-optional

    #
    # App Store
    #
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

#
# Settings
#
# Delete old files
rm -rf ~/.dotfiles ~/.zshrc ~/.gitconfig ~/.vim ~/.vimrc ~/.gnupg ~/.ssh ~/.muttrc ~/.mutt ~/.mailcap ~/.tmux.conf ~/.tmux
# Clone dotfiles
git clone --recursive https://github.com/gufranco/dotfiles.git ~/.dotfiles --depth=1 && \
cd ~/.dotfiles || exit 1 && \
git remote set-url origin git@github.com:gufranco/dotfiles.git
# Zsh
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/themes/zsh/dracula.zsh-theme ~/.dotfiles/zsh/.oh-my-zsh/custom/themes/dracula.zsh-theme
echo "$(which zsh)" | sudo tee /etc/shells
sudo sed -i -- 's/auth       required   pam_shells.so/# auth       required   pam_shells.so/g' /etc/pam.d/chsh
sudo chsh $USER -s "$(which zsh)"
# Git
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
# Vim
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc
# GPG
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
# SSH
ln -s ~/.dotfiles/ssh ~/.ssh
chmod 400 ~/.ssh/id_rsa
# NeoMutt
ln -s ~/.dotfiles/mutt/.muttrc ~/.muttrc
ln -s ~/.dotfiles/mutt ~/.mutt
ln -s ~/.dotfiles/mutt/.mailcap ~/.mailcap
# Tmux
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/tmux ~/.tmux
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh
# Finish
sudo shutdown -r now
