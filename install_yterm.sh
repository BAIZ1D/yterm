#!/usr/bin/env bash
# yterm Official Installer
# Made by: BAIZID AL HAMID (cause I was bored)
# Works on Debian/Ubuntu, macOS, and Windows (via WSL)

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}📺 yterm: The "Boredom" Installation Script${NC}"

# 1. Platform Detection
OS="$(uname -s)"
IS_WSL=0
if grep -qE "(Microsoft|microsoft|WSL)" /proc/version 2>/dev/null; then
    IS_WSL=1
fi

case "${OS}" in
    Linux*)     DISTRO="Linux";;
    Darwin*)    DISTRO="Mac";;
    *)          DISTRO="Unknown"
esac

# 2. Dependency Management
check_dep() {
    command -v "$1" &> /dev/null
}

DEPS=("yt-dlp" "fzf" "mpv" "curl")
MISSING=()
for dep in "${DEPS[@]}"; do
    if ! check_dep "$dep"; then MISSING+=("$dep"); fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
    echo -e "${BLUE}Missing dependencies: ${MISSING[*]}${NC}"
    
    if [ "$DISTRO" == "Linux" ] && command -v apt &> /dev/null; then
        echo -e "${BLUE}Installing for Debian/Ubuntu...${NC}"
        sudo apt update && sudo apt install -y "${MISSING[@]}"
    elif [ "$DISTRO" == "Mac" ] && command -v brew &> /dev/null; then
        echo -e "${BLUE}Installing for macOS via Homebrew...${NC}"
        brew install "${MISSING[@]}"
    else
        echo -e "${RED}Error: Cannot auto-install dependencies.${NC}"
        echo "Please install: ${MISSING[*]} manually and run this script again."
        exit 1
    fi
fi

# 3. Installation
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

echo -e "Downloading yterm to ${GREEN}${INSTALL_DIR}/yterm${NC}"
curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm" || \
curl -ksSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm"

chmod +x "$INSTALL_DIR/yterm"

# 4. PATH Setup
SHELL_CONFIG=""
if [[ "$SHELL" == *"zsh"* ]]; then SHELL_CONFIG="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then SHELL_CONFIG="$HOME/.bashrc"
fi

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    if [ -n "$SHELL_CONFIG" ]; then
        echo -e "\n# Added by yterm" >> "$SHELL_CONFIG"
        echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_CONFIG"
        echo -e "${GREEN}Added to PATH via ${SHELL_CONFIG}. Restart your terminal to use 'yterm'.${NC}"
    fi
fi

echo -e "${GREEN}✅ yterm is ready!${NC}"
echo "Run 'yterm --help' to see how it works."
