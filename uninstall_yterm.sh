#!/usr/bin/env bash
# yterm Official Uninstaller
# Version: 1.0.0

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🗑️  yterm: Uninstallation Script${NC}"

# 1. Remove the binary
INSTALL_DIR="$HOME/.local/bin"
if [ -f "$INSTALL_DIR/yterm" ]; then
    echo -e "Removing binary from ${INSTALL_DIR}/yterm..."
    rm "$INSTALL_DIR/yterm"
else
    echo -e "${RED}yterm binary not found in ${INSTALL_DIR}.${NC}"
fi

# 2. Cleanup Shell Configs
TARGET_FILES=("$HOME/.zshrc" "$HOME/.zprofile" "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile")

for shell_file in "${TARGET_FILES[@]}"; do
    if [ -f "$shell_file" ]; then
        if grep -q "Added by yterm" "$shell_file"; then
            echo -e "Removing yterm PATH entry from ${shell_file}..."
            # Create a backup just in case
            cp "$shell_file" "${shell_file}.yterm_bak"
            # Remove the lines added by yterm
            sed -i.tmp '/# Added by yterm/,/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$shell_file"
            rm "${shell_file}.tmp"
        fi
    fi
done

echo -e "${GREEN}✅ yterm has been successfully uninstalled.${NC}"
echo -e "Note: System dependencies (yt-dlp, mpv, etc.) were not removed."
