#!/usr/bin/env bash

confirm()
{
  echo "$@"
  echo "continue with enter, ctrl-c to abort"
  read _
}

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
defaults write NSGlobalDOmain ApplePressAndHoldEnabled -bool false
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
)
killall Dock


confirm "setting up brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

confirm echo "install some brew packages"
brew install \
     gnupg zsh tmux ruby-install \
     reattach-to-user-namespace readline openssl chruby \
     openvpn jq git mtr nmap

confirm "install some macos apps through brew/cask"
brew cask install \
     karabiner-elements vagrant virtualbox \
     google-chrome firefox



confirm "change shell to zsh $(which zsh)"
#sudo chsh -s $(which zsh) $(whoami)

echo "Install docker-for-mac"
curl -o ~/Downloads/docker-for-mac.dmg -L https://download.docker.com/mac/stable/Docker.dmg 
open ~/Downloads/docker-for-mac.dmg

echo "ok, auto setup done"

echo "Install java through"
echo " --> http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html"
open 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
# http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-macosx-x64.dmg

confirm "install some rubies. Make sure you have java installed before continuing!"

ruby-install -L
ruby-install jruby-9.
ruby-install ruby-2.4
ruby-install ruby-2.3
