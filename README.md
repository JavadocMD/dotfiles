# Dotfiles

My machine config powered by [DotBot][dotbot].

[dotbot]: https://github.com/anishathalye/dotbot

## Usage

First install uv and just; then run `just install`.

## Adding vim plugins

Typically it's sufficient to add the plugin's git repo as a submodule to `~/.vim/pack/vendor/start`.

For example:

```bash
cd ./vim/pack/vendor/start
git submodule add https://github.com/preservim/nerdtree.git nerdtree
```
