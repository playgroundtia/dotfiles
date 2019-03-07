#!/usr/bin/env bash

sudo -v
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
    # DBeaver
    sudo add-apt-repository -y ppa:serge-rider/dbeaver-ce
    # Atom
    sudo add-apt-repository ppa:webupd8team/atom
    # Visual Studio Code
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    # Terraform
    curl -fsSL https://tjend.github.io/repo_terraform/repo_terraform.key | sudo apt-key add -
    echo "deb [arch=amd64] https://tjend.github.io/repo_terraform stable main" | sudo tee /etc/apt/sources.list.d/terraform.list

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
      apt-transport-https \
      asciinema \
      atom \
      autoconf \
      automake \
      awscli \
      build-essential \
      ca-certificates \
      cmake \
      code \
      code-insiders \
      corebird \
      curl \
      dbeaver-ce \
      dirmngr \
      dkms \
      docker-ce \
      exfat-fuse \
      exfat-utils \
      file \
      filezilla \
      fonts-hack-ttf \
      g++ \
      gcc \
      git \
      gnome-screensaver \
      gnupg-agent \
      google-chrome-stable \
      gpg \
      htop \
      libffi-dev \
      libncurses-dev \
      libreadline-dev \
      libssl-dev \
      libtool \
      libxslt-dev \
      libyaml-dev \
      lynx \
      make \
      nautilus-dropbox \
      neomutt \
      nodejs \
      preload \
      python-dev \
      python3-dev \
      python3-pip \
      python3.7 \
      ruby-full \
      shellcheck \
      software-properties-common \
      spotify-client \
      steam \
      terraform \
      tilix \
      tmux \
      transmission \
      unixodbc-dev \
      urlview \
      vagrant \
      vim \
      vim-gnome \
      virtualbox \
      vlc \
      wget \
      xsel \
      yarn \
      zsh

    ############################################################################
    # Robo 3T
    ############################################################################
    wget https://download.robomongo.org/1.2.1/linux/robo3t-1.2.1-linux-x86_64-3e50a65.tar.gz -O /tmp/robo3t.tar.gz
    sudo mkdir /opt/robo3t
    tar -zxvf /tmp/robo3t.tar.gz -C /opt/robo3t
    sudo chmod +x /opt/robo3t/robo3t

    ############################################################################
    # Hack Nerd Font
    ############################################################################
    mkdir -p ~/.local/share/fonts
    curl -fLo \
      "$HOME/.local/share/fonts/Hack Regular Nerd Font Complete.ttf" \
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
      awscli \
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
      neomutt/homebrew-neomutt/neomutt \
      nodejs \
      openssl \
      python3 \
      readline \
      reattach-to-user-namespace \
      ruby \
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

    ############################################################################
    # Hostname
    ############################################################################
    sudo scutil --set HostName macbook
    sudo scutil --set LocalHostName macbook
    sudo scutil --set ComputerName macbook

    ############################################################################
    # SSD
    ############################################################################
    # Disable hibernation (speeds up entering sleep mode)
    sudo pmset -a hibernatemode 0
    # Remove the sleep image file to save disk space
    sudo rm /private/var/vm/sleepimage
    # Create a zero-byte file instead and make sure it can't be rewritten
    sudo touch /private/var/vm/sleepimage
    sudo chflags uchg /private/var/vm/sleepimage

    ############################################################################
    # Screen
    ############################################################################
    # Require password immediately after sleep or screen saver begins
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
    # Save screenshots to the desktop
    defaults write com.apple.screencapture location -string "${HOME}/Desktop"
    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"
    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool true
    # Enable subpixel font rendering on non-Apple LCDs
    defaults write NSGlobalDomain AppleFontSmoothing -int 1
    # Enable HiDPI display modes
    sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

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
  eslint \
  fkill-cli \
  gulp \
  gulp-cli \
  jest \
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
# Ruby packages
################################################################################
sudo gem install \
  rails \
  bundler

################################################################################
# Bundler config
################################################################################
if [[ "$(uname)" == "Linux" ]]; then
  cores=$(grep -c processor < /proc/cpuinfo)
elif [[ "$(uname)" == "Darwin" ]]; then
  cores=$(sysctl -n hw.ncpu)
fi
bundle config --global jobs $((cores - 1))

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
# Vim config
################################################################################
if [ -d ~/.vim ] || [ -h ~/.vim ]; then
  mv ~/.vim /tmp/vim-old
fi
ln -s ~/.dotfiles/vim ~/.vim
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
  mv ~/.vimrc /tmp/vimrc-old
fi
curl -fLo \
  "$HOME/.vim/autoload/plug.vim" \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
