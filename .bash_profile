export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[38;5;231m\][\t] \[\033[38;5;179m\]\h:\[\033[38;5;145m\]\w\[\033[33;1m\]\$(git_branch)\[\033[0m\] \$ "
source ~/.bashrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/williamlam/Desktop/tools/google-cloud-sdk/path.bash.inc' ]; then . '/Users/williamlam/Desktop/tools/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/williamlam/Desktop/tools/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/williamlam/Desktop/tools/google-cloud-sdk/completion.bash.inc'; fi
