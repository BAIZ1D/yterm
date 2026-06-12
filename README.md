# yterm

<div align="center">

```text
  _   _  _____  _____  ____  __  __ 
 | | | ||_   _|| ____||  _ \|  \/  |
 | |_| |  | |  |  _|  | |_) | |\/| |
  \__, |  | |  | |___ |  _ <| |  | |
  |___/   |_|  |_____||_| \_\_|  |_|
```

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&weight=500&size=20&pause=1000&color=3498DB&center=true&vCenter=true&width=600&lines=Search+YouTube+from+the+terminal.;No+ads.+No+tracking.+Just+video.;fzf+%2B+yt-dlp+%2B+mpv.)](https://git.io/typing-svg)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![OS Support](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux%20%7C%20WSL-lightgrey.svg)]()
[![Language](https://img.shields.io/badge/Language-Bash-green.svg)]()

**A minimalist, distraction-free YouTube client for power users.**

</div>

---

## Overview

**yterm v2.6.0** is an interactive, terminal-based YouTube client designed for power users. It provides an intuitive, menu-driven interface to search, build playlists, and watch videos without ads, tracking, or algorithmic suggestions.

### Key Features (v2.6.0)
- **Interactive Playlist Builder**: Search and append tracks across multiple search queries into a single, cohesive playlist.
- **Dynamic UI**: A new, spacious ASCII-based player UI with real-time progress, volume visualization, and track highlighting.
- **Improved Workflow**: Simple, menu-driven navigation replaces clunky CLI argument parsing.
- **Robust Controls**: Seamless `Ctrl+C` termination, volume controls (`+/-`), and track skipping (`q`).

---

## Installation

The installation script automates the resolution of system dependencies, ensures the correct standalone binaries are present, and configures the tool.

### Dependencies
- `yt-dlp`, `fzf`, `mpv`, `ffmpeg`, `socat` (new), `node`

### Linux (Debian / Ubuntu / Kali / Mint)
```bash
sudo apt update && sudo apt install -y curl fzf mpv ffmpeg nodejs socat && /usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

### macOS
```bash
brew install yt-dlp fzf mpv ffmpeg curl node socat && /usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

---

## Usage Guide

### 1. Launching
To begin, start the Playlist Builder menu:
```bash
yterm start
```

### 2. Building a Playlist
- Use the interactive **Playlist Builder** menu to **"Search & Add Tracks"**.
- In the search results, press **`TAB`** to multi-select videos, and **`ENTER`** to add them to your session playlist.
- Select **"View Playlist"** to review your queue.
- Select **"Start Playback"** to initiate the player.

### 3. Playback Controls
While the player is active:
- **Pause/Resume:** Press **`p`**.
- **Skip Track:** Press **`q`** to skip the current track.
- **Volume:** Use **`+`** to increase and **`-`** to decrease volume.
- **Exit:** Press **`CTRL-C`** at any time to kill the playlist and return to the shell.

---

## Troubleshooting

If playback or searches fail, synchronize your tools:
```bash
yterm --update
```

---

## Changelog (v2.6.0)
- **New**: Interactive UI-driven Playlist Builder menu.
- **New**: Multi-search playlist accumulation.
- **New**: Spacious ASCII-based player UI with volume bar.
- **Fix**: Improved playlist termination logic (`Ctrl+C` reliability).
- **Fix**: Resolved ANSI redraw issues causing cursor/line displacement.

---

<div align="center">
  <p>Engineered by <strong>BAIZID AL HAMID</strong></p>
  <p>Licensed under the MIT License</p>
</div>