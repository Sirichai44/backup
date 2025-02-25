#!/bin/bash

# Define backup directory
BACKUP_DIR=~/Desktop/backup

echo "🚀 Starting backup to $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# 1. Backup Zsh configuration
echo "🐚 Backing up Zsh configuration"
cp ~/.zshrc ~/.p10k.zsh "$BACKUP_DIR" 2>/dev/null
cp -r ~/.oh-my-zsh "$BACKUP_DIR" 2>/dev/null

# 2. Backup Homebrew packages
if command -v brew &>/dev/null; then
    echo "🍺 Backing up Homebrew packages"
    brew bundle dump --file="$BACKUP_DIR/Brewfile" --force
else
    echo "⚠️ Homebrew is not installed"
fi

# 3. Backup Git configuration (if exists)
echo "🔗 Backing up Git configuration"
cp ~/.gitconfig ~/.gitignore_global "$BACKUP_DIR" 2>/dev/null

# 4. Backup VSCode settings (if exists)
if [ -d "$HOME/Library/Application Support/Code/User" ]; then
    echo "💻 Backing up VSCode settings"
    mkdir -p "$BACKUP_DIR/vscode"
    cp "$HOME/Library/Application Support/Code/User/settings.json" "$BACKUP_DIR/vscode/" 2>/dev/null
    cp "$HOME/Library/Application Support/Code/User/keybindings.json" "$BACKUP_DIR/vscode/" 2>/dev/null
else
    echo "⚠️ VSCode settings not found"
fi

# 5. Backup SSH keys (if exists)
echo "🔐 Backing up SSH keys"
mkdir -p "$BACKUP_DIR/ssh"
cp -r ~/.ssh/* "$BACKUP_DIR/ssh" 2>/dev/null

# 6. Backup macOS System Preferences (if possible)
echo "⚙️ Backing up System Preferences"
defaults read > "$BACKUP_DIR/system_preferences.plist"

echo "🎉 Backup completed! Check your backup folder at: $BACKUP_DIR"
