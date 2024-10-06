#!/bin/bash

# Full MacBook Pro setup for TypeScript development

# Ensure we're in the home directory
cd ~ 

# 1. Install Xcode Command Line Tools
echo "Installing Xcode Command Line Tools..."
xcode-select --install

# 2. Install Homebrew (if not installed)
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 3. Install Git via Homebrew
echo "Installing Git..."
brew install git

# 4. Configure Git (You can add defaults here, or skip configuration)
echo "Configuring Git..."
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# 5. Install asdf version manager
echo "Installing asdf version manager..."
brew install asdf

# Add asdf to shell
echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ~/.zshrc
source ~/.zshrc

# 6. Install Node.js plugin for asdf and Node.js LTS
echo "Installing Node.js plugin for asdf..."
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# Import Node.js release team's OpenPGP keys to verify package integrity
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

# Install latest Node.js LTS version
echo "Installing latest Node.js LTS version..."
asdf install nodejs lts
asdf global nodejs lts

# Verify Node.js installation
echo "Verifying Node.js installation..."
node -v
npm -v

# 7. Install TypeScript globally
echo "Installing TypeScript..."
npm install -g typescript

# 8. Install VSCode (optional)
echo "Do you want to install Visual Studio Code? [Y/n]"
read install_vscode
if [[ $install_vscode == "Y" || $install_vscode == "y" ]]; then
    echo "Installing Visual Studio Code..."
    brew install --cask visual-studio-code
fi

# 9. Install Zsh and Oh My Zsh (optional terminal setup)
echo "Do you want to install and set up Oh My Zsh for an improved terminal experience? [Y/n]"
read install_zsh
if [[ $install_zsh == "Y" || $install_zsh == "y" ]]; then
    echo "Installing Zsh..."
    brew install zsh
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# 10. Install other useful tools (optional)
echo "Do you want to install additional development tools like Yarn, Docker, etc.? [Y/n]"
read install_tools
if [[ $install_tools == "Y" || $install_tools == "y" ]]; then
    echo "Installing Yarn..."
    brew install yarn
    echo "Installing Docker..."
    brew install --cask docker
fi

# 11. Verify the installations
echo "Verifying installations..."
git --version
node -v
npm -v
tsc -v

echo "Setup Complete! Your MacBook Pro is ready for TypeScript development."
