# 🔴 Mute Notifier – Visual Microphone Mute Indicator for macOS

**Mute Notifier** is a lightweight macOS app written in **Swift** that shows a **small red square at the bottom of each screen** when your microphone is **muted** — giving you a clear, visual reminder so you never talk while muted again. Simple, unobtrusive, and built for multi-display setups.

---

I'm using a Logitech mouse that lets me mute the microphone through a custom action button configured in the Logitech software.  
However, when I mute the mic, a small red square appears — but only on one screen. As a result, I sometimes kept talking while still muted without noticing it.

To solve this, I decided to create a simple solution that would remain clearly visible no matter which screen I'm looking at.

---

## ✨ Features

- 🔇 **Automatic detection** of microphone mute/unmute state  
- 🟥 **Red square indicator** shown on all connected screens when muted, on both bottom corners 
- 🖥️ **Multi-display** support  
- ⚙️ Runs quietly without any visible icon in status bar nor dock, totally in background
- 💡 Lightweight, **no external dependencies**

---

## 🧩 Screenshots

![MacOs desktop view, showing the two red mute indicators](screenshot.png "Screenshot")

---

## 🚀 Installation

### Option 1 — Download the release
1. Go to the **[Releases](https://github.com/Resousse/MacMuteNotifier/releases)** page.  
2. Download the latest `.dmg`   
3. Drag **Mute Notifier** into your **Applications** folder.  
4. Launch the app

### Option 2 — Build from source
1. Clone the repository:
   ```bash
   git clone https://github.com/Resousse/MacMuteNotifier.git
   ```
2. Open the project in Xcode
    ```bash
   cd MacMuteNotifier
   open Mute Notifier.xcodeproj
   ```
3. Build & Run (⌘ + R)

---

## ⚙️ Configuration

Nothing is launched in startup by default, if you want to do it, just do :
- Open "System Preferences"
- Go in "Login Items & Extensions"
- Click on + sign on the "Add a login item" section
- Look for "Mute Notifier" in your Applications folder

---

## 📄 License

Distributed under the **Apache 2.0**.  
See [LICENSE](./LICENSE) for details.