# Add ~/.local/bin to PATH (for Linux/chezmoi installs)
fish_add_path -g ~/.local/bin

# Add Go bin to PATH
fish_add_path -g ~/go/bin

# Homebrew setup (macOS only)
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

# Tell Flox to use fish
set -gx FLOX_SHELL /opt/homebrew/bin/fish

# Set default editor to Helix
set -gx EDITOR hx

# Use the Proton Pass SSH agent (falls back to the default agent if not running)
if test -S ~/.ssh/proton-pass-agent.sock
    set -gx SSH_AUTH_SOCK ~/.ssh/proton-pass-agent.sock
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

# Initialize zoxide
if command -q zoxide
    zoxide init fish | source
end
