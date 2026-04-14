# ==============================================================================
# 1. CORE PATHS & BASE ENVIRONMENT
# ==============================================================================
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$(go env GOPATH)/bin:$PATH:$HOME/.tfenv/bin:$HOME/.bin
export PATH="$PATH:/Users/mustafa.yumurtaci/.dotnet/tools"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=/opt/apache-maven-3.8.1/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

export JAVA_HOME=$(/usr/libexec/java_home -v 11.0.17)
export GOPROXY=https://proxy.golang.org,direct

# ==============================================================================
# 2. OH MY ZSH CONFIGURATION
# ==============================================================================
export ZSH="/Users/mustafa.yumurtaci/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git git-open kubectx)
source $ZSH/oh-my-zsh.sh

# ==============================================================================
# 3. CUSTOM ENVIRONMENT VARIABLES
# ==============================================================================
# History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# Android Configuration
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$PATH
export PATH=$PATH:$ANDROID_HOME/tools:$PATH
export PATH=$PATH:$ANDROID_HOME/tools/bin:$PATH
export PATH=$PATH:$ANDROID_HOME/platform-tools:$PATH

# Terminal Prompt
RPS1='$(kubectx_prompt_info)'

# ==============================================================================
# 4. TOOL INITIALIZATIONS (LAZY LOADING FOR SPEED)
# ==============================================================================
# FZF & Kubectl
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -f ~/.kubectl_completion ]] && source ~/.kubectl_completion

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
zsh_add_pyenv() {
    eval "$(pyenv init -)"
}
for cmd in python python3 pip pip3 pyenv; do
    alias $cmd="unalias python python3 pip pip3 pyenv; zsh_add_pyenv; $cmd"
done

# NVM
export NVM_DIR="$HOME/.nvm"
zsh_add_nvm() {
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
}
for cmd in node npm yarn nvm; do
  alias $cmd="unalias node npm yarn nvm; zsh_add_nvm; $cmd"
done

# SDKMAN (Must be towards the end of the file)
export SDKMAN_DIR="$HOME/.sdkman"
zsh_add_sdkman() {
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}
for cmd in sdk java mvn gradle; do
    alias $cmd="unalias sdk java mvn gradle; zsh_add_sdkman; $cmd"
done

# RVM (Ruby) - Make sure this is the last PATH variable change
export PATH="$PATH:$HOME/.rvm/bin"

# ==============================================================================
# 5. ALIASES, FUNCTIONS & KEYBINDINGS
# ==============================================================================
# Navigation & System
alias cl="clear"
alias cls="cl&&ls"
alias temp='cd $(mktemp -d)'
alias pa="cd ~/product-ads"
alias docker="podman"
alias sonarqube="/opt/sonarqube/bin/macosx-universal-64/sonar.sh"

# Kubernetes
alias kc="kcfgctl"
alias kx="kubectx"
alias kn="kubens"
alias k="kubectl"
alias kgp="kubectl get pods"
alias km="kustomize"

wholisten() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

# Keybindings
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word