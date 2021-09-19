--load plugins first
require('plugins')

-- lua lsp hackery
require'lspconfig'.sumneko_lua.setup{}

local system_name = "Linux"

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
--local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_root_path = '/home/ha/code/lua-language-server'
--..'/lspconfig/sumneko_lua/lua-language-server'
--local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      -- added next 3 lines, working?
      hint = {
        enable = true
      },
    },
  },
}

--LSP keybindings
local nvim_lsp = require('lspconfig')
--function printlsp()
--  print(nvim_lsp)
--end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local servers = { 'sumneko_lua' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
 end

------------------------------ tab between windows, etc
vim.cmd [[
nnoremap <C-i> <C-w><C-w>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap _ <C-w>_
command Q q
command W w
]]
--https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- look again : keybindings

--set linenumbers
vim.o.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- /usr/share/lua/5.1/slug.lua
require('slug')
-- /usr/share/lua/5.1/caller.lua
-- call with :lua caller.foo()
-- 'modular' lua setup:
require('caller')
-- cool statusline with modificiation [+]
require('hardline').setup {

sections = {         -- define sections
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'high', item = require('hardline.parts.git').get_item, hide = 100},
    {class = 'med', item = require('hardline.parts.cwd').get_item},
    '->',
    {class = 'med', item = require('hardline.parts.filename').get_item},
    '%<',
    {class = 'med', item = '%='},
    --{class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 100},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'warning', item = require('hardline.parts.whitespace').get_item},
    {class = 'low', item = require('hardline.parts.filetype').get_item, hide = 80},
    {class = 'mode', item = require('hardline.parts.line').get_item},
  }
}

--syntax on
