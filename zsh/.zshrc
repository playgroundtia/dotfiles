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
alias mount="mount | column -t"
alias mutt="neomutt"
alias path="echo $PATH | tr ':' '\n' | nl"
alias ping="ping -c 5"
alias sendKeys="gpg --send-keys 0x61D32924C3587EA4"
alias wget="wget -c -N"

# Remove duplicates and useless commands from command history
export HISTCONTROL=ignoredups
export HISTIGNORE="cd:ls:[bf]g:clear:exit"

# Tmux
if [ -z "$TMUX" ]; then
  tmux new-session -s $$;
else
  export TERM="screen-256color"
fi

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
              \
              cd ~/.dotfiles && \
              git pull-sub && \
              git submodule update --recursive --remote && \
              \
              sudo yarn global upgrade \
              \
              vim +PlugUpgrade +PlugUpdate +qall \
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
              sudo yarn global upgrade \
              \
              vim +PlugUpgrade +PlugUpdate +qall \
              \
              source ~/.zshrc"
    ;;
esac

export ZSH=~/.dotfiles/zsh/.oh-my-zsh
export LANG=pt_BR.UTF-8
export EDITOR='vim'
ZSH_THEME="dracula"
DISABLE_AUTO_UPDATE="true"
HIST_STAMPS="dd/mm/yyyy"
plugins=(docker docker-compose git gpg-agent iterm2 node npm osx ssh-agent sudo tmux ubuntu yarn)
source $ZSH/oh-my-zsh.sh
