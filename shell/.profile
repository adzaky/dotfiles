# XDG Base dir specifications
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Application Preferences
export ANDROID_SDK_ROOT="$HOME/.local/lib/android"
export EDITOR="vim"
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR="$HOME/.cache/ccache"
export CCACHE_MAX_FILES=0
export CCACHE_MAX_SIZE=100G

# Idempotent executable path
if [ "${PATH#*$HOME/.local/bin}" = "$PATH" ]; then
    USER_PATH="$HOME/.local/bin"
    USER_PATH+=":$HOME/.local/lib/node/bin"
    USER_PATH+=":$HOME/.local/lib/flutter/bin"
    USER_PATH+=":$ANDROID_SDK_ROOT/emulator"
    USER_PATH+=":$ANDROID_SDK_ROOT/platform-tools"
    USER_PATH+=":$ANDROID_SDK_ROOT/tools"
    USER_PATH+=":$ANDROID_SDK_ROOT/tools/bin"
    export PATH="$USER_PATH:$PATH"
fi

#
# Load WSL2-specific env
[ -n "$WSL_INTEROP" ] && source $XDG_CONFIG_HOME/wsl2/env
