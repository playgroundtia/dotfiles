#!/bin/bash

# Updates, upgrades, basic packages, etc...
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get dist-upgrade -y

  sudo apt-get purge -y apport
  sudo apt-get install -y curl git wget zsh vim
else
  xcode-select -p || exit 1
  sudo xcodebuild -license accept
  sudo xcode-select --install

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  brew tap caskroom/cask
  brew tap buo/cask-upgrade

  brew install mas curl git wget zsh vim
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
sudo sed -i -- 's/auth       required   pam_shells.so/# auth       required   pam_shells.so/g' /etc/pam.d/chsh
sudo chsh $USER -s "$(which zsh)"

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

# Install Ruby / Bundler
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y ruby
else
  brew install ruby
fi
gem install bundler

# Install Node.js / Yarn
if [[ "$(uname)" == "Linux" ]]; then
  curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get purge -y cmdtest
  sudo apt-get update
  sudo apt-get install -y build-essential nodejs yarn
else
  brew install nodejs yarn
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
  sudo apt-get purge -y chromium-*
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
  brew tap caskroom/fonts
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
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update
  sudo apt-get install -y spotify-client
else
  brew cask install spotify --language=pt-BR
fi

# Install Slack
if [[ "$(uname)" == "Linux" ]]; then
  wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.0.5-amd64.deb -P /tmp
  sudo dpkg -i /tmp/slack-desktop-3.0.5-amd64.deb
else
  brew cask install slack --language=pt-BR
fi

# Install Steam
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y steam
else
  brew cask install steam --language=pt-BR
fi

# Install Robo3T
if [[ "$(uname)" == "Linux" ]]; then
  sudo wget https://download.robomongo.org/1.1.1/linux/robo3t-1.1.1-linux-x86_64-c93c6b0.tar.gz -P /tmp
  sudo tar -xzf /tmp/robo3t-1.1.1-linux-x86_64-c93c6b0.tar.gz -C /opt
  sudo rm -rf /opt/robo3t-1.1.1-linux-x86_64-c93c6b0/lib/libstdc++*
  sudo ln -s /opt/robo3t-1.1.1-linux-x86_64-c93c6b0/bin/robo3t /usr/bin/robo3t

  sudo wget http://mongodb-tools.com/img/robomongo.png -P /opt/robo3t-1.1.1-linux-x86_64-c93c6b0
  touch ~/.local/share/applications/robomongo.desktop
  echo "[Desktop Entry]" >> ~/.local/share/applications/robomongo.desktop
  echo "Encoding=UTF-8" >> ~/.local/share/applications/robomongo.desktop
  echo "Name=Robo3T" >> ~/.local/share/applications/robomongo.desktop
  echo "Comment=Launch Robo3T" >> ~/.local/share/applications/robomongo.desktop
  echo "Icon=/opt/robo3t-1.1.1-linux-x86_64-c93c6b0/robomongo.png" >> ~/.local/share/applications/robomongo.desktop
  echo "Exec=/usr/bin/robo3t" >> ~/.local/share/applications/robomongo.desktop
  echo "Terminal=false" >> ~/.local/share/applications/robomongo.desktop
  echo "Type=Application" >> ~/.local/share/applications/robomongo.desktop
  echo "Categories=Developer;" >> ~/.local/share/applications/robomongo.desktop
  echo "StartupNotify=true" >> ~/.local/share/applications/robomongo.desktop
else
  brew cask install robo-3t --language=pt-BR
fi

# Install AWS CLI
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install -y awscli
else
  brew install awscli
fi

# Install macOS ~exclusive~ drivers
if [[ "$(uname)" == "Darwin" ]]; then
  brew tap caskroom/drivers

  # NodeMCU 0.9
  brew cask install wch-ch34x-usb-serial-driver

  # NodeMCU 1.0
  brew cask install silicon-labs-vcp-driver
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
  brew cask install google-backup-and-sync --language=pt-BR
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
