#!/bin/bash

# Define backup directory location
BACKUP_DIR=~/Desktop/backup

echo "🚀 Restoring from backup located at $BACKUP_DIR"

# 1. Restore Zsh configuration
echo "🐚 Restoring Zsh configuration"
cp "$BACKUP_DIR/.zshrc" ~/
cp "$BACKUP_DIR/.p10k.zsh" ~/
cp -r "$BACKUP_DIR/.oh-my-zsh" ~/ || echo "⚠️ .oh-my-zsh not found"

# 2. Restore Homebrew packages
if [ -f "$BACKUP_DIR/Brewfile" ]; then
    echo "🍺 Restoring Homebrew packages from Brewfile"
    brew bundle --file="$BACKUP_DIR/Brewfile"
else
    echo "⚠️ Brewfile not found"
fi

# 3. Restore Git configuration
echo "🔗 Restoring Git configuration"
cp "$BACKUP_DIR/.gitconfig" ~/
cp "$BACKUP_DIR/.gitignore_global" ~/

# 4. Restore VSCode settings (if available)
if [ -d "$BACKUP_DIR/vscode" ]; then
    echo "💻 Restoring VSCode settings"
    mkdir -p "$HOME/Library/Application Support/Code/User"
    cp "$BACKUP_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/" 2>/dev/null
    cp "$BACKUP_DIR/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/" 2>/dev/null
else
    echo "⚠️ VSCode settings not found"
fi

# 5. Restore SSH keys (if available)
if [ -d "$BACKUP_DIR/ssh" ]; then
    echo "🔐 Restoring SSH keys"
    cp -r "$BACKUP_DIR/ssh/*" ~/.ssh/ 2>/dev/null
else
    echo "⚠️ SSH keys not found"
fi

# 6. Restore macOS System Preferences
echo "⚙️ Restoring System Preferences"
defaults import "$BACKUP_DIR/system_preferences.plist" 2>/dev/null

# 7. Refresh Zsh to apply the restored settings
echo "♻️ Refreshing Zsh to apply the changes"
source ~/.zshrc

echo "🎉 Restore completed! Restart your terminal and system if needed."
