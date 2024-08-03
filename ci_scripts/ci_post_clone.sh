#!/bin/zsh
echo "Starting ci_post_clone.sh script"
 defaults write com.apple.dt.Xcode IDESkipPackagePluginFingerprintValidation -bool YES
 defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES
echo "IDESkipPackagePluginFingerprintValidation has been set to YES"
