# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# XDG ENVIRONMENTS
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"

# XDG Ninja recommendations
############################################
#         XDG CONFIG HOME                 #
############################################
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/config
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

############################################
#         XDG DATA HOME                   #
############################################
export ANSIBLE_HOME="$XDG_DATA_HOME"/ansible
export ZSH="$XDG_DATA_HOME"/oh-my-zsh
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUBY_HOME="$XDG_DATA_HOME"/ruby

############################################
#         XDG CACHE HOME                  #
############################################
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy_cache

############################################
#         XDG STATE HOME                  #
############################################
export W3M_DIR="$XDG_STATE_HOME/w3m"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
