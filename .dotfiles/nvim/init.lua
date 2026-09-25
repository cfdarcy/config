vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.winborder = "rounded" 

vim.g.mapleader = " "
vim.keymap.set('n','<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n','<leader>w', ':write<CR>')
vim.keymap.set('n','<leader>q', ':quit<CR>')

vim.pack.add({
	{src="https://github.com/neovim/nvim-lspconfig"},
	{src="https://github.com/nvim-treesitter/nvim-treesitter"},
	{src="https://github.com/windwp/nvim-autopairs"},
	{src="https://github.com/numToStr/Comment.nvim"},
	{src="https://github.com/norcalli/nvim-colorizer.lua"},
	{src="https://github.com/ibhagwan/fzf-lua"},
})

vim.lsp.enable({ "pylsp" })

--vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

require("plugins.treesitter")
require("plugins.autopairs")
require("plugins.comment")
require("plugins.colorizer")
require("plugins.fzf-lua")
