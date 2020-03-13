" For python support in conda (run from shell): " conda install -c conda-forge neovim " in shell

" PDF viewer for vimtex: Add SumatraPDF to $PATH

" Run "conda install -c conda-forge python-language-server " in each env for language-server support

"-----------------------------Vim-Plug-----------------------------------------
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('C:/Users/MBATENS/AppData/Local/nvim-data/plugged')
" Make sure you use single quotes

"NERDTree is a file system explorer for the Vim editor.
Plug 'preservim/nerdtree'

" This plugin improves Vim's support for editing R code and makes it
" possible to integrate Vim with R. ! Check dependencies (git doc)! 
Plug 'jalvesaq/Nvim-R'

" This is a Vim plugin to support Python development using Conda 
Plug 'cjrh/vim-conda'

" A dark color scheme for Vim/Neovim based off Material Pale Night color scheme.
Plug 'drewtempelmeyer/palenight.vim'

" Syntax hightlighting cf. Atom.
Plug 'Guzzii/python-syntax' 

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" Highlight the part of a line that doesn't fit into textwidth
Plug 'whatyouhide/vim-lengthmatters'

" LaTeX plugin for Neovim
Plug 'lervag/vimtex'

" Coc is an intellisense engine for Vim/Neovim.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"----------------------------Plugin Settings-----------------------------------
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

" settings for sumatraPDF
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options
    \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" Coc settings
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to ensure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> (usually the ENTER key) to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"NERDTReeToggle map to the F6 key.
map <F6> :NERDTreeToggle<CR>

" VimTeX
let g:vimtex_compiler_progname = 'nvr'

" Fix for VimTeX not loading when .tex file is opened
let g:tex_flavor = 'latex'

"----------------------------General Settings---------------------------------
" To map <Esc> to exit terminal-mode:
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
endif

" Set encoding to UTF-8
set encoding=utf-8

" Set textwidth at 79
set tw=79

" Enable syntax highlighting.
syntax enable

" Enable line numbers on startup.
set number

" Allow pasting and copying from outside Vim.
set clipboard^=unnamed,unnamedplus

" Display a confirmation dialog when closing an unsaved file.
set confirm

"----------------------------Language Settings------------------------------------------
" Full path to conda env containing python 2 executable
" For python support in conda (run from shell): " conda install -c conda-forge neovim " in shell
let g:python_host_prog = 'C:/Users/MBATENS/AppData/Local/Continuum/miniconda3/envs/python2_env/python'

" Full path to conda env containing python 3 executable
" For python support in conda (run from shell): " conda install -c conda-forge neovim " in shell
let g:python3_host_prog = 'C:/Users/MBATENS/AppData/Local/Continuum/miniconda3/envs/python3_env/python'

" Neovim remote (Control nvim processes using "nvr" commandline tool)
" Install in separate env " pip install neovim-remote "
let g:vimtex_compiler_progname = 'C:/Users/MBATENS/AppData/Local/Continuum/miniconda3/envs/nvr_env/Scripts/nvr'

" Full path to conda env containing R executable
" Created using " conda create -n r_env r-essentials r-base "
let g:R_host_prog = 'C:\Users\MBATENS\AppData\Local\R\R-3.6.3\bin\x64'
