<div align="center">

# yterm

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

**yterm** is a fast, minimalist, and interactive terminal-based YouTube client designed for power users. This CLI tool allows you to search YouTube, build custom playlists, and watch videos distraction-free—without ads, tracking, or algorithmic suggestions.

*yterm was born from a simple idea: a fast, distraction-free YouTube client, built because I was bored and wanted a better way to watch.*

By tying together the most robust open-source media tools, **yterm** delivers a seamless media experience directly from your shell.

### Core Architecture
- **Search and UI:** Powered by `fzf` for interactive, menu-driven navigation and playlist building.
- **Extraction:** Utilizes the latest standalone `yt-dlp` to bypass modern anti-bot protections.
- **Playback:** Handled by `mpv` for lightweight, hardware-accelerated video rendering.

---

## Installation

The installation script automates the resolution of system dependencies, ensures the correct standalone binaries are present, and configures the tool.

### Dependencies
- `yt-dlp`, `fzf`, `mpv`, `ffmpeg`, `socat`, `node`

### Linux (Debian / Ubuntu / Kali / Mint)
```bash
sudo apt update && sudo apt install -y curl fzf mpv ffmpeg nodejs socat && /usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

### macOS
```bash
brew install yt-dlp fzf mpv ffmpeg curl node socat && /usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

### Windows (PowerShell / WSL)
This command detects the presence of the Windows Subsystem for Linux (WSL). If absent, it installs WSL. If present, it routes the installation directly into your Linux environment.
```powershell
if (!(Get-Command wsl -ErrorAction SilentlyContinue)) { wsl --install; echo "WSL is now installing. Restart your PC and run this again!" } else { wsl bash -c "sudo apt update && sudo apt install -y curl fzf mpv ffmpeg nodejs socat && /usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash" }
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

### Windows Audio and Performance (WSL)
If utilizing WSL, you may encounter audio desynchronization or UI latency.
- Ensure you are operating on **WSL 2**.
- Validate your Windows host is fully updated to ensure PulseAudio compatibility.
- Execute `yterm --update` to guarantee the latest media libraries are present in your subsystem.

### Certificate Errors
In environments with strict proxy filtering or outdated certificates, bypass SSL verification warnings by appending the insecure flag:
```bash
/usr/bin/env curl -ksSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

---

## Version Management

### Installing a Specific Version
To pin your installation to a known, stable release, utilize the `YTERM_VERSION` variable:
```bash
YTERM_VERSION=v2.6.0 bash -c "$(/usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh)"
```

### Uninstallation
To cleanly remove the application binary and scrub the `PATH` entries from your shell configuration files:
```bash
yterm --uninstall
```
*Alternatively, run the uninstaller directly:*
```bash
bash -c "$(/usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/uninstall_yterm.sh)"
```

---

<div align="center">
  <p>Engineered by <strong>BAIZID AL HAMID</strong></p>
  <p>Licensed under the MIT License</p>
</div>
