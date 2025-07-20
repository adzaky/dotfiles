# If not running interactively, don't do anything
[[ $- != *i* ]] && return

ZSCRIPT_HOME="$HOME/.zsh"
typeset -Ag ZI
ZI[HOME_DIR]="${ZSCRIPT_HOME}/zi"
ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"

# ssh
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/sshadzakywp 2>/dev/null
fi

if [ ! -f "${ZI[BIN_DIR]}/zi.zsh" ]; then
    command mkdir -p "${ZI[BIN_DIR]}"
    command chmod go-rwX "${ZI[HOME_DIR]}"
    command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "${ZI[BIN_DIR]}"
fi

source "${ZI[BIN_DIR]}/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
zicompinit

# Plugins
zi wait depth=1 lucid light-mode for \
    hlissner/zsh-autopair \
    atinit"zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zi creinstall -q .' \
    zsh-users/zsh-completions

# Snippets
zi lucid light-mode for \
    OMZL::functions.zsh \
    OMZL::completion.zsh \
    OMZL::directories.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::termsupport.zsh

# Programs
if [[ "$(uname -m)" == "x86_64" ]];then
    # ripgrep
    zi ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
    zi light BurntSushi/ripgrep

    # exa
    zi ice as"command" from"gh-r" bpick"exa-linux-x86_64-musl-*" pick"bin/exa"
    zi light ogham/exa

    # bat
    zi ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
    zi light sharkdp/bat

    # sharkdp/fd
    zi ice as"command" from"gh-r" mv"fd* -> fd" bpick"*x86_64-unknown-linux-gnu*" pick"fd/fd"
    zi light sharkdp/fd

    # fzf
    zi ice from"gh-r" as"program"
    zi light junegunn/fzf
fi

# Theme
zi ice pick="lib/async.zsh" src="roundy.zsh" compile"{lib/async,roundy}.zsh"
zi light nullxception/roundy

# zoxide
eval "$(zoxide init zsh --cmd cd)"

# herd-lite
export PATH="/home/adzaky/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/adzaky/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# pnpm
export PNPM_HOME="/home/adzaky/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# nvm
export PATH="$PATH:/home/adzaky/.local/bin"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
