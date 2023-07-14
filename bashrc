# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Include the OS bash defaults for now, because I don't want to customize these yet...
if [ -f ~/.bashrc.default ]; then
    . ~/.bashrc.default
fi

# Enable vim bindings in terminal.
set -o vi

# NVM config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Flutter path
if [ -d ~/snap/flutter/common/flutter/bin ]; then
    eval FLUTTER_BIN="~/snap/flutter/common/flutter/bin"
    export PATH="$PATH:$FLUTTER_BIN"
fi

# Chrome-like executable
export CHROME_EXECUTABLE="/snap/bin/chromium"

# Set JAVA_HOME in a way that responds to update-java-alternatives
JAVA_HOME=$(dirname $(dirname $(readlink -nf /etc/alternatives/java)))
if [ ! -e "$JAVA_HOME" ]; then
  JAVA_HOME=""
fi
export JAVA_HOME=$JAVA_HOME

# A place for local configuration not checked into repo.
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# Command to export the contents of a .env file
loadenv() {
  local env_file="${1:-.env}"
  if [ -f "$env_file" ]; then
    export $(cat "$env_file" | xargs)
    echo "Loaded $env_file"
  else
    echo "Error: file $env_file not found"
  fi
}
