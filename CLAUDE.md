# Ghosstty - 终端环境配置项目

## 项目目的

本项目用于管理和维护 macOS 终端开发环境的配置，借助 Claude 辅助完成配置调优。

## 环境信息

- **终端（默认）**: [Prowl](https://github.com/onevcat/Prowl) 2026.10.21 —— Supacode 在 0.11 之前分出的 fork，Ghostty 内核，层级为 仓库 → worktree（侧边栏）→ tab（顶部）→ 分屏（tab 内）
- **终端（备用）**: Ghostty 1.3.1 (stable)
- **多路复用**: Zellij 0.44.1
- **平台**: macOS (Darwin, Apple Silicon)
- **Shell**: zsh (`/bin/zsh`) + oh-my-zsh
- **提示符**: [Starship](https://starship.rs/)
- **文件管理**: yazi 26.9.1（`y` 函数启动，退出时切换目录）
- **编辑器**: Neovim 0.12.5（`EDITOR` / `VISUAL`，`vi` `vim` 均别名到 `nvim`；SSH 会话回退系统 vim）
- **Diff 查看**: Hunk 0.24.1（Prowl 的 Diff Tool，`⌘⇧Y` 新开 tab 跑 `hunk diff`；git pager 仍是 delta）
- **历史**: zsh → fish → zsh（2026-09 迁回 zsh，fish 配置已从仓库移除，可从 git 历史找回）；终端 Supacode → cmux → Prowl（2026-10：Supacode 0.11 和 cmux 都是「分屏里装 tab」，用户要的是「tab 里装分屏」。Supacode 配置已从仓库移除，可从 git 历史找回；cmux 配置没提交过，本机的也已删除）

## 配置文件位置

- Prowl 配置: `~/.prowl/settings.json`（全局 + 仓库列表）、`~/.prowl/global.user.json`（全局自定义命令、Agent Profiles）、`~/.prowl/repo/<目录名>-<路径 SHA-256 前 8 位>/prowl.json` 与 `prowl.user.json`（按仓库设置、按仓库自定义命令）
- zsh 配置: `~/.zshrc`、`~/.zshenv`、`~/.zprofile`、`~/.zsh_custom_functions`
- Ghostty 配置: `~/.config/ghostty/config`（Prowl 也读取：字体、配色、分屏键位、`command`）
- Zellij 配置: `~/.config/zellij/config.kdl`
- Zellij tmux shim: `~/.local/share/zellij-tmux-shim/`（POSIX 激活脚本 `activate.sh`）
- Starship 配置: `~/.config/starship.toml`
- yazi 配置: `~/.config/yazi/keymap.toml`、`package.toml`（插件清单，`ya pkg install` 还原）
- Neovim 配置: `~/.config/nvim/init.lua`；Vim 配置: `~/.vimrc`、`~/.vim/colors/`
- Hunk 配置: `~/.config/hunk/config.toml`

## 工作流程

- Shell 配置修改目标文件为 `~/.zshrc`；函数集中在 `~/.zsh_custom_functions`
- 登录期变量（PATH 基线、brew shellenv）放 `~/.zprofile`，非交互也需要的放 `~/.zshenv`
- Prowl 运行时手改 JSON 可能被它覆盖：优先用设置界面（`⌘,`），手改先退出 Prowl。`global` 里只有 `appearanceMode`、`updatesAutomaticallyCheckForUpdates`、`updatesAutomaticallyDownloadUpdates` 三个必填字段，其余缺省时用默认值
- Prowl 字段说明在官方文档 `docs/reference/settings-fields.md`，快捷键在 `docs/reference/keyboard-shortcuts.md`；也可让 Prowl 内的 Help → Ask Agent About Prowl 给出文档
- Prowl CLI 在 `/Applications/Prowl.app/Contents/Resources/prowl-cli/prowl`（未装到 PATH），`prowl list` 只列出开着终端的 worktree
- 分屏键位（`new_split`、`equalize_splits`、`goto_split`）来自 Ghostty 配置；与 Prowl 应用快捷键冲突的 Ghostty 键会被 Prowl 自动解绑
- Prowl 关闭分屏只把节点摘出分屏树，剩下的保持原比例，没有自动均分的设置；`close_surface` 后 `chain=equalize_splits` 也无效（⌘W 走菜单，且均分作用在已关闭的 pane 上）
- Prowl 的 Terminal 菜单（字号、关闭等）用 Ghostty 最后一个同 action 绑定作菜单键，终端里命中 Ghostty 绑定时菜单先匹配，且 `⌘+` 等同 `⌘⇧=`。所以 `ghostty/config` 重绑了 `cmd+==increase_font_size:1`，避免「增大字号 ⌘+」抢走 `⌘⇧=` 均分。加新键位前先用 System Events 读 `ProwlApp` 菜单的 `AXMenuItemCmdChar` 查冲突
- 改完 Ghostty 配置用 Prowl 设置 → General → Terminal Config → Reload 重载；`⌘⇧,`（Ghostty 的 `reload_config`）不带 Prowl 的快捷键覆盖层，实测没让菜单刷新
- Ghostty 配置采用 key-value 格式，每行一个配置项
- 可通过 `ghostty +show-config` 查看当前生效配置
- 可通过 `ghostty +list-themes` / `ghostty +list-fonts` 查看可用主题与字体
- Zellij 配置采用 KDL 格式，修改位于 `~/.config/zellij/config.kdl`
- Starship 相关配置修改位于 `~/.config/starship.toml`
- yazi 键位改 `~/.config/yazi/keymap.toml`，重启 yazi 生效；命令模板占位符是 `%s`（选中文件）/ `%h`（悬停文件），不是 `$@`
- yazi 插件用 `ya pkg add|upgrade|install` 管理，版本锁在 `package.toml`
- Neovim 无插件管理器，`init.lua` 把 `~/.vim` 追加进 `runtimepath` 复用 Vim 的 Catppuccin 配色，配色只维护 `vim/catppuccin_mocha.vim` 一份
- Hunk 配置不要开 `watch = true`：它对所有调用生效，非交互（管道、重定向）的 `hunk diff` 会报 `--watch requires an interactive output terminal`；需要时按 `r` 刷新或单次加 `--watch`

## 注意事项

- **用户的核心要求是「tab 里装分屏」**：一个项目对应多个顶部 tab，每个 tab 有独立的分屏，切 tab 才显示该 tab 的分屏。这是从 Supacode 0.11、cmux 换到 Prowl 的原因，选终端或改配置时不能破坏这一点
- tab 名来自终端标题，由 `.zshrc` 在 omz 加载后覆盖 `ZSH_THEME_TERM_TITLE_IDLE` / `ZSH_THEME_TERM_TAB_TITLE_IDLE` 为 `%1~`（当前目录名）
- 系统 UserShell 是 zsh，切换 shell 走 `chsh`
- 用户已安装 fnm (Fast Node Manager)，在 zsh 中通过 `eval "$(fnm env --use-on-cd --shell zsh)"` 加载
- `pi` 命令被包成 shell 函数，强制使用 fnm default 的 node（fnm multishell 会劫持到旧版本 node）
- `claude` 命令由包装脚本 `~/.claude/shims/bin/claude`（仓库 `claude-code/shims/bin/claude`）接管，注入 `BROWSER` 与 PATH shim，使其打开的链接走 RoxyBrowser。`.zshrc` 在 `~/.local/bin` 之后把 `~/.claude/shims/bin` prepend 到 PATH。不要改回 shell 函数：Prowl Agent Profile 用 `env … claude` 启动，会绕过函数。脚本去掉自身目录后按 PATH 找真正的 claude，不要改成写死绝对路径；`exec -a claude` 保持 argv[0]，Prowl 靠它识别 agent
- Prowl 没有 Agent Teams 原生分屏；需要队友分屏时在 tab 里开 Zellij，走 tmux shim（zellij-claude-teams）
- zsh 启动时如果检测到 `$ZELLIJ` 环境变量，会自动 source `activate.sh` 激活 tmux shim
- 仓库里的 `prowl/settings.json` 只保留 `global` 段，`repositoryRoots` / `repositories` 置空；按仓库的设置和自定义命令（`~/.prowl/repo/…`）含本机路径，不进仓库
- `~/.claude/settings.json` 不纳入版本管理。Supacode 的托管 hook 和 skill（`~/.claude`、`~/.codex`、`~/.pi/agent` 三处）已于 2026-10 清除；Prowl 也不写这个文件（Agent Profile 启动时用 `--settings` 临时注入 hook，手动敲 `claude` 靠进程和屏幕识别状态）。仓库仅保留可选的 `claude-code/hooks/notify-on-long-task.sh`
- Prowl 窗口着色 `windowTintMode` 保持 `none`：Ghostty 背景不透明时，Prowl 用终端背景色（`#292A3A`）作窗口底色，侧栏玻璃透出它；`repositoryColor` 会在侧栏和工具栏上叠一层色带（有仓库颜色时 20%，没有时 10% 的白），侧栏就和终端背景对不上，而且每个仓库都不一样
- yazi 覆盖了三个键：`Enter` 改为只进目录（默认的 `open` 会用 `$EDITOR` 把目录打开成 netrw），`e` 用 `$EDITOR` 编辑，`T` 由 toggle-pane 插件最大化预览栏
- 敏感凭据（GITHUB_TOKEN 等）不要硬编码进 `~/.zshrc`，仓库内副本已脱敏
