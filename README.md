# Nathan's DotFiles

My personal Dotfiles. My environment is designed for use in a linux (Ubuntu / mint) environment, at this time my installation scripts only handle debian based distro's these could be ported. My environment is comprised of the following software and tools.

* ZSH - backed by oh-my-zsh
* Tmux
* Vim8
* Pyenv
* Rbenv

## Installation:

curl -s https://raw.githubusercontent.com/nkondra/dotfiles/master/build-dots.sh | bash

##Testing configurations:

- Removed xmod mapper from zshrc and replaced it with dconf command
- Had to revert back to xmod mapper for Mint
`dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"`

