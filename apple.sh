#!/usr/bin/env bash

# Defaults

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXRemoveOldTrashItems -bool true
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# disable .ds_store file creation
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true


killall Finder

# Keyrepeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# Dock
# defaults write com.apple.dock tilesize -float 42
# defaults write com.apple.dock mineffect scale
# defaults write com.apple.dock magnification -bool false
# defaults write com.apple.dock autohide -bool true
# defaults write com.apple.dock autohide-time-modifier -float 0.12
# defaults write com.apple.Dock autohide-delay -float 0.05

# defaults write com.apple.dock mru-spaces -bool false
# defaults delete com.apple.dock
# defaults import com.apple.dock "$(pwd)/com.apple.dock.plist"

# killall Dock

# Menubar
# Date & Time
defaults write com.apple.menuextra.clock ShowDate -int 1
defaults write com.apple.menuextra.clock Show24Hour -int 1
defaults write com.apple.menuextra.clock ShowDayOfWeek -int 1
