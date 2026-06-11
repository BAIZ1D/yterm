#!/bin/bash
# yterm Official Installer
# Made by: BAIZID AL HAMID (cause I was bored)
# Works on Linux, macOS, and WSL

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Initializing yterm installation...${NC}"

# 1. Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     DISTRO="Linux";;
    Darwin*)    DISTRO="Mac";;
    CYGWIN*|MINGW32*|MSYS*|MINGW*) DISTRO="Windows";;
    *)          DISTRO="Unknown"
esac

echo -e "System detected: ${GREEN}${DISTRO}${NC}"

# 2. Check Dependencies
check_dep() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}⚠️  Missing dependency: $1${NC}"
        return 1
    fi
    return 0
}

DEPS=("yt-dlp" "fzf" "mpv" "curl")
MISSING=0
for dep in "${DEPS[@]}"; do
    check_dep "$dep" || MISSING=1
done

if [ $MISSING -eq 1 ]; then
    echo -e "${BLUE}Suggesting install commands:${NC}"
    if [ "$DISTRO" == "Linux" ]; then
        echo "   sudo apt update && sudo apt install yt-dlp fzf mpv curl"
    elif [ "$DISTRO" == "Mac" ]; then
        echo "   brew install yt-dlp fzf mpv curl"
    fi
    echo -e "${RED}Please install the missing dependencies and run this again.${NC}"
    exit 1
fi

# 3. Installation
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

echo -e "Downloading and installing yterm to ${GREEN}${INSTALL_DIR}/yterm${NC}"
curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm"
chmod +x "$INSTALL_DIR/yterm"

# 4. Path Check
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo -e "${RED}⚠️  Note: ${INSTALL_DIR} is not in your PATH.${NC}"
    echo "Add this to your .bashrc or .zshrc:"
    echo "   export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo -e "${GREEN}✅ yterm installation complete!${NC}"
echo "Try running: yterm --help"
