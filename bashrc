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

scratch() {
  # NOTE: scratch folders/symlinks are ignored by my gitignore_global.
  case "$1" in
    -h|--help)
    cat <<EOF
Create ./scratch as a symlink into Dropbox.

Usage:
  scratch [namespace] [project_name]

Arguments:
  namespace     Optional subdirectory under Dropbox.
  project_name  Defaults to the current directory name.

Existing ./scratch contents are migrated to the Dropbox folder.
Set \$DROPBOX_DIR if Dropbox is in a non-standard location.
EOF
    return 0
    ;;
  esac

  local dropbox_dir="${DROPBOX_DIR:-$HOME/Dropbox}"
  local project_dir="${2:-${PWD##*/}}"
  local scratch_dir="$PWD/scratch"
  local target_dir="$dropbox_dir/${1:+$1/}$project_dir"

  if [ -L "$scratch_dir" ]; then
    echo "Error: $scratch_dir is already a symlink"
    return 1
  fi

  mkdir -p "$target_dir" || return 1

  if [ -d "$scratch_dir" ]; then
    cp -a "$scratch_dir"/. "$target_dir"/ || return 1
    rm -rf "$scratch_dir" || return 1
  fi

  ln -s "$target_dir" "$scratch_dir" || return 1
  echo "Created $scratch_dir linked to $target_dir"
}

# A place for local configuration not checked into repo.
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
