# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/alvinlal/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/alvinlal/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/alvinlal/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/alvinlal/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH=~/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:/usr/local/mysql/bin:$PATH

# syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship
eval "$(starship init zsh)"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# interactive neovim search
alias inv='nvim $(fzf -m --preview="bat --color=always {}" --bind "ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up")'

# --- nvim
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# Setting GEM path
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
export PATH="$PATH:$GEM_HOME/bin"
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"

# For Fastlane
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Android
export ANDROID_SDK_ROOT=$HOME/Library/Android/Sdk
export ANDROID_HOME=$HOME/Library/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
