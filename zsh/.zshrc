# --- Zellij-tmux-shim (Claude Code agent teams in zellij) ---
# 必须在最前面，早于交互式配置
if [ -n "$ZELLIJ" ]; then
    _shim="$HOME/.local/share/zellij-tmux-shim/activate.sh"
    [ -f "$_shim" ] && source "$_shim"
    unset _shim
fi

# zmodload zsh/zprof
# zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""   # 使用 starship，禁用 omz 主题

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git sudo zoxide zsh-autosuggestions direnv)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_custom_functions

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export VISUAL="$EDITOR"
alias vi='nvim'
alias vim='nvim'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cls="clear"
alias glog="git lg"
alias php_docker="docker exec -it php-nginx-fpm bash"
alias subl="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'"
alias python="python3"
alias yolo="claude --dangerously-skip-permissions"

# go
export PATH="$PATH:$HOME/go/bin"

# flutter
export PATH=$HOME/development/flutter/bin:$PATH

# python
export PATH=$HOME/Library/Python/3.9/bin:$PATH

# ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
# ruby end

# bun completions
[ -s "/Users/windseeker/.bun/_bun" ] && source "/Users/windseeker/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Gemini
export GOOGLE_CLOUD_PROJECT=modified-legacy-464108-h9

# Claude Code Vertex AI
export GOOGLE_APPLICATION_CREDENTIALS="/Users/windseeker/.claude-vertex/tencent-gcp-sg-imur-7d8fb472be16.json"

# export GITHUB_TOKEN="<your-token>"   # 建议改用 gh auth / 钥匙串，勿硬编码

. "/Users/windseeker/.deno/env"

# ============================================================
# 从 fish 迁移回来的配置 (2026-09-09)
# ============================================================

# --- PATH 补充 ---
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.antigravity/antigravity/bin"

# --- Claude Code 连接中断自动恢复 ---
export CLAUDE_CODE_AUTO_RESUME_ON_DROP=1
export CLAUDE_CODE_MAX_RESUME_ATTEMPTS=3

# --- Aliases (对齐 fish abbr) ---
alias cat='bat'
alias gg='lazygit'
alias ls='eza --icons'
alias l='eza --icons -la'
alias ll='eza --icons -l'
alias php_docker='docker exec -it -w /data/web/survey-admin php-nginx-fpm bash'

# --- claude: 网页链接固定走 RoxyBrowser MER-4 / USA ---
# BROWSER 适配新版 Claude Code；PATH shim 兼容内部调用 open 的旧路径。
# 变量仅作用于 claude 进程，系统和其他终端命令仍使用 Chrome。
# 自检: ~/.claude/shims/check
claude() {
    BROWSER="$HOME/.claude/shims/claude-browser" \
    PATH="$HOME/.claude/shims:$PATH" \
    command claude "$@"
}

# --- claude-sentry: 按需加载 Sentry MCP ---
claude-sentry() {
    claude --strict-mcp-config --mcp-config="$HOME/.claude/sentry-mcp.json" "$@"
}

# --- pi: 固定用 fnm default 的 node ---
# pi 的 bin 是 `#!/usr/bin/env node`，会被 PATH 首位的 fnm multishell 劫持到旧 node。
# pi 要求 node >= 22.19。
pi() {
    local root node cli
    root=$(cd "$FNM_DIR/aliases/default" 2>/dev/null && pwd -P)
    node="$root/bin/node"
    cli="$root/lib/node_modules/@earendil-works/pi-coding-agent/dist/cli.js"
    if [ ! -x "$node" ] || [ ! -f "$cli" ]; then
        echo "pi: 未在 fnm default ($root) 下找到 pi 或 node，回退到 PATH 查找" >&2
        command pi "$@"
        return $?
    fi
    "$node" "$cli" "$@"
}

# --- fzf: 仅 Ctrl+R 搜索历史 ---
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
    bindkey -r '^T'      # 禁用 Ctrl+T 文件搜索
    bindkey -r '\ec'     # 禁用 Alt+C 目录跳转
fi

# --- 导出命令耗时供 Starship 自定义模块读取 ---
__starship_cmd_start() { __starship_cmd_start_ts=$EPOCHREALTIME }
__starship_cmd_end() {
    if [ -n "$__starship_cmd_start_ts" ]; then
        export STARSHIP_CMD_DURATION_MS=$(( (EPOCHREALTIME - __starship_cmd_start_ts) * 1000 ))
        STARSHIP_CMD_DURATION_MS=${STARSHIP_CMD_DURATION_MS%%.*}
        unset __starship_cmd_start_ts
    fi
}
zmodload zsh/datetime
autoload -Uz add-zsh-hook
add-zsh-hook preexec __starship_cmd_start
add-zsh-hook precmd __starship_cmd_end

# --- Starship prompt (放最后，覆盖 omz 主题) ---
eval "$(starship init zsh)"

# --- 默认开启 Surge 代理，需要时手动 proxy_off ---
proxy_on >/dev/null
