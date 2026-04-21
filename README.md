# ⚡ zy: The Shell You've Been Waiting For

**Stop configuring. Start creating.** 

`zy` isn't just another shell. It's a love letter to the terminal. It’s for the developer who is tired of juggling 20 different plugins, tired of slow startups, and tired of "fragmented terminal fatigue." 

> **Note**: This is the official binary distribution repository. The core engine is a proprietary labor of love.

---

## 🧠 The "Why" Behind Zy

We all love the familiarity of **ZSH**, the raw data power of **Nushell**, and the rock-solid reliability of **POSIX**. But usually, you have to choose: do you want modern data pipelines, or do you want to keep your muscle memory?

**`zy` is the first shell that doesn't make you choose.**

It gives you the structured data power of Nushell (like `open`, `where`, and `get`) but keeps the **POSIX-compliant syntax** you already know (like `&&`, `||`, and `>`). It's a single, blazing-fast C binary that gives you everything you’ve been installing separately: smart jumping, fuzzy finding, data pipelines, and beautiful themes. It's all built into the core.

---

## 💎 What You'll Fall In Love With

### ▌ The HUD: Your New Command Center
Forget memorizing flags. `zy` brings a "Heads-Up Display" to your terminal. 
*   **Instant Flow**: Tap `Alt+C` or type `zi` and watch your directories appear in a fuzzy-searchable list.
*   **Visual Intelligence**: Beautiful, truecolor badges tell you exactly where you are, what branch you're on, and even how much battery your laptop has left, without you even asking.

### ▌ Intelligent Input (The Mind Reader)
`zy` feels proactive. It predicts your next move so you can stay in the flow.
*   **Autosuggestions**: Real-time "ghost text" suggests commands based on your history as you type. Just hit `Right Arrow` to accept.
*   **Interactive Popups**: Hit `Ctrl+R` for history or `Tab` for completion to open a sleek, fuzzy-searchable menu. No more scrolling through hundreds of lines of text.

### ▌ Enterprise-Grade Security
`zy` is the only modern shell with a built-in **Audit & Policy Engine**, backed by a high-performance **SQLite** storage engine.
*   **Immutable Logging**: Every command and system interaction is logged to an encrypted SQLite database. No more corrupted history files.
*   **Policy Enforcement**: Define granular rules to restrict or alert on dangerous commands (e.g., `rm -rf /` or unauthorized network calls).
*   **Session Forensics**: Perfect for developers in regulated industries or those who want a perfect record of their work.

### ▌ Zero-Latency UI
Most shells get sluggish as you add plugins. Not this one. `zy` is pure C, talking directly to your terminal. 
*   **Fluid Feel**: Micro-animations that make the terminal feel alive.
*   **18+ Themes**: From the neon vibes of `cyberpunk` to the calm of `kanagawa`.

### ▌ Make It Yours (Instantly)
Don't like the defaults? You don't need to learn a complex config language. Just type `customize` to open our interactive TUI. 
*   **Live Preview**: Change your theme, prompt style, or git segments and see the results instantly.
*   **No Restart Needed**: Your changes apply the moment you hit save.

---

## 🛠️ Feature Highlights

`zy` comes with 300+ built-in commands. You can finally stop installing separate tools for everything.

### 📊 The Data Pipeline
Parsing text with `awk` and `sed` is a headache. `zy` handles data like a pro:
*   **Smart Loading**: `open data.csv` or `open config.json` turns files into interactive tables.
*   **Simple Filters**: `where size > 50mb | sort-by modified` — it just makes sense.
*   **Format Shifting**: Move between JSON, YAML, CSV, and TOML with one command.

### ⚡ Scripting That Doesn't Suck
Write scripts that actually look like modern code:
*   **Safety First**: Real `try/catch` blocks and `match` expressions.
*   **Parallel Power**: `par-each` lets you use all your CPU cores for heavy tasks.
*   **Clean Code**: Named parameters, local variables, and constants.

### 🔬 Integrated Developer Tools
A "Batteries-Included" experience for the modern engineer.
- **`http`**: A lightweight built-in client for `GET/POST` requests.
- **`fs-watch`**: Native file system watching (run commands on save).
- **`cheat`**: 50+ built-in cheatsheets available via `Ctrl+H`.
- **`task`**: A built-in task runner (like `make` or `just`) with dependency tracking.
- **`sparkline`**: Render data visualizations directly in your terminal.

## 🚀 Installation

Download the latest `.deb` package from the [Releases](https://github.com/iskandarputra/zyshell/releases) section.

```bash
sudo dpkg -i zy_*.deb
sudo apt-get install -f
```

To make it your default shell:
```bash
chsh -s /usr/bin/zy
```

## 📜 Acknowledgments & Inspiration

`zy` is a tribute to the vibrant open-source ecosystem. While our core engine is a proprietary implementation, we stand on the shoulders of giants. We have meticulously referenced the interface standards, architectural patterns, and user experience paradigms pioneered by the following projects:

- **[Nushell](https://github.com/nushell/nushell)** (MIT) — For the data-first philosophy.
- **[ZSH](https://github.com/zsh-users/zsh)** (MIT) — For industry-standard shell foundations.
- **[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)** (MIT) — For community-driven aesthetic standards.
- **[z-lua](https://github.com/skywind3000/z.lua)** / **[zoxide](https://github.com/ajeetdsouza/zoxide)** (MIT) — For revolutionary navigation algorithms.
- **[fzf](https://github.com/junegunn/fzf)** (MIT) — For the gold standard in fuzzy-finding UX.

---
© 2026 Iskandar Putra. All rights reserved. All mentioned trademarks belong to their respective owners.
