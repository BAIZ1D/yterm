#!/usr/bin/env bash
# yterm Official Installer
# Made by: BAIZID AL HAMID (cause I was bored)
# Works on Linux, macOS, and WSL

set -e # Exit on error

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

# 2. Dependency Management
check_dep() {
    if ! command -v "$1" &> /dev/null; then
        return 1
    fi
    return 0
}

DEPS=("yt-dlp" "fzf" "mpv" "curl")
MISSING=()

for dep in "${DEPS[@]}"; do
    if ! check_dep "$dep"; then
        MISSING+=("$dep")
    fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
    echo -e "${RED}⚠️  Missing dependencies: ${MISSING[*]}${NC}"
    
    # Auto-install suggestion/execution
    if [ "$DISTRO" == "Linux" ] && command -v apt &> /dev/null; then
        echo -en "${BLUE}Do you want to install missing dependencies via apt? [y/N]: ${NC}"
        read -r install_deps
        if [[ "$install_deps" =~ ^[Yy]$ ]]; then
            sudo apt update && sudo apt install -y "${MISSING[@]}"
        fi
    elif [ "$DISTRO" == "Mac" ] && command -v brew &> /dev/null; then
        echo -en "${BLUE}Do you want to install missing dependencies via Homebrew? [y/N]: ${NC}"
        read -r install_deps
        if [[ "$install_deps" =~ ^[Yy]$ ]]; then
            brew install "${MISSING[@]}"
        fi
    else
        echo -e "${BLUE}Please install the missing dependencies manually:${NC}"
        [ "$DISTRO" == "Linux" ] && echo "   sudo apt update && sudo apt install ${MISSING[*]}"
        [ "$DISTRO" == "Mac" ] && echo "   brew install ${MISSING[*]}"
        [ "$DISTRO" == "Windows" ] && echo "   Please install ${MISSING[*]} in your WSL or Git Bash environment."
        exit 1
    fi
fi

# 3. Installation
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

echo -e "Downloading and installing yterm to ${GREEN}${INSTALL_DIR}/yterm${NC}"
# Use -k if needed for SSL issues, but default to safe -sSL
if ! curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm"; then
    echo -e "${RED}Download failed. Retrying with insecure mode (-k)...${NC}"
    curl -ksSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm"
fi

chmod +x "$INSTALL_DIR/yterm"

# 4. Path Check & Shell Configuration
PATH_ADDED=0
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo -e "${RED}⚠️  Note: ${INSTALL_DIR} is not in your PATH.${NC}"
    
    SHELL_CONFIG=""
    if [[ "$SHELL" == *"zsh"* ]]; then
        SHELL_CONFIG="$HOME/.zshrc"
    elif [[ "$SHELL" == *"bash"* ]]; then
        SHELL_CONFIG="$HOME/.bashrc"
    fi

    if [ -n "$SHELL_CONFIG" ]; then
        echo -en "${BLUE}Do you want to add ${INSTALL_DIR} to your ${SHELL_CONFIG}? [y/N]: ${NC}"
        read -r add_path
        if [[ "$add_path" =~ ^[Yy]$ ]]; then
            echo -e "\n# Added by yterm installer" >> "$SHELL_CONFIG"
            echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_CONFIG"
            echo -e "${GREEN}Path added to ${SHELL_CONFIG}. Please restart your terminal or run: source ${SHELL_CONFIG}${NC}"
            PATH_ADDED=1
        fi
    fi
fi

# 5. Verification
if [ $PATH_ADDED -eq 0 ] && [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
     echo -e "${BLUE}To run yterm immediately, use:${NC} ${INSTALL_DIR}/yterm"
else
     echo -e "${GREEN}yterm is ready to use!${NC}"
fi

echo -e "${GREEN}✅ yterm installation complete!${NC}"
echo "Try running: yterm --help"
