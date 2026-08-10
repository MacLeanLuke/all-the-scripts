# All The Scripts

> ### ⚠️ Read before running
>
> `full-setup.sh` **replaces your `~/.zshrc` entirely.** It does not merge with
> your existing configuration — it overwrites it. The script now takes a
> timestamped backup first (`~/.zshrc.backup.<timestamp>`), but you should still
> read it before running it.
>
> It also installs system software (Xcode Command Line Tools, Homebrew, asdf,
> Oh My Zsh and a set of CLI tools), writes to your home directory, and is
> **macOS-only** — it assumes Homebrew at `/opt/homebrew`, which is the Apple
> Silicon path.
>
> **Known issue:** the script appends Homebrew and asdf initialization to
> `~/.zshrc` early on, then overwrites the file later in the same run, so those
> lines do not survive. After running it you may need to re-add
> `eval "$(/opt/homebrew/bin/brew shellenv)"` and the asdf source line yourself.
> See [issue #1](https://github.com/MacLeanLuke/all-the-scripts/issues/1).

A collection of useful scripts for development environment setup and automation. These scripts are designed to make your development workflow more efficient and consistent.

## 📦 Available Scripts

### `full-setup.sh`
A comprehensive setup script for MacBook Pro development environments, particularly optimized for TypeScript development.

**Features:**
- Installs Xcode Command Line Tools
- Sets up Homebrew package manager
- Configures Git
- Installs asdf version manager
- Sets up Node.js and npm
- Installs TypeScript and related tools
- Sets up a powerful terminal environment with:
  - Oh My Zsh with Powerlevel10k theme
  - Enhanced terminal tools (bat, eza, fzf, ripgrep, zoxide)
  - Zsh plugins (autosuggestions, syntax highlighting, completions)
  - Tmux configuration
  - Neovim setup
- Optional installations for:
  - Visual Studio Code with essential extensions
  - Additional development tools (Docker, Postman, etc.)
  - Additional programming languages (Python, Go)

## 🚀 Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/all-the-scripts.git
cd all-the-scripts
```

2. Make the scripts executable:
```bash
chmod +x *.sh
```

## 💻 Usage

### Full Development Environment Setup
To set up a complete development environment on your MacBook Pro:

```bash
./full-setup.sh
```

The script will guide you through the installation process with interactive prompts for optional components.

## 📚 Documentation

For detailed guides on using the installed tools, see:

- [Terminal Environment Guide](docs/terminal-guide.md)
- [Version Management Guide](docs/version-management.md)
- [Development Tools Guide](docs/dev-tools.md)
- [Editor Setup Guide](docs/editor-setup.md)

## 🔧 Requirements

- macOS (tested on MacBook Pro)
- Internet connection
- Administrative privileges

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

Your Name - [@yourusername](https://github.com/yourusername)

## 🙏 Acknowledgments

- Thanks to all contributors who have helped improve these scripts
- Inspired by the need for consistent development environments
