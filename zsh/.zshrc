# Oh-my-zsh installation
export ZSH=~/.dotfiles/zsh/.oh-my-zsh

# Oh-my-zsh theme
ZSH_THEME="awesomepanda"

# Aliases
alias .....="cd ../../../../"
alias ....="cd ../../../../"
alias ...="cd ../../../"
alias ..="cd .."
alias bc="bc -l"
alias cd..="cd .."
alias fastping="ping -c 100 -s.2"
alias la="ls -aF"
alias ld="ls -ld"
alias less="less -R"
alias ll="ls -la"
alias mkdir="mkdir -pv"
alias more="more -R"
alias mount="mount |column -t"
alias path="echo $PATH | tr ':' '\n' | nl"
alias ping="ping -c 5"
alias rmsvn="find . -type d -name .svn -exec rm -rf {} \;"
alias wget="wget -c"

# Specific aliases
case "$(uname)" in
  Linux)
    # Configurations
    TERM=xterm-256color

    alias f5="sudo apt-get update -y && \
              sudo apt-get upgrade -y && \
              sudo apt-get dist-upgrade -y && \
              sudo apt-get autoremove -y && \
              sudo apt-get clean all -y && \
              cd ~/.dotfiles && \
              git pull-sub && \
              source ~/.zshrc"
    ;;
  Darwin)
    alias f5="brew update && \
              brew upgrade && \
              brew cu --all --yes --cleanup && \
              brew cleanup && \
              brew prune && \
              brew cask cleanup && \
              cd ~/.dotfiles && \
              git pull-sub && \
              source ~/.zshrc"

    export PATH="/usr/local/opt/curl/bin:$PATH"
    ;;
esac

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Oh-my-zsh plugins
plugins=(
  brew
  debian
  docker
  docker-compose
  gem
  git
  github
  gulp
  heroku
  man
  node
  npm
  osx
  postgres
  rails
  redis-cli
  rsync
  ruby
  ssh-agent
  sublime
  sudo
  ubuntu
  vagrant
  xcode
  yarn
)

source $ZSH/oh-my-zsh.sh

# Language environment
export LANG=pt_BR.UTF-8
