-- Leader tuşunu ayarla
vim.g.mapleader = ' '

-- Packer kurulumu (otomatik)
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
	end
end
ensure_packer()

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons',
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'neovim/nvim-lspconfig'
		-- Tema eklentileri
		use 'folke/tokyonight.nvim'
		use 'morhetz/gruvbox'
		use 'NLKNguyen/papercolor-theme'
		use {
			'slugbyte/lackluster.nvim',
			as = 'lackluster',
		}
end)

local themes = {
	catppuccin = 'catppuccin',
	tokyonight = 'tokyonight',
	gruvbox = 'gruvbox',
	papercolor = 'PaperColor',
	lackluster = 'lackluster',
}

function ChangeTheme(name)
	if themes[name] then
		vim.cmd('colorscheme ' .. themes[name])
		print('Tema değiştirildi: ' .. themes[name])
	else
		print('Tema bulunamadı: ' .. name)
	end
end

vim.api.nvim_create_user_command('Theme', function(opts)
	ChangeTheme(opts.args)
end, { nargs = 1, complete = function()
	return vim.tbl_keys(themes)
end })

-- Varsayılan tema
vim.cmd('colorscheme lackluster')

-- nvim-tree ayarları
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
require('nvim-tree').setup {}

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})

-- <leader>e ile file tree toggle
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- lspconfig örnek ayarı (pyright)
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
