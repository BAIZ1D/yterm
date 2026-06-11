# 📺 yterm

Honestly, I was just bored, so I made this. It's a tiny tool that lets you search and play YouTube videos directly in your terminal without any of the clutter.

It uses `fzf` for fuzzy finding, `yt-dlp` to grab the video, and `mpv` to play it. Simple as that.

---

## 🛠️ Requirements & Setup

Before you install, make sure you have the basics for your system. The install command will try to grab these for you, but here is what you need:

| Platform | Required Tools | Install Command |
| :--- | :--- | :--- |
| **Linux (Debian/Ubuntu)** | `yt-dlp`, `fzf`, `mpv`, `curl` | `sudo apt install yt-dlp fzf mpv curl` |
| **macOS** | `yt-dlp`, `fzf`, `mpv`, `curl` | `brew install yt-dlp fzf mpv curl` |
| **Windows** | **WSL (Ubuntu)** | `sudo apt install yt-dlp fzf mpv curl` |

---

## 🚀 One-Command Install (Copy & Paste)

### 🐧 Linux (Debian / Ubuntu / Mint / Kali)
```bash
sudo apt update && sudo apt install -y curl && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

### 🍎 macOS
*Requires [Homebrew](https://brew.sh/)*
```bash
curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash
```

### 🪟 Windows (PowerShell)
*This will install WSL first if you don't have it. If you do, it just runs the setup.*
```powershell
if (!(Get-Command wsl -ErrorAction SilentlyContinue)) { wsl --install; echo "Please restart your PC and run this again!" } else { wsl bash -c "sudo apt update && sudo apt install -y curl && curl -sSL https://raw.githubusercontent.com/BAIZ1D/yterm/main/install_yterm.sh | bash" }
```

---

## ⌨️ How to use it

Search for whatever you want:
```bash
yterm "never gonna give you up"
```

**Controls in search:**
- **Type**: To filter the 50 results.
- **TAB**: To select multiple videos (build a queue!).
- **ENTER**: Start playing.
- **CTRL-C**: Stop current video / Exit.

---

## 🌟 Support
If you actually end up using this, **throw a ⭐ on the repo**. It’s the only way I know people aren’t just looking at my bored experiments.

## 🛠️ Maintenance
YouTube likes to break things. If search stops working, just run:
```bash
yterm --update
```

**Made by BAIZID AL HAMID**
