-- Neovim 最小配置：复用 ~/.vim/colors/catppuccin_mocha.vim，与 vim / bat 配色保持一致
-- 不依赖任何插件管理器；需要 LSP、treesitter 时再引入 lazy.nvim

-- 让 nvim 也能找到 ~/.vim 下的 colors/ 等目录，避免配色文件两份拷贝
vim.opt.runtimepath:append(vim.fn.expand("~/.vim"))

-- 对齐 ~/.vimrc
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.termguicolors = true

-- 常用默认值
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 5
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.mapleader = " "

-- 配色缺失时不要报错中断启动
pcall(vim.cmd.colorscheme, "catppuccin_mocha")
