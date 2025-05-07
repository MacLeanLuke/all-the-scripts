#!/bin/bash

# Full MacBook Pro setup for TypeScript development

# Exit on error
set -e

# Function to print colored output
print_message() {
    local color=$1
    local message=$2
    case $color in
        "green") echo -e "\033[0;32m$message\033[0m" ;;
        "red") echo -e "\033[0;31m$message\033[0m" ;;
        "yellow") echo -e "\033[0;33m$message\033[0m" ;;
        *) echo "$message" ;;
    esac
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to check if we're in zsh
is_zsh() {
    [ -n "$ZSH_VERSION" ]
}

# Function to run commands in zsh
run_in_zsh() {
    if ! is_zsh; then
        print_message "yellow" "Switching to zsh for Oh My Zsh installation..."
        # Create a temporary script with the Zsh command(s)
        local temp_script
        temp_script=$(mktemp)
        echo "#!/bin/zsh" > "$temp_script"
        echo "source ~/.zshrc" >> "$temp_script"  # Load Zsh environment
        echo "$*" >> "$temp_script"              # Append the actual command
        chmod +x "$temp_script"
        # Run the script using Zsh directly (NOT via zsh -c)
        /bin/zsh "$temp_script"
        rm "$temp_script"
    else
        source ~/.zshrc
        eval "$*"
    fi
}

# Function to install zsh plugin
install_zsh_plugin() {
    local plugin_name=$1
    local plugin_url=$2
    local plugin_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin_name"
    local parent_dir="$(dirname "$plugin_dir")"
    
    # Ensure parent directory exists
    mkdir -p "$parent_dir"
    
    if [ ! -d "$plugin_dir" ]; then
        print_message "green" "Installing $plugin_name..."
        if cd "$parent_dir" && git clone "$plugin_url" "$plugin_name"; then
            print_message "green" "$plugin_name installed successfully."
        else
            print_message "red" "Failed to install $plugin_name."
        fi
    else
        print_message "yellow" "$plugin_name directory exists. Cleaning and reinstalling..."
        rm -rf "$plugin_dir"
        if cd "$parent_dir" && git clone "$plugin_url" "$plugin_name"; then
            print_message "green" "$plugin_name reinstalled successfully."
        else
            print_message "red" "Failed to reinstall $plugin_name."
        fi
    fi
}

# Ensure we're in the home directory
cd ~ 

# 1. Install Xcode Command Line Tools
if xcode-select -p &> /dev/null; then
    print_message "yellow" "Xcode Command Line Tools already installed. Skipping."
else
    print_message "green" "Installing Xcode Command Line Tools..."
    xcode-select --install
fi

# 2. Install Homebrew (if not installed)
if ! command_exists brew; then
    print_message "green" "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    print_message "yellow" "Homebrew already installed. Skipping."
    # Ensure Homebrew is in PATH
    if ! echo $PATH | grep -q "/opt/homebrew/bin"; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# 3. Install Git via Homebrew
if ! command_exists git; then
    print_message "green" "Installing Git..."
    brew install git
else
    print_message "yellow" "Git already installed. Skipping."
fi

# 4. Configure Git (only if not already configured)
if [ -z "$(git config --global user.name)" ] || [ -z "$(git config --global user.email)" ]; then
    print_message "green" "Configuring Git..."
    read -p "Enter your Git name: " git_name
    read -p "Enter your Git email: " git_email
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    git config --global pull.rebase true
    git config --global core.editor "code --wait"
else
    print_message "yellow" "Git already configured. Skipping configuration."
fi

# 5. Install asdf version manager
if ! command_exists asdf; then
    print_message "green" "Installing asdf version manager..."
    brew install asdf
else
    print_message "yellow" "asdf already installed. Skipping."
fi

# Add asdf to shell if not already present
if ! grep -q 'asdf.sh' ~/.zshrc; then
    echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ~/.zshrc
    source ~/.zshrc
fi

# 6. Install Node.js plugin for asdf and Node.js LTS
# Source asdf from Homebrew location
if [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
else
    print_message "red" "Could not find asdf.sh. Please ensure asdf is properly installed."
    exit 1
fi

if ! asdf plugin list | grep -q nodejs; then
    print_message "green" "Installing Node.js plugin for asdf..."
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    
    # Import Node.js release team's OpenPGP keys after plugin is installed
    print_message "green" "Importing Node.js release team's OpenPGP keys..."
    # Ensure the directory exists before running the import
    if [ -f "$(brew --prefix asdf)/plugins/nodejs/bin/import-release-team-keyring" ]; then
        bash "$(brew --prefix asdf)/plugins/nodejs/bin/import-release-team-keyring"
    else
        print_message "yellow" "Keyring import script not found. Installing Node.js may fail if keys are not present."
    fi
else
    print_message "yellow" "Node.js asdf plugin already installed. Skipping."
fi

if ! asdf list nodejs | grep -q latest; then
    print_message "green" "Installing latest Node.js LTS version..."
    asdf install nodejs latest
    # Set the global version using the correct command
    asdf set nodejs latest
else
    print_message "yellow" "Latest Node.js LTS already installed via asdf. Skipping."
fi

# Ensure npm is properly installed
print_message "green" "Ensuring npm is installed..."
npm install -g npm

# Install essential npm packages
for pkg in typescript ts-node nodemon eslint prettier yarn pnpm; do
    if npm list -g --depth=0 | grep -q $pkg@; then
        print_message "yellow" "$pkg already installed globally. Skipping."
    else
        print_message "green" "Installing $pkg globally..."
        npm install -g $pkg
    fi
done

# 7. Install VSCode (optional)
print_message "yellow" "Do you want to install Visual Studio Code? [Y/n]"
read install_vscode
if [[ $install_vscode == "Y" || $install_vscode == "y" ]]; then
    if ! command_exists code; then
        print_message "green" "Installing Visual Studio Code..."
        brew install --cask visual-studio-code
    else
        print_message "yellow" "Visual Studio Code already installed. Skipping."
    fi
    # Install essential VSCode extensions
    for ext in dbaeumer.vscode-eslint esbenp.prettier-vscode ms-vscode.vscode-typescript-next eamodio.gitlens christian-kohler.path-intellisense; do
        if code --list-extensions | grep -q $ext; then
            print_message "yellow" "VSCode extension $ext already installed. Skipping."
        else
            print_message "green" "Installing VSCode extension $ext..."
            code --install-extension $ext
        fi
    done
fi

# 8. Install Terminal Development Environment
print_message "yellow" "Do you want to set up an enhanced terminal development environment? [Y/n]"
read install_terminal
if [[ $install_terminal == "Y" || $install_terminal == "y" ]]; then
    # Install essential terminal tools
    print_message "green" "Installing terminal utilities..."
    for tool in bat eza fzf ripgrep zoxide tmux neovim; do
        if ! command_exists $tool; then
            print_message "green" "Installing $tool..."
            brew install $tool
        else
            print_message "yellow" "$tool already installed. Skipping."
        fi
    done

    # Install and configure Zsh
    if ! command_exists zsh; then
        print_message "green" "Installing Zsh..."
        brew install zsh
    else
        print_message "yellow" "Zsh already installed. Skipping."
    fi

    # Install Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        print_message "green" "Installing Oh My Zsh..."
        run_in_zsh 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
    else
        print_message "yellow" "Oh My Zsh already installed. Skipping."
    fi

    # Install Starship prompt
    if ! command_exists starship; then
        print_message "green" "Installing Starship prompt..."
        brew install starship
    else
        print_message "yellow" "Starship already installed. Skipping."
    fi

    # Install powerlevel10k theme
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        print_message "green" "Installing powerlevel10k theme..."
        run_in_zsh 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k'
    else
        print_message "yellow" "powerlevel10k theme already installed. Skipping."
    fi

    # Install Nerd Font
    print_message "green" "Installing Nerd Font..."
    if ! brew list --cask | grep -q font-hack-nerd-font; then
        print_message "green" "Installing Hack Nerd Font..."
        brew install --cask font-hack-nerd-font
    else
        print_message "yellow" "Hack Nerd Font already installed. Skipping."
    fi

    # Install Zsh plugins
    print_message "green" "Installing Zsh plugins..."
    
    # Install plugins using the new function
    install_zsh_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git"
    install_zsh_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
    install_zsh_plugin "zsh-completions" "https://github.com/zsh-users/zsh-completions.git"

    # Create .zshrc configuration
    print_message "green" "Configuring Zsh..."
    cat > ~/.zshrc << 'EOL'
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme (comment out if using starship)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    docker
    npm
    node
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    colored-man-pages
    command-not-found
    history-substring-search
    extract
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load zsh-syntax-highlighting
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load zsh-autosuggestions
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-completions
fpath+=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions/src

# User configuration
export EDITOR='nvim'
export VISUAL='code'

# Aliases
alias ls='eza --icons --git'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias lt='eza --tree --icons'
alias cat='bat'
alias cd='z'

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Initialize starship (uncomment if using starship instead of powerlevel10k)
# eval "$(starship init zsh)"

# Initialize zoxide
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOL

    # Configure Powerlevel10k
    print_message "green" "Downloading p10k configuration..."
    curl -fsSL https://raw.githubusercontent.com/romkatv/powerlevel10k/master/config/p10k-rainbow.zsh > ~/.p10k.zsh

    # Configure tmux
    print_message "green" "Configuring tmux..."
    cat > ~/.tmux.conf << 'EOL'
# Enable mouse support
set -g mouse on

# Set 256 colors
set -g default-terminal "screen-256color"

# Start window numbering at 1
set -g base-index 1
setw -g pane-base-index 1

# Reload config file
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Split panes using | and -
bind | split-window -h
bind - split-window -v

# Switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Enable vi mode
setw -g mode-keys vi

# Status bar customization
set -g status-style bg=black,fg=white
set -g window-status-current-style bg=white,fg=black,bold
EOL

    # Configure Neovim with a basic setup
    print_message "green" "Configuring Neovim..."
    mkdir -p ~/.config/nvim
    cat > ~/.config/nvim/init.vim << 'EOL'
" Basic Settings
set number
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set colorcolumn=80
set signcolumn=yes

" Enable syntax highlighting
syntax enable

" Enable filetype plugins
filetype plugin indent on

" Set leader key to space
let mapleader = " "

" Basic key mappings
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
EOL

    print_message "green" "Terminal development environment setup complete!"
    print_message "yellow" "Please restart your terminal and run 'p10k configure' to complete the powerlevel10k setup."
    print_message "yellow" "Consider installing a Nerd Font in your terminal emulator for the best experience."
fi

# 9. Install other useful tools (optional)
print_message "yellow" "Do you want to install additional development tools? [Y/n]"
read install_tools
if [[ $install_tools == "Y" || $install_tools == "y" ]]; then
    # Version control and development tools
    for tool in gh hub tig; do
        if ! command_exists $tool; then
            print_message "green" "Installing $tool..."
            brew install $tool || print_message "red" "Failed to install $tool. Continuing..."
        else
            print_message "yellow" "$tool already installed. Skipping."
        fi
    done

    # Database tools
    print_message "green" "Installing database tools..."
    if ! brew list --cask | grep -q postgres-unofficial; then
        print_message "green" "Installing PostgreSQL..."
        brew install --cask postgres-unofficial || print_message "red" "Failed to install PostgreSQL. Continuing..."
    else
        print_message "yellow" "PostgreSQL already installed. Skipping."
    fi

    if ! brew list --cask | grep -q mongodb-compass; then
        print_message "green" "Installing MongoDB Compass..."
        brew install --cask mongodb-compass || print_message "red" "Failed to install MongoDB Compass. Continuing..."
    else
        print_message "yellow" "MongoDB Compass already installed. Skipping."
    fi

    # API testing tools
    if ! brew list --cask | grep -q postman; then
        print_message "green" "Installing Postman..."
        brew install --cask postman || print_message "red" "Failed to install Postman. Continuing..."
    else
        print_message "yellow" "Postman already installed. Skipping."
    fi

    # Container tools
    for cask in docker; do
        if ! brew list --cask | grep -q $cask; then
            print_message "green" "Installing $cask..."
            brew install --cask $cask || print_message "red" "Failed to install $cask. Continuing..."
        else
            print_message "yellow" "$cask already installed. Skipping."
        fi
    done

    for tool in kubectl helm; do
        if ! command_exists $tool; then
            print_message "green" "Installing $tool..."
            brew install $tool || print_message "red" "Failed to install $tool. Continuing..."
        else
            print_message "yellow" "$tool already installed. Skipping."
        fi
    done

    # Cloud tools
    for tool in awscli azure-cli google-cloud-sdk; do
        if ! command_exists $tool; then
            print_message "green" "Installing $tool..."
            brew install $tool || print_message "red" "Failed to install $tool. Continuing..."
        else
            print_message "yellow" "$tool already installed. Skipping."
        fi
    done

    # Security tools
    if ! command_exists gpg; then
        print_message "green" "Installing GPG..."
        brew install gpg || print_message "red" "Failed to install GPG. Continuing..."
    else
        print_message "yellow" "GPG already installed. Skipping."
    fi

    if ! brew list --cask | grep -q 1password; then
        print_message "green" "Installing 1Password..."
        brew install --cask 1password || print_message "red" "Failed to install 1Password. Continuing..."
    else
        print_message "yellow" "1Password already installed. Skipping."
    fi
fi

# 10. Install additional programming languages (optional)
print_message "yellow" "Do you want to install additional programming languages? [Y/n]"
read install_languages
if [[ $install_languages == "Y" || $install_languages == "y" ]]; then
    print_message "green" "Installing additional programming languages..."

    # Python
    if ! asdf plugin list | grep -q python; then
        asdf plugin add python
    fi
    asdf install python latest
    asdf set python latest

    # Go
    if ! asdf plugin list | grep -q golang; then
        asdf plugin add golang
    fi
    asdf install golang latest
    asdf set golang latest

    # Java
    if ! asdf plugin list | grep -q java; then
        print_message "green" "Adding Java plugin..."
        asdf plugin add java https://github.com/halcyon/asdf-java.git
    fi

    print_message "green" "Installing latest Java (Temurin 17)..."
    asdf install java temurin-17.0.10+7
    asdf set java temurin-17.0.10+7
fi

# 11. Set up SSH keys (optional)
print_message "yellow" "Do you want to set up SSH keys? [Y/n]"
read setup_ssh
if [[ $setup_ssh == "Y" || $setup_ssh == "y" ]]; then
    print_message "green" "Setting up SSH keys..."
    ssh-keygen -t ed25519 -C "$git_email"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    
    print_message "yellow" "Please add this SSH key to your GitHub account:"
    cat ~/.ssh/id_ed25519.pub
fi

# 12. Verify the installations
print_message "green" "Verifying installations..."
echo "Git version: $(git --version)"
echo "Node.js version: $(node -v)"
echo "npm version: $(npm -v)"
echo "TypeScript version: $(tsc -v)"

# 13. Create development directory structure
print_message "green" "Creating development directory structure..."
mkdir -p ~/Development/{projects,tools,learning}

print_message "green" "Setup Complete! Your MacBook Pro is ready for development."
print_message "yellow" "Please restart your terminal to apply all changes."
