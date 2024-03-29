-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
--vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
--vim._update_package_paths()
local packer = require("packer")
local use = packer.use

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  --statusline
  use {'ojroques/nvim-hardline'}

  --use 'https://github.com/Shougo/deoplete.nvim'
  --vim.cmd [[  let g:deoplete#enable_at_startup = 1 ]]
  --
  use {'~/backport-clang/'}

  use 'https://github.com/neovim/nvim-lspconfig'

  -- Simple plugins can be specified as strings
  --use '9mm/vim-closer'

  -- Lazy loading:
  -- Load on specific commands
  --use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- *** ...having issues getting ping.lua into scope
  -- Load on an autocommand event
  --use {'andymass/vim-matchup', event = 'VimEnter'}
  --use {'~/.config/nvim/lua/', event = 'VimEnter', module = 'ping' }

  --mymathmodule = require("ping")

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  --use {
    --'w0rp/ale',
    --ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    --cmd = 'ALEEnable',
    --config = 'vim.cmd[[ALEEnable]]'
  --}

  -- Plugins can have dependencies on other plugins
  --use {
   -- 'haorenW1025/completion-nvim',
    --opt = true,
    --requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
 -- }

  -- Plugins can also depend on rocks from luarocks.org:
  --use {
    --'my/supercoolplugin',
    --rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
  --}

  -- You can specify rocks in isolation
  --use_rocks 'penlight'
  --use_rocks {'lua-resty-http', 'lpeg'}

  -- Local plugins can be included
  --use '~/projects/personal/hover.nvim'

  -- Plugins can have post-install/update hooks
  --use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Post-install/update hook with neovim command
  --use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Post-install/update hook with call of vimscript function with argument
  -- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  --exp
  --use { run = function() fim.fn['let g:mark = 1'](0) end }

  -- Use specific branch, dependency and run lua file after load
  --use {
    --'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
    --requires = {'kyazdani42/nvim-web-devicons'}
  --}

  -- Use dependency and run lua function after load
  --use {
    --'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    --config = function() require('gitsigns').setup() end
  --}

  -- You can specify multiple plugins in a single call
  --use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  --use {'dracula/vim', as = 'dracula'}
end)
