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

###################
# Command aliases #
###################

alias ll="ls -alh"

####################
# Custom Functions #
####################

# Load (exported) the contents of a .env file
loadenv() {
  local env_file="${1:-.env}"
  if [ -f "$env_file" ]; then
    export $(cat "$env_file" | xargs)
    echo "Loaded $env_file"
  else
    echo "Error: file $env_file not found"
  fi
}

# A place for local configuration not checked into repo.
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
