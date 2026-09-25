return {
	config = function ()
		local treesitter = require('nvim-treesitter')
		treesitter.setup()
		treesitter.install { 'python', 'lua', 'c', 'cpp', 'json', 'markdown' , 'markdown_inline'}
		vim.api.nvim_create_autocmd('FileType', {
			pattern = { 'python', 'lua', 'c', 'cpp', 'json', 'markdown' , 'markdown_inline'},

			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end
}

