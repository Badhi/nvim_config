M = {}

function M.setup()

local lsp_status = require('lsp-status')
lsp_status.register_progress()

lsp_status.config({
    kind_labels = {
        Function = '',
    },
    status_symbol = '⚡',
	indicator_errors = '',
	indicator_warnings = '',
	indicator_info = '',
	indicator_hint = '',
	indicator_ok = '',
    --spinner_frames = {'', '', '', '', '', '', '', '', '', '', '', ''},
    spinner_frames = {'', '', '', '', '', '', '', '', '', '',
                      '', '', '', '', '', '', '', '', '', '',
                      '', '', '', '', '', '', '', ''},
})

local on_attach = function(cmd, buf)
                require('completion').on_attach(cmd, buf)
                lsp_status.on_attach(cmd, buf)
                end
--[[
require'lspconfig'.clangd.setup{
    handlers = lsp_status.extensions.clangd.setup(),
    init_options = { clangdFileStatus = true },
    cmd = { "clangd-9", "--background-index" },
    capabilities = lsp_status.capabilities,
    on_attach = on_attach
}
]]

require'lspconfig'.pyls.setup{
    capabilities = lsp_status.capabilities,
    on_attach = on_attach,
}

require'lspconfig'.ccls.setup{
    capabilities = lsp_status.capabilities,
    on_attach = on_attach,
    init_options = {
        highlight = { lsRanges = true }
    },
}

local sumneko_path = '/mnt/e/Work/Ubuntu/lua_lsp/lua-language-server/'

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_path .. 'bin/Linux/lua-language-server', "-E", sumneko_path .. "main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
        }
    }
}

require'lspconfig'.bashls.setup{
    on_attach = on_attach
}

require'lspconfig'.vimls.setup{
    on_attach = on_attach
}

vim.lsp.set_log_level("error")

require("trouble").setup {
	action_keys = { -- key mappings for actions in the trouble list
		close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small poup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
  }

end

return M
