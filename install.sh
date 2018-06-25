#!/bin/bash

# Updates, upgrades, basic packages, etc...
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt update
  sudo apt dist-upgrade -y

  sudo apt purge -y apport
  sudo apt install -y curl git wget zsh vim vim-gnome exfat-fuse exfat-utils gnupg-agent neofetch clang
else
  xcode-select -p || exit 1
  sudo xcodebuild -license accept
  sudo xcode-select --install

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  brew tap caskroom/cask
  brew tap buo/cask-upgrade

  brew install mas curl git wget zsh vim macvim gpg pinentry-mac neofetch
fi

# Install dotfiles
if [ -f ~/.dotfiles ] || [ -h ~/.dotfiles ]; then
  mv ~/.dotfiles /tmp/dotfiles-old
fi
git clone --recursive https://github.com/gufranco/dotfiles.git ~/.dotfiles --depth=1
cd ~/.dotfiles || exit 1
git remote set-url origin git@github.com:gufranco/dotfiles.git
git config user.email "gufranco@users.noreply.github.com"

# Configure Zsh
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
  mv ~/.zshrc /tmp/zshrc-old
fi
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/themes/zsh/dracula.zsh-theme ~/.dotfiles/zsh/.oh-my-zsh/custom/themes/dracula.zsh-theme
echo "$(which zsh)" | sudo tee /etc/shells
sudo sed -i -- 's/auth       required   pam_shells.so/# auth       required   pam_shells.so/g' /etc/pam.d/chsh
sudo chsh $USER -s "$(which zsh)"

# Install Powerline Fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts || exit 1
./install.sh
cd ..
rm -rf fonts

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
if [[ "$(uname)" == "Linux" ]]; then
  echo "pinentry-program /usr/bin/pinentry-curses" > ~/.gnupg/gpg-agent.conf
else
  echo "pinentry-program /usr/local/bin/pinentry-curses" > ~/.gnupg/gpg-agent.conf
fi
chmod 700 ~/.gnupg
chmod 400 ~/.gnupg/keys/*
gpg --import ~/.gnupg/keys/personal.public
gpg --import ~/.gnupg/keys/personal.private

# Configure SSH
if [ -f ~/.ssh ] || [ -h ~/.ssh ]; then
  mv ~/.ssh /tmp/ssh-old
fi
ln -s ~/.dotfiles/ssh ~/.ssh
chmod 400 ~/.ssh/id_rsa

# Install terminal (Tilix / iTerm2)
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt install -y tilix

  mkdir -p ~/.config/tilix/schemes
  ln -s ~/.dotfiles/themes/Tilix/Dracula.json ~/.config/tilix/schemes/Dracula.json
else
  brew cask install iterm2 --language=pt-BR
fi

# Intall NeoMutt
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install lynx neomutt urlview
else
  brew install neomutt/homebrew-neomutt/neomutt lynx urlview
fi
if [ -f ~/.muttrc ] || [ -h ~/.muttrc ]; then
  mv ~/.muttrc /tmp/muttrc-old
fi
ln -s ~/.dotfiles/mutt/.muttrc ~/.muttrc
if [ -f ~/.mutt ] || [ -h ~/.mutt ]; then
  mv ~/.mutt /tmp/mutt-old
fi
ln -s ~/.dotfiles/mutt ~/.mutt
if [ -f ~/.mailcap ] || [ -h ~/.mailcap ]; then
  mv ~/.mailcap /tmp/mailcap-old
fi
ln -s ~/.dotfiles/mutt/.mailcap ~/.mailcap

# Install Tmux
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install tmux xsel
else
  brew install tmux reattach-to-user-namespace
fi
if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
  mv ~/.tmux.conf /tmp/tmux.conf-old
fi
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
if [ -f ~/.tmux ] || [ -h ~/.tmux ]; then
  mv ~/.tmux /tmp/tmux-old
fi
ln -s ~/.dotfiles/tmux ~/.tmux

# Install Ruby / Bundler
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt install -y ruby
  sudo gem install bundler
else
  brew install ruby
  gem install bundler
fi

# Install Node.js / Yarn
if [[ "$(uname)" == "Linux" ]]; then
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb [arch=amd64] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt purge -y cmdtest nodejs
  sudo apt update
  sudo apt install -y gcc g++ make build-essential nodejs yarn
else
  brew install nodejs yarn
fi

# Install Atom (and dependencies)
if [[ "$(uname)" == "Linux" ]]; then
  sudo add-apt-repository ppa:webupd8team/atom
  sudo apt update
  sudo apt install -y atom

  sudo yarn global add eslint --ignore-optional
  sudo apt install -y shellcheck
else
  brew cask install atom --language=pt-BR

  sudo yarn global add eslint --ignore-optional
  brew install shellcheck
fi
apm install sync-settings

# Install Google Chrome
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt purge -y chromium-*
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
  sudo apt update
  sudo apt install -y google-chrome-stable
else
  brew cask install google-chrome --language=pt-BR
fi

# Install Firefox
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt install -y firefox
else
  brew cask install firefox --language=pt-BR
fi

# Install Docker (Linux only)
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt purge -y docker docker-engine docker.io
  sudo apt install -y linux-image-extra-"$(uname -r)" linux-image-extra-virtual apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt update
  sudo apt install -y docker-ce
fi

# Install fonts
if [[ "$(uname)" == "Linux" ]]; then
  sudo DEBIAN_FRONTEND=noninteractive apt install -y ttf-mscorefonts-installer
else
  brew tap caskroom/fonts
  brew cask install font-ubuntu
fi

# Install VLC
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt install -y vlc
else
  brew cask install vlc --language=pt-BR
fi

# Install FileZilla
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt install -y filezilla
else
  brew cask install filezilla --language=pt-BR
fi

# Install Vagrant / VirtualBox
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get purge -y virtualbox
  sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install -y dkms virtualbox virtualbox-ext-pack vagrant
else
  brew cask install virtualbox virtualbox-extension-pack vagrant --language=pt-BR
fi

# Install Transmission
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt install -y transmission
else
  brew cask install transmission --language=pt-BR
fi

# Install Spotify
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
  echo "deb [arch=amd64] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt update
  sudo apt install -y spotify-client
else
  brew cask install spotify --language=pt-BR
fi

# Install Steam
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt install -y steam
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
  sudo apt install -y awscli
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
  brew cask install flixtools --language=pt-BR
  brew cask install folx --language=pt-BR
  brew cask install itau --language=pt-BR
  brew cask install sizeup --language=pt-BR
fi

# Clean the mess!
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt autoremove -y
  sudo apt clean all -y
else
  brew cleanup
  brew prune
  brew cask cleanup
fi
