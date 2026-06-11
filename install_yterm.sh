#!/usr/bin/env bash
# yterm Official Installer
# Made by: BAIZID AL HAMID (cause I was bored)
# Works on Debian/Ubuntu, macOS, and Windows (via WSL)

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}📺 yterm: The \"Boredom\" Installation Script${NC}"

# 1. Platform Detection
OS="$(uname -s)"
IS_WSL=0
if grep -qE "(Microsoft|microsoft|WSL)" /proc/version 2>/dev/null; then
    IS_WSL=1
fi

# 2. Permission Rescue Function
# This fixes directories that might be owned by root from previous failed sudo runs
ensure_writable() {
    local target="$1"
    if [ -z "$target" ]; then return; fi

    # If the parent directory exists but is not writable, we need to fix it first
    local parent
    parent=$(dirname "$target")
    if [ -d "$parent" ] && [ ! -w "$parent" ]; then
        echo -e "${BLUE}Fixing permissions for parent directory: ${parent}${NC}"
        sudo chown "$USER" "$parent" 2>/dev/null || true
    fi

    # Now handle the target itself
    if [ -e "$target" ]; then
        if [ ! -w "$target" ]; then
            echo -e "${BLUE}Fixing permissions for ${target}...${NC}"
            sudo chown -R "$USER" "$target" 2>/dev/null || true
        fi
    else
        # Try to create it, fallback to sudo if fails
        mkdir -p "$target" 2>/dev/null || (echo -e "${BLUE}Creating ${target} with sudo...${NC}" && sudo mkdir -p "$target" && sudo chown -R "$USER" "$target")
    fi
}

# 3. Advanced Dependency Management
echo -e "${BLUE}Checking dependencies...${NC}"

if [[ "${OS}" == "Linux"* ]]; then
    if command -v apt &> /dev/null; then
        echo -e "${BLUE}Optimizing yt-dlp for Linux/WSL...${NC}"
        if dpkg -l | grep -q yt-dlp; then
            echo -e "${RED}Removing outdated yt-dlp from apt...${NC}"
            sudo apt remove -y yt-dlp
        fi
        echo -e "${BLUE}Installing system dependencies...${NC}"
        sudo apt update && sudo apt install -y fzf mpv ffmpeg curl nodejs
        
        echo -e "${BLUE}Installing latest standalone yt-dlp binary...${NC}"
        ensure_writable "/usr/local/bin"
        sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
        sudo chmod a+rx /usr/local/bin/yt-dlp
    fi
elif [[ "${OS}" == "Darwin"* ]]; then
    echo -e "${BLUE}macOS Detected.${NC}"
    if [ "$USER" == "root" ]; then
        echo -e "${RED}Error: Please do NOT run this installer with 'sudo bash' on macOS.${NC}"
        echo -e "Homebrew forbids running as root. Run simply as: ${GREEN}curl ... | bash${NC}"
        exit 1
    fi
    if command -v brew &> /dev/null; then
        echo -e "${BLUE}Installing for macOS via Homebrew...${NC}"
        brew install yt-dlp fzf mpv ffmpeg curl node
        
        # macOS MPV FIX: Ensure mpv uses yt-dlp explicitly
        echo -e "${BLUE}Configuring mpv for macOS...${NC}"
        ensure_writable "$HOME/.config"
        ensure_writable "$HOME/.config/mpv"
        
        CONFIG_FILE="$HOME/.config/mpv/mpv.conf"
        if [ ! -f "$CONFIG_FILE" ] || ! grep -q "ytdl_path=yt-dlp" "$CONFIG_FILE"; then
            echo "script-opts=ytdl_hook-ytdl_path=yt-dlp" >> "$CONFIG_FILE"
            echo "ytdl-format=\"bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/best[ext=mp4]/best\"" >> "$CONFIG_FILE"
        fi
    else
        echo -e "${RED}Homebrew not found. Please install Homebrew first: https://brew.sh/${NC}"
        exit 1
    fi
fi

# 4. Installation
INSTALL_DIR="$HOME/.local/bin"
ensure_writable "$HOME/.local"
ensure_writable "$INSTALL_DIR"

echo -e "Downloading yterm to ${GREEN}${INSTALL_DIR}/yterm${NC}"
curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm" || \
curl -ksSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm"

chmod +x "$INSTALL_DIR/yterm"

# 5. PATH Setup & Ownership Fix
SHELL_CONFIG=""
if [[ "$SHELL" == *"zsh"* ]]; then 
    SHELL_CONFIG="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then 
    SHELL_CONFIG="$HOME/.bashrc"
fi

if [ -n "$SHELL_CONFIG" ]; then
    # Fix ownership of shell config if root-owned
    ensure_writable "$SHELL_CONFIG"

    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        if [ -f "$SHELL_CONFIG" ]; then
            if ! grep -q "Added by yterm" "$SHELL_CONFIG"; then
                echo -e "${BLUE}Updating PATH in ${SHELL_CONFIG}...${NC}"
                echo -e "\n# Added by yterm\nexport PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_CONFIG"
                echo -e "${GREEN}Added to PATH. Please restart your terminal or run: source ${SHELL_CONFIG}${NC}"
            fi
        else
            echo -e "${BLUE}Creating ${SHELL_CONFIG} and updating PATH...${NC}"
            echo -e "# Added by yterm\nexport PATH=\"\$HOME/.local/bin:\$PATH\"" > "$SHELL_CONFIG"
            echo -e "${GREEN}Created ${SHELL_CONFIG} and added to PATH.${NC}"
        fi
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
echo -e "If things don't work, run: ${BLUE}yterm --update${NC}"
