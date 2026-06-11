# 📺 yterm

The Terminal YouTube Experience. A high-performance, fuzzy-search YouTube client for your command line.

**Made by BAIZID AL HAMID** *(cause I was bored)*

---

## 🚀 Features
- **Fuzzy Search**: Find exactly what you want with instant filtering powered by `fzf`.
- **Queueing / Multi-select**: Press `TAB` to select multiple videos and watch them in sequence automatically.
- **50+ Results**: Deep search results (50+) so you never miss a video.
- **High Performance**: Uses `yt-dlp` for lightning-fast, high-quality stream extraction.
- **Cross-Platform**: Full support for **Linux**, **macOS**, and **Windows (WSL)**.
- **Smart Playback**: Native support for **Terminology** popups with an automatic fallback to **MPV** for all other terminals.
- **Self-Healing**: Built-in update engine to fix YouTube extraction errors instantly.

---

## 🛠️ Installation

### 1. Requirements
Ensure you have the following installed on your system:
- `yt-dlp` (The engine)
- `fzf` (The search interface)
- `mpv` (The player)
- `curl` (For installation)

### 2. One-Command Install
Run the following command in your terminal:
```bash
curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

---

## ⌨️ Usage

### Basic Search
```bash
yterm "search for something"
```

### Controls in Search Menu
- **Type**: Filter results instantly.
- **TAB**: Select/Deselect multiple videos for your queue.
- **ENTER**: Start playing your selection.
- **CTRL-C**: Exit.

### Maintenance
YouTube updates its site frequently. If search stops working, run:
```bash
yterm --update
```

---

## 🌟 Show your support!
This project was made because I was bored, but I'm glad you're using it! 

**If you find this tool useful, please give the repository a ⭐ Star!** It helps other people find the project and shows your support for independent open-source tools.

---

## ❓ Troubleshooting
- **No results found**: Run `yterm --update` to refresh the extraction engine.
- **Video but no audio**: Check your `mpv` configuration or update `mpv`.
- **Terminology Popup**: This feature only works in the Terminology terminal. On all other terminals (iTerm2, Alacritty, GNOME Terminal, etc.), `mpv` will be used automatically.

---

## ⚖️ License
Open Source - Feel free to use, modify, and distribute!
