# Terminal Environment Guide

This guide covers the enhanced terminal environment set up by the `full-setup.sh` script.

## 🚀 Getting Started

After running the setup script, restart your terminal to see all the changes. You'll notice:
- A colorful, informative prompt (Powerlevel10k)
- Syntax highlighting for commands
- Command suggestions as you type
- Enhanced directory listings with icons

## 🔍 Basic Navigation

### Directory Navigation
- `z` - Smart directory jumping
  ```bash
  z doc  # jumps to Documents
  z pro  # jumps to Projects
  ```
- `eza` - Enhanced `ls` with icons
  ```bash
  ll     # detailed listing with icons
  la     # show all files including hidden
  lt     # show directory tree
  ```

### File Operations
- `bat` - Enhanced file viewing
  ```bash
  bat README.md  # view file with syntax highlighting
  ```

### Search
- `fzf` - Fuzzy file finder
  ```bash
  Ctrl+T  # search files
  Ctrl+R  # search command history
  ```
- `rg` (ripgrep) - Fast content search
  ```bash
  rg "search term"  # search in current directory
  rg "term" --type=md  # search in markdown files
  ```

## 🛠️ Advanced Features

### Tmux
- Start a new session: `tmux`
- Split panes:
  - `Ctrl+b %` - Split vertically
  - `Ctrl+b "` - Split horizontally
- Navigate panes: `Ctrl+b` + arrow keys
- Detach: `Ctrl+b d`
- List sessions: `tmux ls`
- Attach to session: `tmux attach`

### Zsh Features
- Command suggestions appear as you type
- Syntax highlighting shows valid commands
- Tab completion for:
  - Commands
  - Files
  - Directories
  - Git operations

### Neovim
Basic Vim commands still work:
- `i` - Enter insert mode
- `Esc` - Exit insert mode
- `:w` - Save file
- `:q` - Quit
- `:wq` - Save and quit
- `:q!` - Force quit without saving

## 🎨 Customization

### Powerlevel10k
- Run `p10k configure` to customize your prompt
- Choose from different styles and information displays

### Zsh Configuration
Edit `~/.zshrc` to customize:
- Aliases
- Environment variables
- Plugin settings

## 📚 Additional Resources

- [Oh My Zsh Documentation](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [Powerlevel10k Documentation](https://github.com/romkatv/powerlevel10k)
- [Tmux Documentation](https://github.com/tmux/tmux/wiki)
- [Neovim Documentation](https://neovim.io/doc/user/) 