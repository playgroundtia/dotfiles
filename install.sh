#!/bin/bash

# Updates, upgrades, basic packages, etc...
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get dist-upgrade -y

  sudo apt-get purge -y apport
  sudo apt-get install -y curl git wget zsh vim gnupg-agent
else
  xcode-select -p || exit 1
  sudo xcodebuild -license accept
  sudo xcode-select --install

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  brew tap caskroom/cask
  brew tap buo/cask-upgrade
  brew tap caskroom/fonts

  brew install mas curl git wget zsh vim gnupg pinentry-mac
fi

# Install dotfiles
if [ -f ~/.dotfiles ] || [ -h ~/.dotfiles ]; then
  mv ~/.dotfiles /tmp/dotfiles-old
fi
git clone --recursive https://github.com/gufranco/dotfiles.git ~/.dotfiles
cd ~/.dotfiles || exit
git remote set-url origin git@github.com:gufranco/dotfiles.git
git config user.email "gufranco@users.noreply.github.com"

# Configure Zsh
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
  mv ~/.zshrc /tmp/zshrc-old
fi
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
echo "$(which zsh)" | sudo tee /etc/shells
chsh -s "$(which zsh)"

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

# Configure GPG
if [ -f ~/.gnupg ] || [ -h ~/.gnupg ]; then
  mv ~/.gnupg /tmp/gnupg-old
fi
ln -s ~/.dotfiles/gnupg ~/.gnupg
chmod 700 ~/.gnupg
gpg --import ~/.gnupg/keys/personal.public
gpg --import ~/.gnupg/keys/personal.private

# Configure SSH
if [ -f ~/.ssh ] || [ -h ~/.ssh ]; then
  mv ~/.ssh /tmp/ssh-old
fi
ln -s ~/.dotfiles/ssh ~/.ssh
chmod 400 ~/.ssh/id_rsa

# Install terminal
if [[ "$(uname)" == "Linux" ]]; then
  sudo add-apt-repository ppa:webupd8team/terminix
  sudo apt update
  sudo apt install -y tilix
  sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
else
  brew cask install iterm2 --language=pt-BR
fi

# Install ASDF
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev
else
  brew install coreutils automake autoconf openssl libyaml readline libxslt libtool unixodbc
fi
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.1
source ~/.asdf/asdf.sh
source ~/.asdf/completions/asdf.bash

# Install Ruby / Bundler
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 2.5.0
asdf global ruby 2.5.0
gem install bundler

# Install Node.js
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs 9.3.0
asdf global nodejs 9.3.0

# Install Yarn
if [[ "$(uname)" == "Linux" ]]; then
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get remove -y cmdtest
  sudo apt-get update
  sudo apt-get install -y yarn
else
  brew install yarn --without-node
fi

# Install Atom (and dependencies)
if [[ "$(uname)" == "Linux" ]]; then
  sudo add-apt-repository ppa:webupd8team/atom
  sudo apt-get update
  sudo apt-get install -y atom

  sudo yarn global add eslint --ignore-optional
  sudo apt-get install -y shellcheck
else
  brew cask install atom --language=pt-BR

  sudo yarn global add eslint --ignore-optional
  brew install shellcheck
fi
apm install sync-settings

# Install Chrome
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get purge -y chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
  sudo apt-get update
  sudo apt-get install -y google-chrome-stable
else
  brew cask install google-chrome --language=pt-BR
fi

# Install Firefox
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y firefox
else
  brew cask install firefox --language=pt-BR
fi

# Install Docker (Linux only)
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get purge -y docker docker-engine
  sudo apt-get install -y linux-image-extra-"$(uname -r)" linux-image-extra-virtual apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-get install -y docker-ce
fi

# Install Skype
if [[ "$(uname)" == "Linux" ]]; then
  wget https://repo.skype.com/latest/skypeforlinux-64.deb -P /tmp
  sudo dpkg -i /tmp/skypeforlinux-64.deb
else
  brew cask install skype --language=pt-BR
fi

# Install fonts
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y ttf-mscorefonts-installer
else
  brew cask install font-ubuntu
fi

# Install VLC
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y vlc
else
  brew cask install vlc --language=pt-BR
fi

# Install FileZilla
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y filezilla
else
  brew cask install filezilla --language=pt-BR
fi

# Install Vagrant / VirtualBox
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y virtualbox vagrant
else
  brew cask install virtualbox vagrant --language=pt-BR
fi

# Install Transmission
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y transmission
else
  brew cask install transmission --language=pt-BR
fi

# Install Arduino / Java
if [[ "$(uname)" == "Linux" ]]; then
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update
  sudo apt-get install -y oracle-java8-installer oracle-java8-set-default arduino
else
  brew cask install java arduino --language=pt-BR
fi

# Install Spotify
if [[ "$(uname)" == "Linux" ]]; then
  sudo snap install spotify
else
  brew cask install spotify --language=pt-BR
fi

# Install Slack
if [[ "$(uname)" == "Linux" ]]; then
  sudo snap install slack --classic
else
  brew cask install slack --language=pt-BR
fi

# Install macOS ~exclusive~ apps
if [[ "$(uname)" == "Darwin" ]]; then
  # Amphetamine
  mas install 937984704

  # Twitter
  mas install 409789998

  # Airmail 3
  mas install 918858936

  # Valentina Studio
  mas install 604825918

  # Clean My Drive 2
  mas install 523620159

  brew cask install cleanmymac --language=pt-BR
  brew cask install cloudapp --language=pt-BR
  brew cask install coconutbattery --language=pt-BR
  brew cask install cyberduck --language=pt-BR
  brew cask install flixtools --language=pt-BR
  brew cask install folx --language=pt-BR
  brew cask install itau --language=pt-BR
  brew cask install sizeup --language=pt-BR
  brew cask install the-unarchiver --language=pt-BR
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
