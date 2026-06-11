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

# 2. Permission Rescue Functions
ensure_writable_dir() {
    local target="$1"
    if [ -z "$target" ]; then return; fi

    if [ -e "$target" ]; then
        if [ ! -d "$target" ]; then
            echo -e "${RED}Warning: ${target} exists but is a file. Cannot create directory.${NC}"
            return
        fi
        if [ ! -w "$target" ]; then
            echo -e "${BLUE}Fixing permissions for directory ${target}...${NC}"
            sudo chown -R "$USER" "$target" 2>/dev/null || true
            sudo chmod -R u+w "$target" 2>/dev/null || true
        fi
    else
        local parent
        parent=$(dirname "$target")
        if [ "$parent" != "$HOME" ] && [ "$parent" != "/" ] && [ "$parent" != "." ]; then
            ensure_writable_dir "$parent"
        fi
        echo -e "${BLUE}Creating directory: ${target}${NC}"
        mkdir -p "$target" 2>/dev/null || (sudo mkdir -p "$target" && sudo chown "$USER" "$target")
    fi
}

ensure_writable_file() {
    local target="$1"
    if [ -z "$target" ]; then return; fi

    local parent
    parent=$(dirname "$target")
    ensure_writable_dir "$parent"

    if [ -e "$target" ]; then
        if [ -d "$target" ]; then
            echo -e "${RED}Error: ${target} is a directory. Removing to restore file functionality...${NC}"
            sudo rm -rf "$target"
            touch "$target" 2>/dev/null || (sudo touch "$target" && sudo chown "$USER" "$target")
        elif [ ! -w "$target" ]; then
            echo -e "${BLUE}Fixing permissions for file ${target}...${NC}"
            sudo chown "$USER" "$target" 2>/dev/null || true
            sudo chmod u+w "$target" 2>/dev/null || true
        fi
    else
        touch "$target" 2>/dev/null || (sudo touch "$target" && sudo chown "$USER" "$target")
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
        ensure_writable_dir "/usr/local/bin"
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
    if [ -x "/opt/homebrew/bin/brew" ]; then eval "$(/opt/homebrew/bin/brew shellenv)"; fi; if [ -x "/usr/local/bin/brew" ]; then eval "$(/usr/local/bin/brew shellenv)"; fi; if command -v brew &> /dev/null; then
        echo -e "${BLUE}Installing for macOS via Homebrew...${NC}"
        brew install yt-dlp fzf mpv ffmpeg curl node
        
        # macOS MPV FIX: Ensure mpv uses yt-dlp explicitly
        echo -e "${BLUE}Configuring mpv for macOS...${NC}"
        ensure_writable_dir "$HOME/.config/mpv"
        
        CONFIG_FILE="$HOME/.config/mpv/mpv.conf"
        ensure_writable_file "$CONFIG_FILE"
        if ! grep -q "ytdl_path=yt-dlp" "$CONFIG_FILE"; then
            echo "script-opts=ytdl_hook-ytdl_path=yt-dlp" >> "$CONFIG_FILE"
            echo "ytdl-format=\"bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/best[ext=mp4]/best\"" >> "$CONFIG_FILE"
        fi
    else
        echo -e "${RED}Homebrew not found. Please install Homebrew first: https://brew.sh/${NC}"
        exit 1
    fi
fi

# 4. Installation
ACTUAL_USER="${SUDO_USER:-$USER}"
ACTUAL_HOME=$(eval echo "~$ACTUAL_USER")
INSTALL_DIR="$ACTUAL_HOME/.local/bin"
ensure_writable_dir "$INSTALL_DIR"

echo -e "Downloading yterm to ${GREEN}${INSTALL_DIR}/yterm${NC}"
curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm" || \
curl -ksSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/yterm -o "$INSTALL_DIR/yterm"

chmod +x "$INSTALL_DIR/yterm"

# 5. PATH Setup & Ownership Fix
echo -e "${BLUE}Setting up PATH...${NC}"
# Determine which files to update
TARGET_FILES=()
if [[ "$SHELL" == *"zsh"* ]]; then 
    TARGET_FILES=("$HOME/.zshrc" "$HOME/.zprofile")
elif [[ "$SHELL" == *"bash"* ]]; then 
    TARGET_FILES=("$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile")
fi

PATH_ENTRY="export PATH=\"\$HOME/.local/bin:\$PATH\""

for shell_file in "${TARGET_FILES[@]}"; do
    ensure_writable_file "$shell_file"
    if [ -f "$shell_file" ]; then
        if ! grep -q "Added by yterm" "$shell_file"; then
            echo -e "${BLUE}Adding yterm to ${shell_file}...${NC}"
            echo -e "\n# Added by yterm\n${PATH_ENTRY}" >> "$shell_file"
        fi
    fi
done

# If no files existed, create .zshrc as a default
if [ ${#TARGET_FILES[@]} -eq 0 ] || ([ ! -f "${TARGET_FILES[0]}" ] && [ ! -f "${TARGET_FILES[1]}" ]); then
    DEFAULT_CONF="$HOME/.zshrc"
    if [[ "$SHELL" == *"bash"* ]]; then DEFAULT_CONF="$HOME/.bash_profile"; fi
    ensure_writable_file "$DEFAULT_CONF"
    echo -e "${BLUE}Creating ${DEFAULT_CONF}...${NC}"
    echo -e "# Added by yterm\n${PATH_ENTRY}" > "$DEFAULT_CONF"
fi

echo -e "${GREEN}✅ yterm is ready!${NC}"

# Final Verification
if ! command -v yterm &> /dev/null && [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo -e "${RED}⚠️  ACTION REQUIRED: yterm is installed but not yet in your current PATH.${NC}"
    echo -e "Please run this command now:"
    echo -e "   ${BLUE}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
    echo -e "Then run 'yterm' to start."
else
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
fi
