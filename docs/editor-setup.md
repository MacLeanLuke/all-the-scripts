# Editor Setup Guide

This guide covers the editor configurations installed by the setup script, including Visual Studio Code and Neovim.

## 🚀 Visual Studio Code

### Installed Extensions
- ESLint
- Prettier
- TypeScript Next
- GitLens
- Path Intellisense

### Basic Usage
```bash
# Open VS Code
code .

# Open specific file
code file.txt

# Open in current window
code -r file.txt
```

### Key Features
- Integrated terminal
- Git integration
- Debugging tools
- Extensions marketplace
- Settings sync

### Common Shortcuts
- `Cmd + P` - Quick file open
- `Cmd + Shift + P` - Command palette
- `Cmd + B` - Toggle sidebar
- `Cmd + J` - Toggle terminal
- `Cmd + /` - Toggle comment
- `Cmd + D` - Select next occurrence
- `Cmd + Shift + L` - Select all occurrences

## 🛠️ Neovim (nvim)

### Basic Configuration
The setup script creates a basic Neovim configuration with:
- Line numbers
- Syntax highlighting
- Basic key mappings
- Tab settings
- Search settings

### Basic Usage
```bash
# Open Neovim (note: command is 'nvim', not 'neovim')
nvim file.txt

# Open with specific line
nvim +10 file.txt

# Open multiple files
nvim file1.txt file2.txt
```

### Getting Started
1. Open Neovim: `nvim`
2. Press `i` to enter insert mode
3. Type your text
4. Press `Esc` to exit insert mode
5. Type `:w` to save
6. Type `:q` to quit
7. Or type `:wq` to save and quit

### Common Commands
- `i` - Enter insert mode
- `Esc` - Exit insert mode
- `:w` - Save file
- `:q` - Quit
- `:wq` - Save and quit
- `:q!` - Force quit without saving
- `:e file` - Open file
- `:sp file` - Split window horizontally
- `:vsp file` - Split window vertically

### Navigation
- `h`, `j`, `k`, `l` - Move left, down, up, right
- `w` - Move to next word
- `b` - Move to previous word
- `gg` - Go to start of file
- `G` - Go to end of file
- `Ctrl + f` - Page down
- `Ctrl + b` - Page up

### Editing
- `x` - Delete character
- `dd` - Delete line
- `yy` - Yank (copy) line
- `p` - Paste
- `u` - Undo
- `Ctrl + r` - Redo
- `>>` - Indent line
- `<<` - Unindent line

## 🔍 Editor Integration

### Git Integration
Both editors support Git operations:
- View changes
- Stage/unstage files
- Commit changes
- View history
- Branch management

### Terminal Integration
- VS Code: Integrated terminal
- Neovim: Terminal mode (`:terminal`)

### Language Support
- TypeScript/JavaScript
- Python
- Go
- Markdown
- JSON
- YAML
- And many more

## 📚 Additional Resources

- [VS Code Documentation](https://code.visualstudio.com/docs)
- [Neovim Documentation](https://neovim.io/doc/user/)
- [VS Code Keyboard Shortcuts](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf)
- [Vim Cheat Sheet](https://vim.rtorr.com/) 