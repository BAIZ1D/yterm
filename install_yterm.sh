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

# 2. Advanced Dependency Management
echo -e "${BLUE}Checking dependencies...${NC}"

if [ "$DISTRO" == "Linux" ] && command -v apt &> /dev/null; then
    echo -e "${BLUE}Optimizing yt-dlp for Linux/WSL...${NC}"
    # Remove often outdated apt version
    if dpkg -l | grep -q yt-dlp; then
        echo -e "${RED}Removing outdated yt-dlp from apt...${NC}"
        sudo apt remove -y yt-dlp
    fi
    
    echo -e "${BLUE}Installing system dependencies...${NC}"
    sudo apt update && sudo apt install -y fzf mpv curl nodejs
    
    echo -e "${BLUE}Installing latest standalone yt-dlp binary...${NC}"
    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
    
elif [ "$DISTRO" == "Mac" ] && command -v brew &> /dev/null; then
    echo -e "${BLUE}Installing for macOS via Homebrew...${NC}"
    brew install yt-dlp fzf mpv curl node
else
    echo -e "${RED}Error: Cannot auto-install dependencies.${NC}"
    exit 1
fi

# 3. Installation
# Detect the real user and home directory (even under sudo)
ACTUAL_USER="${SUDO_USER:-$USER}"
ACTUAL_HOME=$(eval echo "~$ACTUAL_USER")
INSTALL_DIR="$ACTUAL_HOME/.local/bin"

if [ "$USER" == "root" ] && [ -n "$SUDO_USER" ]; then
    echo -e "${BLUE}Running as root via sudo. Installing for user: ${ACTUAL_USER}${NC}"
fi

mkdir -p "$INSTALL_DIR"

echo -e "Downloading yterm to ${GREEN}${INSTALL_DIR}/yterm${NC}"
curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm" || \
curl -ksSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm"

chmod +x "$INSTALL_DIR/yterm"
# Ensure the user owns the binary if we created it as root
if [ "$USER" == "root" ] && [ -n "$SUDO_USER" ]; then
    chown "$ACTUAL_USER" "$INSTALL_DIR/yterm"
fi

# 4. PATH Setup
SHELL_CONFIG=""
# Detect shell based on the actual user's preference or environment
USER_SHELL=$(getent passwd "$ACTUAL_USER" | cut -d: -f6 | xargs -I {} basename {} 2>/dev/null || echo $SHELL)

if [[ "$USER_SHELL" == *"zsh"* ]]; then 
    SHELL_CONFIG="$ACTUAL_HOME/.zshrc"
elif [[ "$USER_SHELL" == *"bash"* ]]; then 
    SHELL_CONFIG="$ACTUAL_HOME/.bashrc"
else
    # Fallback to checking for existence
    if [ -f "$ACTUAL_HOME/.zshrc" ]; then SHELL_CONFIG="$ACTUAL_HOME/.zshrc"
    elif [ -f "$ACTUAL_HOME/.bashrc" ]; then SHELL_CONFIG="$ACTUAL_HOME/.bashrc"
    fi
fi

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    if [ -n "$SHELL_CONFIG" ]; then
        echo -e "${BLUE}Updating PATH in ${SHELL_CONFIG}...${NC}"
        
        # Check if writable, use sudo tee if not
        if [ ! -w "$SHELL_CONFIG" ] && [ -f "$SHELL_CONFIG" ]; then
            echo -e "\n# Added by yterm\nexport PATH=\"\$HOME/.local/bin:\$PATH\"" | sudo tee -a "$SHELL_CONFIG" > /dev/null
        else
            echo -e "\n# Added by yterm" >> "$SHELL_CONFIG"
            echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_CONFIG"
        fi
        
        echo -e "${GREEN}Added to PATH via ${SHELL_CONFIG}. Restart your terminal or run 'source ${SHELL_CONFIG}'${NC}"
    else
        echo -e "${RED}Warning: Could not detect shell config file (e.g., .zshrc). Please add ${INSTALL_DIR} to your PATH manually.${NC}"
    fi
fi

echo -e "${GREEN}✅ yterm is ready!${NC}"
echo -e "\n${BLUE}--- QUICK START GUIDE ---${NC}"

if [ "$IS_WSL" -eq 1 ]; then
    echo -e "Windows Users: First type ${GREEN}wsl${NC} and press Enter to enter your Linux environment."
fi

echo -e "1. ${GREEN}Search${NC}  : yterm \"search query\""
echo -e "2. ${GREEN}Playlist${NC}: Use ${BLUE}TAB${NC} to select multiple videos."
echo -e "3. ${GREEN}Play${NC}     : Hit ${BLUE}ENTER${NC}."
echo -e "4. ${GREEN}Skip${NC}     : Press ${BLUE}q${NC} to skip to the next video."
echo -e "-------------------------"
echo -e "If search ever stops working, just run: ${BLUE}yterm --update${NC}"
