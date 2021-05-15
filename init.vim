call plug#begin('~/.vim/plugged')
Plug 'ycm-core/YouCompleteMe', { 'on' : [] }
Plug 'arakashic/chromatica.nvim', { 'on' : []}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'wellle/context.vim'
Plug 'junegunn/fzf.vim'
Plug 'numirias/semshi', {'on' : [], 'do': ':UpdateRemotePlugins'}
Plug 'huawenyu/neogdb.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'wadackel/vim-dogrun'

Plug 'mhartington/oceanic-next'
Plug 'lifepillar/vim-gruvbox8'

Plug 'Yggdroot/indentLine'
Plug 'franbach/miramare'

" LSP plugins
"Plug 'neovim/nvim-lspconfig'
Plug 'Badhi/nvim-lspconfig'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

"ccls based highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'

" debugger
Plug 'puremourning/vimspector'

"colorscheme
Plug 'chuling/vim-equinusocio-material'
Plug 'folke/tokyonight.nvim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'folke/lsp-colors.nvim'

Plug 'tpope/vim-commentary'

"python autocomplete
Plug 'zchee/deoplete-jedi', { 'on' : [] }
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'ryanoasis/vim-devicons'

call plug#end()

"set tabstop=4
"set shiftwidth=4
"set expandtab

set termguicolors
set guifont=Caskaydia\ Cove\ Nerd\ Font\ Complete\ 10
set encoding=utf8
let g:airline_powerline_fonts = 1

" Theme
syntax enable
"colorscheme OceanicNext
"colorscheme gruvbox8

let g:tokyonight_style = "night"
colorscheme tokyonight

let g:airline_theme='dracula'

set cursorline 

hi CursorLine   cterm=NONE ctermbg=238 ctermfg=None guibg=Grey11 guifg=None
autocmd InsertEnter <buffer> highlight  CursorLine ctermbg=238 ctermfg=None guibg=DarkGreen
autocmd InsertLeave <buffer> highlight  CursorLine ctermbg=white ctermfg=None guibg=Grey11

set tabstop=4 shiftwidth=4 expandtab
set number relativenumber

let g:indentLine_char_list = ['|']


let g:ycm_confirm_extra_conf = 0
let g:ycm_auto_trigger=0


set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list=['exact', 'substring', 'fuzzy']

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
setlocal omnifunc=v:lua.vim.lsp.omnifunc

let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

lua << EOF
require'bhashitha_init'.setup()
EOF

let g:airline#extensions#nvimlsp#enabled = 0

function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
        return luaeval("require('lsp-status').status()")
    endif
    return ''
endfunction

call airline#parts#define_function('lsp_status', 'LspStatus')
function! AirlineLspStatus()
   let g:airline_section_x = airline#section#create_right(['lsp_status', 'filetype'])
endfunction
call AirlineLspStatus()
autocmd VimEnter * call AirlineLspStatus()

nnoremap <silent> af    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" CDC = Change to Directory of Current file
command CDC cd %:p:h

" vimspecter

let g:vimspector_enable_mappings='HUMAN'
