# Ghosstty

macOS 下的完整终端开发环境配置，包含终端、Shell、提示符、编辑器配色等一站式方案。

> **默认终端为 [Supacode](https://supacode.app/)**，它内嵌 Ghostty 终端内核，额外提供 git worktree、tab、surface 与编码 Agent 的管理能力。Ghostty 作为备用终端保留，配置仍在 `ghostty/`。
>
> **Shell 为 zsh**。项目早期使用 fish，2026-09 迁回 zsh，fish 配置已从仓库移除，可从 git 历史找回。

## 预览

```
 …/project   main +2/-1   v1.3.11   10:52
```

Pastel Powerline 风格提示符，支持 Git 状态、语言版本检测、命令耗时显示。

## 技术栈

| 组件 | 工具 | 版本 |
|------|------|------|
| 终端（默认） | [Supacode](https://supacode.app/) | 0.10.8 |
| 终端（备用） | [Ghostty](https://ghostty.org/) | 1.3.1 |
| 多路复用 | [Zellij](https://zellij.dev/) | 0.44.1 |
| Shell | [zsh](https://www.zsh.org/) + [oh-my-zsh](https://ohmyz.sh/) | 5.9 |
| 提示符 | [Starship](https://starship.rs/) | 1.24.2 |
| 文件查看 | [bat](https://github.com/sharkdp/bat) | 0.26.1 |
| 文件列表 | [eza](https://github.com/eza-community/eza) | 0.23.4 |
| 目录跳转 | [zoxide](https://github.com/ajeetdsouza/zoxide) | 0.9.8 |
| 模糊搜索 | [fzf](https://github.com/junegunn/fzf) | 0.70.0 |
| Git TUI | [lazygit](https://github.com/jesseduffield/lazygit) | 0.60.0 |
| 文件管理 | [yazi](https://yazi-rs.github.io/) | 26.9.1 |
| 编辑器 | [Neovim](https://neovim.io/) | 0.12.5 |
| Node 管理 | [fnm](https://github.com/Schniz/fnm) | - |

### 字体

- **中文/CJK**: [Sarasa Term SC](https://github.com/be5invis/Sarasa-Gothic) (更纱黑体)
- **英文/符号**: [JetBrainsMono Nerd Font Mono](https://www.nerdfonts.com/)

## 目录结构

```
.
├── supacode/
│   └── settings.json       # Supacode 全局设置（已剔除本机仓库路径）
├── ghostty/
│   └── config              # Ghostty 终端配置（备用终端）
├── zellij/
│   ├── config.kdl          # Zellij 多路复用器配置
│   └── activate.sh         # Agent Teams tmux shim 的 POSIX 激活脚本
├── zsh/
│   ├── .zshrc              # zsh 交互式配置（插件、别名、函数、提示符）
│   ├── .zshenv             # 所有 zsh 进程都需要的变量
│   ├── .zprofile           # 登录期变量（brew shellenv、Toolbox、OrbStack）
│   └── .zsh_custom_functions  # 自定义函数集
├── starship/
│   └── starship.toml       # Starship 提示符配置
├── bat/
│   └── config              # bat 配置
├── yazi/
│   ├── keymap.toml         # yazi 键位覆盖（Enter/e/T）
│   └── package.toml        # yazi 插件清单（toggle-pane）
├── vim/
│   └── catppuccin_mocha.vim # Catppuccin Mocha 配色方案
└── claude-code/
    └── hooks/
        └── notify-on-long-task.sh  # 长任务完成通知脚本（可选）
```

## 安装

### 1. 安装依赖

```bash
brew install starship bat eza zoxide fzf lazygit fnm zellij direnv yazi neovim
brew install --cask supacode ghostty

# oh-my-zsh 及插件
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

### 2. 安装字体

```bash
brew install --cask font-sarasa-gothic font-jetbrains-mono-nerd-font
```

### 3. 部署配置文件

```bash
# Ghostty
cp ghostty/config ~/.config/ghostty/config

# Zellij
mkdir -p ~/.config/zellij
cp zellij/config.kdl ~/.config/zellij/config.kdl

# Supacode（改完需重启应用）
mkdir -p ~/.supacode
cp supacode/settings.json ~/.supacode/settings.json

# zsh
cp zsh/.zshrc ~/.zshrc
cp zsh/.zshenv ~/.zshenv
cp zsh/.zprofile ~/.zprofile
cp zsh/.zsh_custom_functions ~/.zsh_custom_functions

# Starship
cp starship/starship.toml ~/.config/starship.toml

# bat
mkdir -p ~/.config/bat
cp bat/config ~/.config/bat/config

# yazi（package.toml 记录插件版本，拷贝后执行 ya pkg install 拉取插件）
mkdir -p ~/.config/yazi
cp yazi/keymap.toml yazi/package.toml ~/.config/yazi/
ya pkg install

# Vim
cp vim/.vimrc ~/.vimrc
mkdir -p ~/.vim/colors
cp vim/catppuccin_mocha.vim ~/.vim/colors/catppuccin_mocha.vim
```

### 4. 设置默认 Shell

Supacode 和 Ghostty 都启动系统登录 shell，两者本身没有 shell 配置项。切换 shell 只能通过 `chsh`：

```bash
chsh -s /bin/zsh          # 需要输入登录密码
dscl . -read ~/ UserShell # 验证
```

改完重启终端应用即可生效。

## 配置说明

### Supacode

内嵌 Ghostty 终端内核，在其之上提供 git worktree 管理、tab / surface 编排与编码 Agent 集成。

- **worktree 基目录**: 按仓库配置，例如 `<repo>/.worktrees/`
- **默认编辑器**: Zed（`defaultEditorID`）
- **PR 合并策略**: squash
- **归档 worktree**: 7 天后自动删除
- **CLI**: `supacode worktree|tab|surface|repo|settings`，Claude Code 中另有 `supacode-cli` skill 可直接驱动

仓库内的 `supacode/settings.json` 只保留 `global` 段，本机仓库路径与远程主机地址已剔除，导入后需自行添加仓库。

### Ghostty

- **双字体方案**: Sarasa Term SC 渲染中文，JetBrainsMono Nerd Font Mono 渲染英文和图标符号（通过 `font-codepoint-map` 按 Unicode 范围映射）
- **配色**: 基于 Oil 主题自定义，背景色 `#292A3A`
- **分屏快捷键**:
  - `Cmd+D` 右侧分屏 / `Cmd+Shift+D` 下方分屏
  - `Cmd+Alt+方向键` 切换面板
  - `Cmd+Shift+=` 均分面板
  - `Cmd+W` 关闭面板

### Zellij

Vim 风格键位（`clear-defaults=true`），内置 tmux 兼容模式（`Ctrl+B` 前缀）。

- **分屏**: `Ctrl+P` 进入 pane 模式，`n` 新建 / `r` 右分 / `d` 下分 / `s` 堆叠
- **Tab**: `Ctrl+T` 进入 tab 模式，`n` 新建 / `r` 重命名 / `1-9` 跳转
- **导航**: `Alt+h/j/k/l` 在 pane/tab 间移动焦点
- **调整大小**: `Ctrl+N` 进入 resize 模式，`h/j/k/l` 调整

#### Claude Code Agent Teams 集成

通过 [zellij-claude-teams](https://github.com/stanislc/zellij-claude-teams) tmux shim，让 Agent Teams 在 Zellij 中自动分屏。

**原理**：在 Zellij 内将假的 `tmux` 放到 PATH 前端，拦截 Claude Code 的 tmux 命令（`split-window`、`send-keys`、`kill-pane` 等）并翻译为 `zellij action` 等价操作。

**部署**：

```bash
# 安装 tmux shim
git clone https://github.com/stanislc/zellij-claude-teams.git /tmp/zellij-claude-teams
bash /tmp/zellij-claude-teams/install.sh

# 部署激活脚本（项目已包含）
cp zellij/activate.sh ~/.local/share/zellij-tmux-shim/activate.sh

# zsh/.zshrc 开头已包含自动激活逻辑，无需额外配置
```

### Starship 提示符

基于 [Catppuccin Powerline](https://starship.rs/presets/catppuccin-powerline) 预设，配色切换为 [M365Princess](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/M365Princess.omp.json) Pastel Powerline 风格：

| 段 | 颜色 | 色值 |
|---|---|---|
| 目录 | 腮红 Blush | `#DA627D` |
| Git 分支/状态 | 鲑鱼 Salmon | `#FCA17D` |
| 语言版本 | 天蓝 Sky | `#86BBD8` |
| 时间 | 深青 Teal Blue | `#33658A` |
| 段内文字 | 白色 | `#FFFFFF` |

支持的语言检测: Node.js, Bun, Go, Rust, Python, C, PHP, Java, Kotlin, Haskell

命令耗时使用自定义模块（`custom.duration`）实现，通过 zsh 的 `preexec` / `precmd` 钩子计算并导出 `STARSHIP_CMD_DURATION_MS`，Starship 读取后智能格式化为 `Xs` / `Xm Xs` / `Xh Xm`，以灰色胶囊样式显示（仅命令耗时 > 2 秒时出现）。

由于使用 Starship，`.zshrc` 中的 `ZSH_THEME` 置空，避免 oh-my-zsh 主题被加载后又被覆盖。

### bat & Vim

两者统一使用 **Catppuccin Mocha** 配色方案，确保 `bat` 查看文件和 `vi` 编辑文件时语法高亮风格一致。

> `EDITOR` 现为 Neovim，`vi` / `vim` 均已别名到 `nvim`。Neovim 读的是 `~/.config/nvim/`，不会加载 `~/.vimrc` 与 `~/.vim/colors/`，所以上面那套 Vim 配色目前只在显式执行 `/usr/bin/vim` 时生效。SSH 会话仍走系统 vim。

### yazi

终端文件管理器，默认键位保持不变（`hjkl` 导航，`h` 回上级，`r` 重命名，`.` 显示隐藏文件，`z` 跳 zoxide，`S` 用 ripgrep 搜内容）。仓库只覆盖三处：

| 键 | 行为 | 说明 |
|----|------|------|
| `Enter` | `enter` | 默认 Enter 是 `open`，对目录会调用 `$EDITOR` 打开成 netrw，改成与 `l` 一致只进目录 |
| `e` | `shell --block -- $EDITOR %s` | 用 Neovim 编辑当前文件，退出后回到 yazi |
| `T` | `plugin toggle-pane max-preview` | 预览栏最大化 / 还原，配合 `J` `K` 滚动看长文件 |

注意占位符是 `%s`（选中文件）和 `%h`（悬停文件），不是 shell 的 `$@`。

`~/.zsh_custom_functions` 里的 `y` 函数用 `--cwd-file` 把退出时的目录写回 shell，因此用 `y` 启动才能实现「退出 yazi 后停在浏览到的目录」；按 `Q` 退出则保持原目录。

### zsh 别名与函数

```
cat  → bat              ls  → eza --icons      l   → eza --icons -la
ll   → eza --icons -l   gg  → lazygit          cls → clear
python → python3        yolo → claude --dangerously-skip-permissions
```

Git 缩写（`gcm` / `gcmsg` / `gpsup` / `ggf` 等）由 oh-my-zsh 的 `git` 插件提供。

自定义函数集中在 `~/.zsh_custom_functions` 与 `.zshrc` 尾部：

| 函数 | 说明 |
|------|------|
| `y` | 启动 yazi，退出时把 shell 切到最后浏览的目录 |
| `proxy_on` / `proxy_off` | 开关 Surge HTTP 代理（新 shell 默认开启） |
| `claude` | 注入 `BROWSER` 与 PATH shim，链接走 RoxyBrowser |
| `claude-sentry` | 按需加载 Sentry MCP 的 Claude Code |
| `pi` | 强制用 fnm default 的 node 运行 pi（避开 multishell 劫持） |
| `team_claude` / `unset_team_claude` | 切换 Claude Code 走 Vertex AI |
| `claude_sync` | 在 `.claude` 与 `.claude-internal` 间同步会话记录 |
| `gcml` | 对比当前主分支与 production 的提交差异 |
| `delete_git_branch` | 按前缀批量删除本地/远程分支 |

fzf 只保留 `Ctrl+R` 搜索历史，`Ctrl+T` 与 `Alt+C` 已解绑。

> 注意：不要把 `GITHUB_TOKEN` 等凭据硬编码进 `.zshrc`，建议改用 `gh auth login` 或系统钥匙串。仓库内的副本已脱敏。

### Claude Code

`~/.claude/settings.json` **不再纳入版本管理**。Supacode 会往其中写入自己托管的 hook（`# supacode-managed-hook`）来同步 Agent 状态到 UI，跟踪该文件只会与 Supacode 反复冲突。插件、模型、主题等也已改为直接在应用内配置。

仓库只保留一个可选的独立脚本：长任务完成后（> 3 分钟）发送 macOS 桌面通知 + Glass 提示音。

```bash
brew install terminal-notifier

mkdir -p ~/.claude/hooks
cp claude-code/hooks/notify-on-long-task.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/notify-on-long-task.sh
```

启用方式：在 `~/.claude/settings.json` 的 `hooks.Stop` 中追加一条 `~/.claude/hooks/notify-on-long-task.sh`，注意保留 Supacode 已有的条目。

## 许可

MIT
