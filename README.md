# yterm

```text
  _   _  _____  _____  ____  __  __ 
 | | | ||_   _|| ____||  _ \|  \/  |
 | |_| |  | |  |  _|  | |_) | |\/| |
  \__, |  | |  | |___ |  _ <| |  | |
  |___/   |_|  |_____||_| \_\_|  |_|
```

Honestly, I was just bored, so I made this. It's a tiny tool that lets you search and play YouTube videos directly in your terminal without any of the clutter. No ads, no tracking, just the terminal.

It uses `fzf` for fuzzy finding, the latest standalone `yt-dlp` to grab the video, and `mpv` to play it. 

Made by **BAIZID AL HAMID**.

---

### Installation (The "I'm lazy" version)

These commands will handle everything: uninstalling outdated system tools, installing the latest standalone engine, grabbing Node.js for security bypasses, and setting up the script.

**Linux (Debian / Ubuntu / Kali / Mint)**
```bash
sudo apt update && sudo apt install -y curl fzf mpv ffmpeg nodejs && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

**macOS**
```bash
brew install yt-dlp fzf mpv ffmpeg curl node && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

**Windows (PowerShell)**
*This installs WSL first if you don't have it. If you do, it enters WSL and sets up yterm.*
```powershell
if (!(Get-Command wsl -ErrorAction SilentlyContinue)) { wsl --install; echo "WSL is now installing. Restart your PC and run this again!" } else { wsl bash -c "sudo apt update && sudo apt install -y curl fzf mpv ffmpeg nodejs && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash" }
```

---

### How to use it (The Quick Guide)

**1. Searching**
- **Linux/Mac**: Just run `yterm "query"`.
- **Windows (PowerShell)**: 
  1. Type `wsl` and press Enter to enter your Linux shell.
  2. Run `yterm "query"`.

**2. Building a Playlist (Queueing)**
Don't just play one video. Use **TAB** to select multiple videos from the list. Each one you hit TAB on will be added to your temporary playlist. Hit **ENTER** when you're ready to start the show.

**3. Controls & Skipping**
- **To Skip**: Press **q** on your keyboard to skip to the next video.
- **To Stop Everything**: Press **CTRL-C** in your terminal window.

---

### If things go south (Troubleshooting)

**Windows (WSL) - Audio & Performance**
WSL is great, but its not perfect. You might experience:
- **Audio Bugs**: Crackling or delayed audio. This is usually a WSL/PulseAudio sync issue.
- **Terminal Jitters**: The interface might feel "laggy" compared to native Linux/Mac.
- **Fix**: Ensure your Windows is up to date and you are using **WSL 2**. If audio is still broken, try running `yterm --update` to refresh dependencies.


**Search stops working / Fetches hang**
YouTube 2026 uses a "PoToken" to block bots. `yterm` handles this by using **Node.js** and the latest **yt-dlp standalone binary**. If things hang, run:
```bash
yterm --update
```
This command is nuclear. It updates your system packages (`apt`), swaps your engine for the latest standalone version, and updates the `yterm` script itself.

**SSL / Certificate errors**
If your terminal complains about certificates, add `-k` to the curl command:
```bash
curl -ksSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

---

### Support

If you end up using this while you're bored too, throw a star on the repo. It's nice to know people are actually using it.

---

License: Open Source. Do whatever you want with it.

<!-- 
Keywords for search engines:
youtube terminal client, cli youtube player, bash youtube search, yterm, baizid al hamid, 
terminal video player, fzf youtube, linux youtube tool, macos youtube cli, wsl youtube player
-->

---

### 📦 Install Specific Version
If you need to install a specific version of yterm, you can use the `YTERM_VERSION` environment variable:

```bash
YTERM_VERSION=v2.4.2 bash -c "$(curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh)"
```
