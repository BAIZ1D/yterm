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

These commands will try to grab all the dependencies and set up the script in one go. If things fail, check the "If things go south" section below.

**Linux (Debian / Ubuntu / Kali / Mint)**
```bash
sudo apt update && sudo apt install -y yt-dlp fzf mpv curl && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

**macOS**
```bash
brew install yt-dlp fzf mpv curl && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

**Windows (PowerShell)**
```powershell
if (!(Get-Command wsl -ErrorAction SilentlyContinue)) { wsl --install; echo "WSL is now installing. Restart your PC and run this again!" } else { wsl bash -c "sudo apt update && sudo apt install -y yt-dlp fzf mpv curl && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash" }
```

---

### How to use it (The Quick Guide)

**1. Searching**
Just run the command followed by your search query. 
*(Windows users: If you're in PowerShell/CMD, use `wsl yterm`. Linux/Mac/WSL users: just `yterm`)*

```bash
# Linux / Mac / WSL Terminal
yterm "lofi hip hop"

# Windows PowerShell / CMD
wsl yterm "lofi hip hop"
```
Once the list pops up, just start typing to filter the results. It's instant.

**2. Building a Playlist (Queueing)**
Don't just play one video. Use **TAB** to select multiple videos from the list. Each one you hit TAB on will be added to your temporary playlist. Hit **ENTER** when you're ready to start the show.

**3. Controls & Skipping**
- **To Skip**: If you're using MPV (standard), just hit **q** on your keyboard. It will kill the current video and immediately start the next one in your queue. If you're in Terminology, just close the popup window.
- **To Stop Everything**: If you want to bail on the whole playlist, hit **CTRL-C** in your terminal window. It will kill the entire session.

---

### If things go south (Troubleshooting)

**SSL / Certificate errors**
If your terminal starts complaining about "SSL certificate problem" or "expired certificates," it's probably because your system clock is wrong or your certs are ancient. You can force it through by adding `-k` to the curl command:
```bash
curl -ksSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

**Search stops working**
YouTube loves to break things on purpose. If the search stops giving you results, it's usually because the extraction engine needs an update. Fix it with:
```bash
yterm --update
```

**Black screen or no sound**
Make sure `mpv` is actually working on your system. If you're on a server without a screen, obviously this won't show you video.

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
