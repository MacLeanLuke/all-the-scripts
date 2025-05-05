# Version Management Guide

This guide covers using asdf version manager to handle multiple versions of programming languages and tools.

## 🚀 Getting Started

asdf is installed and configured by the setup script. It manages versions of:
- Node.js
- Python
- Go
- And many other tools

## 🔍 Basic Commands

### Listing Available Tools
```bash
asdf plugin list all  # List all available plugins
asdf plugin list     # List installed plugins
```

### Installing Tools
```bash
# Install a plugin
asdf plugin add nodejs
asdf plugin add python
asdf plugin add golang

# Install a specific version
asdf install nodejs latest
asdf install python 3.11.0
asdf install golang 1.21.0

# Install the latest version
asdf install nodejs latest
```

### Managing Versions
```bash
# List installed versions
asdf list nodejs
asdf list python
asdf list golang

# Set global version
asdf set nodejs latest
asdf set python 3.11.0
asdf set golang 1.21.0

# Set local version (for current directory)
asdf set -p nodejs 18.0.0
```

## 🛠️ Advanced Usage

### Using Multiple Versions
You can have different versions for different projects:
```bash
# In project A
asdf set -p nodejs 18.0.0

# In project B
asdf set -p nodejs 20.0.0
```

### Updating Tools
```bash
# Update a plugin
asdf plugin update nodejs

# Update all plugins
asdf plugin update --all
```

### Removing Versions
```bash
# Remove a specific version
asdf uninstall nodejs 18.0.0

# Remove a plugin
asdf plugin remove nodejs
```

## 📦 Common Tools Setup

### Node.js
```bash
# Install Node.js plugin
asdf plugin add nodejs

# Import Node.js release team's OpenPGP keys
bash $(brew --prefix asdf)/plugins/nodejs/bin/import-release-team-keyring

# Install and set Node.js
asdf install nodejs latest
asdf set nodejs latest
```

### Python
```bash
# Install Python plugin
asdf plugin add python

# Install and set Python
asdf install python latest
asdf set python latest
```

### Go
```bash
# Install Go plugin
asdf plugin add golang

# Install and set Go
asdf install golang latest
asdf set golang latest
```

## 📚 Additional Resources

- [asdf Documentation](https://asdf-vm.com/guide/getting-started.html)
- [Node.js Plugin](https://github.com/asdf-vm/asdf-nodejs)
- [Python Plugin](https://github.com/asdf-vm/asdf-python)
- [Go Plugin](https://github.com/asdf-vm/asdf-golang) 