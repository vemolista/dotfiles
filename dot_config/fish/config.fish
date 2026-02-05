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

##########
# Zellij #
##########

# Unset the default fish greeting text which messes up Zellij
set fish_greeting

# Check if we're in an interactive shell
if status is-interactive

    # At this point, specify the Zellij config dir, so we can launch it manually if we want to
    export ZELLIJ_CONFIG_DIR=$HOME/.config/zellij

    # Check if our Terminal emulator is Ghostty
    if [ "$TERM" = xterm-ghostty ]
        # Launch zellij
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end
