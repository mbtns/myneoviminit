" For python support in conda: " conda install -c conda-forge neovim " in shell

" For deoplete python support, make specific conda env to paste the full 
" path to in this file

" PDF viewer for vimtex: Add SumatraPDF to $PATH

"-----------------------------Vim-Plug------------------------------------------
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/AppData/Local/nvim-data/plugged')

" Make sure you use single quotes

"NERDTree is a file system explorer for the Vim editor.
Plug 'preservim/nerdtree'

" This plugin improves Vim's support for editing R code and makes it
" possible to integrate Vim with R. ! Check dependencies (git doc)! 
Plug 'jalvesaq/Nvim-R'

" This is a Vim plugin to support Python development using Conda 
Plug 'cjrh/vim-conda'

" A dark color scheme for Vim/Neovim based off the Material Pale Night color scheme.
Plug 'drewtempelmeyer/palenight.vim'

" Syntax hightlighting cf. Atom.
Plug 'Guzzii/python-syntax' 

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" Highlight the part of a line that doesn't fit into textwidth
Plug 'whatyouhide/vim-lengthmatters'

"Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Deoplete-jedi for python support
Plug 'zchee/deoplete-jedi'

" LaTeX plugin for Neovim
Plug 'lervag/vimtex'

" Automatic quote and bracket completion
Plug 'jiangmiao/auto-pairs'

call plug#end()
"-----------------------------Settings------------------------------------------
" Remap leader key from "\" to space
let mapleader="\<Space>"

" Set encoding to UTF-8
set encoding=utf-8

" Settings for Pale Night color scheme
set background=dark
colorscheme palenight

" To configure lightline for Pale Night:
let g:lightline = { 'colorscheme': 'palenight' }

" Italics for my favorite color scheme
let g:palenight_terminal_italics=1

" To experience the blissfulness of your editor's true colors
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" Enable syntax highlighting.
syntax enable

" Enable line numbers on startup.
set number

" Allow pasting and copying from outside Vim.
set clipboard^=unnamed,unnamedplus

" Display a confirmation dialog when closing an unsaved file.
set confirm

"NERDTReeToggle map to the F6 key.
map <F6> :NERDTreeToggle<CR>

" Set textwidth at 79
set tw=79

" Deoplete.
let g:deoplete#enable_at_startup = 1

" Neosnippet Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" maximum candidate window length
call deoplete#custom#source('_', 'max_menu_width', 79)

" LaTeX
let g:vimtex_compiler_progname = 'nvr'
" This is new style
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" settings for sumatraPDF
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options
    \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" Python
" Full path to conda env for python 3 executable
let g:python3_host_prog = 'C:/Users/MBATENS/AppData/Local/Continuum/miniconda3/envs/neovim3/python'