#!/bin/bash
# Updates, upgrades, basic packages, etc...
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get dist-upgrade -y

  sudo apt-get install -y curl git wget zsh vim gnupg-agent
else
  xcode-select -p || exit 1
  sudo xcodebuild -license accept
  sudo xcode-select --install

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  brew tap caskroom/cask
  brew tap buo/cask-upgrade

  brew install curl git wget zsh vim gpg
fi

# Install dotfiles
if [ -f ~/.dotfiles ] || [ -h ~/.dotfiles ]; then
  mv ~/.dotfiles /tmp/dotfiles-old
fi
git clone --recursive https://github.com/gufranco/dotfiles.git ~/.dotfiles
cd ~/.dotfiles || exit
git remote set-url origin git@github.com:gufranco/dotfiles.git
git config user.email "gufranco@users.noreply.github.com"

# Configure Git
if [ -f ~/.gitconfig ] || [ -h ~/.gitconfig ]; then
  mv ~/.gitconfig /tmp/gitconfig-old
fi
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig

# Configure Vim
if [ -f ~/.vim ] || [ -h ~/.vim ]; then
  mv ~/.vim /tmp/vim-old
fi
ln -s ~/.dotfiles/vim ~/.vim
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
  mv ~/.vimrc /tmp/vimrc-old
fi
ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc

# Configure Zsh
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
  mv ~/.zshrc /tmp/zshrc-old
fi
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
sudo chsh -s "$(which zsh)"

# Configure GPG
if [ -f ~/.gnupg ] || [ -h ~/.gnupg ]; then
  mv ~/.gnupg /tmp/gnupg-old
fi
ln -s ~/.dotfiles/gnupg ~/.gnupg
gpg --import ~/.gnupg/keys/com.gmail.gustavocfranco.public
gpg --import ~/.gnupg/keys/com.gmail.gustavocfranco.private

# Configure SSH
if [ -f ~/.ssh ] || [ -h ~/.ssh ]; then
  mv ~/.ssh /tmp/ssh-old
fi
ln -s ~/.dotfiles/ssh ~/.ssh
chmod 400 ~/.ssh/id_rsa

# Install Node.js / Yarn
if [[ "$(uname)" == "Linux" ]]; then
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt-get install -y nodejs build-essential

  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get install -y yarn
else
  brew install node
  brew install yarn
fi

# Install Atom (and dependencies)
if [[ "$(uname)" == "Linux" ]]; then
  sudo add-apt-repository ppa:webupd8team/atom
  sudo apt-get update -y
  sudo apt-get install -y atom

  sudo yarn global add eslint
  sudo apt-get install -y shellcheck
else
  brew cask install atom

  sudo yarn global add eslint
  brew install shellcheck
fi
apm install sync-settings

# Install Google Chrome
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get purge -y chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra
  sudo apt-get install -y wget
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
  sudo apt-get update -y
  sudo apt-get install -y google-chrome-stable
else
  brew cask install google-chrome
fi

# Install Oracle Java 8
if [[ "$(uname)" == "Linux" ]]; then
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update -y
  sudo apt-get install -y oracle-java8-installer oracle-java8-set-default
else
  brew cask install java
fi

# Install Docker (Linux only)
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get purge -y docker docker-engine
  sudo apt-get install -y linux-image-extra-"$(uname -r)" linux-image-extra-virtual apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update -y
  sudo apt-get install -y docker-ce
fi

# Install Skype
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y wget
  wget https://repo.skype.com/latest/skypeforlinux-64.deb -P /tmp
  sudo dpkg -i /tmp/skypeforlinux-64.deb
else
  brew cask install skype
fi

# Install Ubuntu Font (Ubuntu already has it, duh)
if [[ "$(uname)" == "Darwin" ]]; then
  wget http://font.ubuntu.com/download/ubuntu-font-family-0.83.zip -P /tmp
  unzip /tmp/ubuntu-font-family-0.83.zip
  sudo cp /tmp/ubuntu-font-family-0.83/*.ttf /Library/Fonts
fi

# Install VLC
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y vlc
else
  brew cask install vlc
fi

# Install FileZilla
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y filezilla
else
  brew cask install filezilla
fi

# Install Vagrant / VirtualBox
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y virtualbox vagrant
else
  brew cask install virtualbox vagrant
fi

# Install Transmission
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y transmission
else
  brew cask install transmission
fi

# Install Arduino
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y arduino
else
  brew cask install arduino
fi

# Install Spotify
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update -y
  sudo apt-get install -y spotify-client
else
  brew cask install spotify
fi

# Install Steam
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y steam
else
  brew cask install steam
fi

# Install macOS ~exclusive~ apps
if [[ "$(uname)" == "Darwin" ]]; then
  brew cask install amphetamine
  brew cask install bartender
  brew cask install cleanmymac
  brew cask install cloudapp
  brew cask install coconutbattery
  brew cask install cyberduck
  brew cask install flixtools
  brew cask install folx
  brew cask install istat-menus
  brew cask install itau
  brew cask install iterm2
  brew cask install keka
  brew cask install sizeup
  brew cask install sketch
  brew cask install slack
fi

# Clean the mess!
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get autoremove -y
  sudo apt-get clean all -y
else
  brew cleanup
  brew prune
  brew cask cleanup
fi
