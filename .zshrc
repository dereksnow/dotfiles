#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export NVM_DIR=~/.nvm 
source $(brew --prefix nvm)/nvm.sh

# Launch macvim in terminal (without gui)
alias mvit="mvim -v" 
# Support for 256 colors in tmux
alias tmux="TERM=screen-256color-bce tmux"

# Powerline support
. /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
