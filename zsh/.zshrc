# Oh-my-zsh installation
export ZSH=~/.dotfiles/zsh/.oh-my-zsh

# Oh-my-zsh theme
ZSH_THEME="awesomepanda"

# Aliases
alias bc="bc -l"
alias cd..="cd .."
alias gpgrestart="gpgconf --kill gpg-agent"
alias la="ls -aF"
alias ld="ls -ld"
alias less="less -R"
alias ll="ls -la"
alias mkdir="mkdir -pv"
alias more="more -R"
alias mount="mount |column -t"
alias mutt="neomutt"
alias path="echo $PATH | tr ':' '\n' | nl"
alias ping="ping -c 5"
alias wget="wget -c -N"
alias sendKeys="gpg --send-keys 0x61D32924C3587EA4"

# Specific configs
case "$(uname)" in
  Linux)
    alias f5="sudo apt update -y && \
              sudo apt dist-upgrade -y && \
              sudo apt autoremove -y && \
              sudo apt clean all -y && \
              cd ~/.dotfiles && \
              git pull-sub && \
              source ~/.zshrc"

    # Tilix
    if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
      source /etc/profile.d/vte.sh
    fi
    ;;
  Darwin)
    alias f5="brew update && \
              brew upgrade && \
              brew cu --all --yes --cleanup && \
              brew cleanup && \
              brew prune && \
              brew cask cleanup && \
              mas upgrade && \
              sudo softwareupdate -i -a && \
              cd ~/.dotfiles && \
              git pull-sub && \
              source ~/.zshrc"

    export PATH="/usr/local/opt/curl/bin:$PATH"
    export PATH="/usr/local/opt/icu4c/bin:$PATH"
    export PATH="/usr/local/opt/icu4c/sbin:$PATH"
    export PATH="/usr/local/opt/python/libexec/bin:$PATH"
    export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"
    ;;
esac

# Time stamp shown in the history command output
HIST_STAMPS="dd/mm/yyyy"

# Oh-my-zsh plugins
plugins=(
  docker
  docker-compose
  gem
  gi
  git
  github
  gpg-agent
  gulp
  iterm2
  man
  node
  npm
  osx
  ruby
  ssh-agent
  sudo
  tmux
  ubuntu
  vagrant
  xcode
  yarn
)

source $ZSH/oh-my-zsh.sh

# Language environment
export LANG=pt_BR.UTF-8
