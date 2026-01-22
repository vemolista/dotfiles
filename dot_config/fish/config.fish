# Add ~/.local/bin to PATH (for Linux/chezmoi installs)
fish_add_path -g ~/.local/bin

# Homebrew setup (macOS only)
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

# Initialize starship
if command -q starship
    starship init fish | source
end

