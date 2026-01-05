```markdown
# ❄️ Frost UI Library

A lightweight, modular, and professional UI library for Roblox. This library features a built-in optional Key System with data saving, smooth ripple effects, and multi-window support.

## 🚀 Installation

To use this library in your script, use the `loadstring` function to fetch it from your repository:

```lua
local Library = loadstring(game:HttpGet("[https://raw.githubusercontent.com/relmzey/relmor/refs/heads/main/library.lua](https://raw.githubusercontent.com/relmzey/relmor/refs/heads/main/library.lua)"))()

```

---

## 🛠️ Getting Started

### 1. Initialize the Hub

The `Init` function allows you to configure the Hub settings. You can choose to enable or disable the Key System.

```lua
Library:Init({
    KeySystem = true,                -- Set to false to bypass the key system
    Key = "FROST",                     -- The actual key required
    SaveFile = "frost_key.txt",        -- The filename to save the key to on the user's PC
    Discord = "[https://discord.gg/79N4dhZhmg](https://discord.gg/79N4dhZhmg)" -- Link that gets copied when they click 'Get Key'
})

```

### 2. Create a Window

Windows stack horizontally automatically as you create them.

```lua
local Main = Library:Window("Main Features")
local Misc = Library:Window("Misc Settings")

```

### 3. Adding Elements

You can add Buttons and Toggles to any window.

#### Buttons

```lua
Main:Button("Print Hello", function()
    print("Hello World!")
end)

```

#### Toggles

```lua
Main:Toggle("Enable Noclip", "noclip_flag", false, function(state)
    print("Noclip is now:", state)
end)

```

---

## 🎨 Features

* **Key System with Auto-Save:** If a user enters the correct key, it saves to their workspace. The next time they run the script, the key system is skipped automatically.
* **Ripple Effects:** All buttons feature a modern click animation.
* **Smooth Dragging:** Windows can be dragged anywhere on the screen.
* **Collapsible Windows:** Click the `+` / `-` button on the header to expand or collapse the menu.
* **Service Fetcher:** Uses a metatable-based service provider for optimized performance.

---

## 📝 Example Script

```lua
local Library = loadstring(game:HttpGet("[https://raw.githubusercontent.com/relmzey/relmor/refs/heads/main/library.lua](https://raw.githubusercontent.com/relmzey/relmor/refs/heads/main/library.lua)"))()

Library:Init({
    KeySystem = true,
    Key = "REL",
    SaveFile = "rel_key.txt",
    Discord = "[https://discord.gg/79N4dhZhmg](https://discord.gg/79N4dhZhmg)"
})

local Tab = Library:Window("Player")

Tab:Button("Speed 100", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

Tab:Toggle("Infinite Jump", "inf_jump", false, function(toggled)
    _G.InfJump = toggled
end)

```

---

*Created by Relmzey.*
