# Git Plugins for Neovim

This folder contains configuration for git-related plugins used in my Neovim setup. Below is a list of plugins, their purpose, dependencies, and links to their GitHub repositories.

---

## Plugins

### 1. [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
![Gitsigns Preview](https://raw.githubusercontent.com/lewis6991/media/main/gitsigns_actions.gif)
![Gitsigns Preview](https://raw.githubusercontent.com/lewis6991/media/main/gitsigns_blame.gif)
- **Purpose:** Shows git changes (signs) in the sign column, provides hunk actions, blame, and more.
- **Dependencies:**
  - [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) (required by most plugins)
  - [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (for Telescope pickers)
- **Config file:** `git/gitsigns.lua`

### 2. [neogit](https://github.com/NeogitOrg/neogit)
![Neogit Preview](https://private-user-images.githubusercontent.com/38429/481329002-b5ced983-d28e-4234-8586-5b019df7c3a9.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTc1OTAyOTIsIm5iZiI6MTc1NzU4OTk5MiwicGF0aCI6Ii8zODQyOS80ODEzMjkwMDItYjVjZWQ5ODMtZDI4ZS00MjM0LTg1ODYtNWIwMTlkZjdjM2E5LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTA5MTElMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwOTExVDExMjYzMlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTU3MTk1MmFiYTBhMGQ0ZGZmY2ZiY2I2NWRhMDljMzQ4M2Y0YTgyOWFhYTc4ZGI5MmZiOTkxNmI4ZmVkZmVlYTkmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.wOvCGpbalBPl9NaTDTxLNa1MN1Outfhu5XKWhZXHopI)
- **Purpose:** Magit-inspired git interface for Neovim.
- **Dependencies:**
  - [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) (required)
  - [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim) (optional, for diff integration)
  - [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (optional, for fuzzy finding)
  - [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) (optional, for fuzzy finding)
- **Config file:** `git/neogit.lua`

---

## Usage
- All plugin configurations are in this folder for easy management.
- Dependencies should be installed via your plugin manager (e.g., Lazy.nvim).

---

## How to Install
Add these plugins and their dependencies to your Lazy.nvim setup. See each plugin's GitHub page for more details and usage instructions.

---

## Maintainer
Spuxy
