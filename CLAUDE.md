# Ghosstty - 终端环境配置项目

## 项目目的

本项目用于管理和维护 macOS 终端开发环境的配置，借助 Claude 辅助完成配置调优。

## 环境信息

- **终端（默认）**: [Supacode](https://supacode.app/) 0.10.8 —— 内嵌 Ghostty 终端内核，负责 worktree / tab / surface 管理
- **终端（备用）**: Ghostty 1.3.1 (stable)
- **多路复用**: Zellij 0.44.1
- **平台**: macOS (Darwin, Apple Silicon)
- **Shell**: zsh (`/bin/zsh`) + oh-my-zsh
- **提示符**: [Starship](https://starship.rs/)
- **历史**: zsh → fish → zsh（2026-09 迁回 zsh，fish 配置已从仓库移除，可从 git 历史找回）

## 配置文件位置

- Supacode 配置: `~/.supacode/settings.json`（另有 `layouts.json`、`sidebar.json`）
- zsh 配置: `~/.zshrc`、`~/.zshenv`、`~/.zprofile`、`~/.zsh_custom_functions`
- Ghostty 配置: `~/.config/ghostty/config`
- Zellij 配置: `~/.config/zellij/config.kdl`
- Zellij tmux shim: `~/.local/share/zellij-tmux-shim/`（POSIX 激活脚本 `activate.sh`）
- Starship 配置: `~/.config/starship.toml`

## 工作流程

- Shell 配置修改目标文件为 `~/.zshrc`；函数集中在 `~/.zsh_custom_functions`
- 登录期变量（PATH 基线、brew shellenv）放 `~/.zprofile`，非交互也需要的放 `~/.zshenv`
- Supacode 配置为 JSON，改完需重启应用生效；也可用 `supacode settings` 打开设置界面
- Supacode CLI 可用 `supacode worktree|tab|surface|repo` 管理会话，详见 `supacode-cli` skill
- Ghostty 配置采用 key-value 格式，每行一个配置项
- 可通过 `ghostty +show-config` 查看当前生效配置
- 可通过 `ghostty +list-themes` / `ghostty +list-fonts` 查看可用主题与字体
- Zellij 配置采用 KDL 格式，修改位于 `~/.config/zellij/config.kdl`
- Starship 相关配置修改位于 `~/.config/starship.toml`

## 注意事项

- **Supacode 没有 shell 配置项**：它启动的是系统登录 shell（passwd 中的 UserShell，即 `chsh -s` 设定的值）。切换 shell 必须走 `chsh`，改 Supacode 或 Ghostty 的配置都不影响 Supacode 的终端
- 用户已安装 fnm (Fast Node Manager)，在 zsh 中通过 `eval "$(fnm env --use-on-cd --shell zsh)"` 加载
- `pi` 命令被包成 shell 函数，强制使用 fnm default 的 node（fnm multishell 会劫持到旧版本 node）
- `claude` 命令被包成 shell 函数，注入 `BROWSER` 与 PATH shim，使其打开的链接走 RoxyBrowser
- Zellij 中运行 Claude Code 时，通过 tmux shim（zellij-claude-teams）实现 Agent Teams 自动分屏
- zsh 启动时如果检测到 `$ZELLIJ` 环境变量，会自动 source `activate.sh` 激活 tmux shim
- `~/.claude/settings.json` 不纳入版本管理：Supacode 会往里写入托管 hook（标记 `# supacode-managed-hook`）同步 Agent 状态，跟踪它只会反复冲突。仓库仅保留可选的 `claude-code/hooks/notify-on-long-task.sh`
- 敏感凭据（GITHUB_TOKEN 等）不要硬编码进 `~/.zshrc`，仓库内副本已脱敏
