# yterm

```text
  _   _  _____  _____  ____  __  __ 
 | | | ||_   _|| ____||  _ \|  \/  |
 | |_| |  | |  |  _|  | |_) | |\/| |
  \__, |  | |  | |___ |  _ <| |  | |
  |___/   |_|  |_____||_| \_\_|  |_|
```

Honestly, I was just bored, so I made this. It's a tiny tool that lets you search and play YouTube videos directly in your terminal without any of the clutter. No ads, no tracking, just the terminal.

It uses `fzf` for fuzzy finding, `yt-dlp` to grab the video, and `mpv` to play it. 

Made by **BAIZID AL HAMID**.

---

### Installation (The "I'm lazy" version)

These commands will grab all dependencies (including **Node.js** for bypass) and set up the script in one go. 

**Linux (Debian / Ubuntu / Kali / Mint)**
```bash
sudo apt update && sudo apt install -y yt-dlp fzf mpv curl nodejs && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

**macOS**
```bash
brew install yt-dlp fzf mpv curl node && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

**Windows (PowerShell)**
*This installs WSL first if you don't have it. If you do, it enters WSL and sets up yterm.*
```powershell
if (!(Get-Command wsl -ErrorAction SilentlyContinue)) { wsl --install; echo "WSL is now installing. Restart your PC and run this again!" } else { wsl bash -c "sudo apt update && sudo apt install -y yt-dlp fzf mpv curl nodejs && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash" }
```

---

### How to use it (The Quick Guide)

**1. Searching**
- **Linux/Mac**: Just run `yterm "query"`.
- **Windows (PowerShell)**: 
  1. Type `wsl` and press Enter to enter your Linux shell.
  2. Run `yterm "query"`.

**2. Building a Playlist (Queueing)**
Don't just play one video. Use **TAB** to select multiple videos from the list. Hit **ENTER** when you're ready to start the show.

**3. Controls & Skipping**
- **To Skip**: Press **q** on your keyboard to skip to the next video.
- **To Stop Everything**: Press **CTRL-C** in your terminal window.

---

### If things go south (Troubleshooting)

**Search stops working / Fetches hang**
YouTube 2026 uses a "PoToken" to block bots. `yterm` handles this by using **Node.js** and the latest **yt-dlp nightly**. If things hang, run:
```bash
yterm --update
```
This command now updates your system packages (`apt`), the `yt-dlp` engine, and the `yterm` script itself.

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
