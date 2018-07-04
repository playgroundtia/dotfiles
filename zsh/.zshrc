# Oh-my-zsh installation
export ZSH=~/.dotfiles/zsh/.oh-my-zsh

ZSH_THEME="dracula"
DISABLE_AUTO_UPDATE="true"

# Aliases
alias bc="bc -l"
alias cd..="cd .."
alias dd="dd status=progress"
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
alias sendKeys="gpg --send-keys 0x61D32924C3587EA4"
alias wget="wget -c -N"

# Remove duplicates and useless commands from command history
export HISTCONTROL=ignoredups
export HISTIGNORE="cd:ls:[bf]g:clear:exit"

# Transfer.sh
transfer() {
  if [ $# -eq 0 ]; then
    echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
    return 1;
  fi

  tmpfile=$( mktemp -t transferXXX );

  if tty -s; then
    basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" | awk '{$1=$1};1' >> $tmpfile;
  else
    curl --progress-bar --upload-file "-" "https://transfer.sh/$1" | awk '{$1=$1};1' >> $tmpfile;
  fi;

  cat $tmpfile;
  if [[ "$(uname)" == "Linux" ]]; then
    xsel -b < $tmpfile
  else
    cat $tmpfile | pbcopy
  fi
  rm -f $tmpfile
}

# Specific configs
case "$(uname)" in
  Linux)
    alias f5="sudo apt update -y && \
              sudo apt dist-upgrade -y && \
              sudo apt autoremove -y && \
              sudo apt clean all -y && \
              cd ~/.dotfiles && \
              git pull-sub && \
              git submodule update --recursive --remote && \
              source ~/.zshrc"

    # Tilix
    if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
      source /etc/profile.d/vte.sh
    fi

    if [[ -n $SSH_CONNECTION ]]; then
      export EDITOR='vim'
    else
      export EDITOR='mvim'
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
              git submodule update --recursive --remote && \
              source ~/.zshrc"

    export PATH="/usr/local/opt/curl/bin:$PATH"
    export PATH="/usr/local/opt/icu4c/bin:$PATH"
    export PATH="/usr/local/opt/icu4c/sbin:$PATH"
    export PATH="/usr/local/opt/python/libexec/bin:$PATH"
    export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

    if [[ -n $SSH_CONNECTION ]]; then
      export EDITOR='vim'
    else
      export EDITOR='gvim'
    fi
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
