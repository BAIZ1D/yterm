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

**yterm** is a command-line utility designed for users who want to search, queue, and watch YouTube videos without leaving the terminal. It strips away the modern web interface, removing advertisements, tracking scripts, and algorithmic suggestions. 

By tying together the most robust open-source media tools, **yterm** delivers a seamless media experience directly from your shell.

### Core Architecture
- **Search and UI:** Powered by `fzf` for instantaneous, fuzzy-finding menu navigation.
- **Extraction:** Utilizes the latest standalone `yt-dlp` to bypass modern anti-bot protections.
- **Playback:** Handled by `mpv` for lightweight, hardware-accelerated video rendering.

---

## Installation

The installation script automates the resolution of system dependencies, ensures the correct standalone binaries are present, and configures the tool for your specific operating system.

### Linux (Debian / Ubuntu / Kali / Mint)
```bash
sudo apt update && sudo apt install -y curl fzf mpv ffmpeg nodejs && /usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

### macOS
```bash
brew install yt-dlp fzf mpv ffmpeg curl node && /usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

### Windows (PowerShell)
This command detects the presence of the Windows Subsystem for Linux (WSL). If absent, it installs WSL. If present, it routes the installation directly into your Linux environment.
```powershell
if (!(Get-Command wsl -ErrorAction SilentlyContinue)) { wsl --install; echo "WSL is now installing. Restart your PC and run this again!" } else { wsl bash -c "sudo apt update && sudo apt install -y curl fzf mpv ffmpeg nodejs && /usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash" }
```

---

## Usage Guide

**yterm** is designed to be intuitive. 

### 1. Searching
Execute the command followed by your search query.
- **Linux / macOS:** 
  ```bash
  yterm "your search query here"
  ```
- **Windows (PowerShell):** 
  ```powershell
  wsl yterm "your search query here"
  ```

### 2. Queueing a Playlist
You are not limited to a single video.
- Navigate the search results using your arrow keys.
- Press **`TAB`** to select multiple videos and build a custom queue.
- Press **`ENTER`** to begin playback.

### 3. Playback Controls
- **Skip Track:** Press **`q`** in the terminal to terminate the current video and advance to the next item in your queue.
- **Terminate Application:** Press **`CTRL-C`** to halt playback and exit the application entirely.

---

## Troubleshooting and Maintenance

### System Updates
YouTube frequently updates its bot-protection mechanisms. If searches begin to fail or hang, you must synchronize your extraction engine. Run the following command to update your system packages and fetch the latest standalone `yt-dlp` binary:
```bash
yterm --update
```

### Windows Audio and Performance
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
YTERM_VERSION=v2.4.2 bash -c "$(/usr/bin/env curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh)"
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