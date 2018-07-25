################################################################################
# Tmux
################################################################################
if [ -z "$TMUX" ]; then
  tmux new-session -s $$;
else
  export TERM="screen-256color"
fi

################################################################################
# Aliases
################################################################################
alias bc="bc -l"
alias cd..="cd .."
alias la="ls -aF"
alias ld="ls -ld"
alias less="less -R"
alias ll="ls -la"
alias mkdir="mkdir -pv"
alias more="more -R"
alias mount="mount | column -t"
alias mutt="neomutt"
alias ping="ping -c 5"
alias sendKeys="gpg --send-keys 0x61D32924C3587EA4"
alias wget="wget -c -N"

################################################################################
# Settings
################################################################################
export EDITOR='vim'
export HISTCONTROL=ignoredups
export HISTIGNORE="cd:ls:[bf]g:clear:exit"
export LANG=pt_BR.UTF-8

case "$(uname)" in
  Linux)
    alias f5="sudo apt update -y && \
              sudo apt dist-upgrade -y && \
              sudo apt autoremove -y && \
              sudo apt clean all -y && \
              \
              cd ~/.dotfiles && \
              git pull-sub && \
              git submodule update --recursive --remote && \
              \
              sudo yarn global upgrade && \
              \
              vim +PlugUpgrade +PlugUpdate +qall && \
              \
              bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
              \
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
              \
              mas upgrade && \
              \
              sudo softwareupdate -i -a && \
              \
              cd ~/.dotfiles && \
              git pull-sub && \
              git submodule update --recursive --remote && \
              \
              sudo yarn global upgrade && \
              \
              vim +PlugUpgrade +PlugUpdate +qall && \
              \
              bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
              \
              source ~/.zshrc"
    ;;
esac

################################################################################
# Scripts
################################################################################
source ~/.dotfiles/zsh/scripts/*

################################################################################
# Oh-my-zsh
################################################################################
export ZSH=~/.dotfiles/zsh/.oh-my-zsh
ZSH_THEME="dracula"
DISABLE_AUTO_UPDATE="true"
HIST_STAMPS="dd/mm/yyyy"
plugins=(
  docker
  docker-compose
  git
  gpg-agent
  iterm2
  node
  npm
  osx
  ssh-agent
  sudo
  tmux
  ubuntu
  yarn
)
source $ZSH/oh-my-zsh.sh
