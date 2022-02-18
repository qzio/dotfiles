
confirm()
{
  echo "$@"
  echo "continue with enter, ctrl-c to abort"
  read _
}

confirm "install dotfiles"
./install.sh

echo "set some default macos stuff"
set -x
# defaults write -g com.apple.mouse.scaling -1
# defaults write -g com.apple.swipescrolldirection -bool false
defaults write -g NSWindowResizeTime -float 0.001
defaults write -g InitialKeyRepeat -int 25 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
defaults write com.apple.dock static-only -bool true
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide -bool true
set +x


confirm echo "install some brew packages"
brew install \
     gnupg zsh tmux jq git mtr nmap mosh \
     reattach-to-user-namespace
