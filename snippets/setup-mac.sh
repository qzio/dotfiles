#!/usr/bin/env bash


confirm()
{
  echo "$@"
  echo "continue with enter, ctrl-c to abort"
  read _
}

confirm "install dotfiles"
./install.sh

# ref https://github.com/trusche/dotfiles/blob/master/osx
echo "set some default macos stuff"
(set -x
defaults write -g com.apple.mouse.scaling -1
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSScrollAnimationEnabled -bool false
defaults write -g NSWindowResizeTime -float 0.001
defaults write -g QLPanelAnimationDuration -float 0
defaults write -g NSScrollViewRubberbanding -bool false
defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write -g NSToolbarFullScreenAnimationDuration -float 0
defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0
defaults write -g NSGlobalDOmain NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g com.apple.swipescrolldirection -bool false
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 25 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
defaults write com.apple.dock static-only -bool true
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock no-glass -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock expose-animation-duration -float 0
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
defaults write com.apple.dock springboard-page-duration -float 0
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.Mail DisableSendAnimations -bool true
defaults write com.apple.Mail DisableReplyAnimations -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock workspaces-swoosh-animation-off -bool YES
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
)
killall Dock


confirm "Download the solarized_dark theme to Terminal.app (you have to import this manually afterwards...)"
curl -o ~/Downloads/solarized_dark.terminal -L https://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Dark.terminal

confirm "setting up brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

confirm echo "install some brew packages"
brew install \
     gnupg zsh tmux ruby-install openvpn jq git mtr nmap stow mosh awscli \
     reattach-to-user-namespace readline openssl chruby nvm

confirm "install some macos apps through brew/cask"
brew cask install \
     karabiner-elements vagrant virtualbox \
     google-chrome firefox slack spotify macdown



confirm "change shell to zsh $(which zsh)"
sudo chsh -s $(which zsh) $(whoami)

echo "Install docker-for-mac"
curl -o ~/Downloads/docker-for-mac.dmg -L https://download.docker.com/mac/stable/Docker.dmg 
open ~/Downloads/docker-for-mac.dmg

echo "ok, auto setup done"

echo "Install java by accepting and downloading the macos jdk package"
open 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'

ruby_install_java="ruby-install jruby-9."
confirm "install some rubies. Make sure you have java installed before continuing!"
if [ $(which -a java | wc -l) -lt 1 ] ; then
  confirm "continue without java?"
  ruby_install_java="echo 'when you have the java jdk installed, you can ruby-install jruby-9. to install jruby'"
fi
ruby-install -L
ruby-install ruby-2.4
ruby-install ruby-2.3
ruby_install_java

confirm "install node --lts through nvm"
mkdir -p ~/.nvm
source "/usr/local/opt/nvm/nvm.sh"
export NVM_DIR="$HOME/.nvm"
nvm install --lts
