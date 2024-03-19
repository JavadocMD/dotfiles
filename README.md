# Dotfiles

My machine config powered by [DotBot][dotbot].

[dotbot]: https://github.com/anishathalye/dotbot

## Usage

Run `./install` on new machines (or any time there are significant conf changes, like new files that haven't been linked on this machine before).

## Installing vim plugins

Typically you can just add the git repo as a submodule in `~/.vim/pack/vendor/start`

For example:

```bash
cd ./vim/pack/vendor/start
git submodule add https://github.com/preservim/nerdtree.git nerdtree
```
