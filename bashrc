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

alias ll="ls -alh"

# Chrome-like executable
export CHROME_EXECUTABLE="/snap/bin/chromium"

# Set JAVA_HOME in a way that responds to update-java-alternatives
# JAVA_HOME=$(dirname $(dirname $(readlink -nf /etc/alternatives/java)))
# if [ ! -e "$JAVA_HOME" ]; then
#   JAVA_HOME=""
# fi
# export JAVA_HOME=$JAVA_HOME

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

# Command to activate a python venv.
ae() {
  if [ -d ".venv" ]; then
    source .venv/bin/activate
  elif [ -d "venv" ]; then
    source venv/bin/activate
  else
    echo "No venv found in current directory."
  fi
}

# Command to blitz and recreate a python venv (if python is installed).
if command -v python3.11 >/dev/null 2>&1; then
  revenv_3_11()  {
    local venv_dir="${1:-.venv}"

    # deactivate and remove the old venv if it exists
    if command -v deactivate >/dev/null 2>&1; then
      deactivate
    fi

    if [ -d "$venv_dir" ]; then
      echo "Removing existing venv: $venv_dir"
      rm -rf "$venv_dir"
    fi

    # create a new venv
    python3.11 -m venv "$venv_dir"

    # activate venv
    source "$venv_dir/bin/activate"

    # install requirements if named
    if [ -f "requirements.txt" ]; then
      python -m pip install -r requirements.txt
    fi
    if [ -f "requirements-dev.txt" ]; then
      python -m pip install -r requirements-dev.txt
    fi

    echo
    echo "New $(python -V) venv has been created (path: $venv_dir) and is now active. Watch out for snakes."
  }

  alias revenv="revenv_3_11"
  alias venv="source .venv/bin/activate"
fi

# Command to create a symlink. This is overkill but I always mess up the order of arguments.
create_symlink() {
    local from=""
    local to=""

    while [[ $# -gt 0 ]]; do
        key="$1"
        case $key in
            --from)
                from="$2"
                shift # past argument
                shift # past value
                ;;
            --to)
                to="$2"
                shift # past argument
                shift # past value
                ;;
            *) # unknown option
                echo "Unknown option: $1"
                return 1
                ;;
        esac
    done

    if [[ -z $from || -z $to ]]; then
        echo "Usage: create_symlink --from <source> --to <link>"
        return 1
    fi

    if [[ ! -e $from ]]; then
        echo "Error: Source file/directory '$from' does not exist."
        return 1
    fi

    # Create the symlink
    ln -s "$from" "$to"
    echo "Symbolic link created: '$to' (linked to '$from')"
}
