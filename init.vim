" Configuración de vim
set bg=light

set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ‘:verbose imap <tab>’ to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
" \ pumvisible() ? “\<C-n>” :
"\ <SID>check_back_space() ? “\<TAB>” :
" \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? “\<C-p>” : “\<C-h>”

	syntax on
	set encoding=utf-8
	set number  relativenumber
    set wildmode=longest,list,full
    " split to right
    set splitbelow splitright
    set termguicolors

    " Elimina los espacios en blanco al guardar
    autocmd BufWritePre * %s/\s\+$//e

    " Colum color
    highlight ColorColumn ctermbg=1

    " Plugins
    call plug#begin('~/.vim/plugged')

            " Discord rich presence
            Plug 'vimsence/vimsence'

            " Julia support
            Plug 'JuliaEditorSupport/julia-vim'

            "coc
            Plug 'neoclide/coc.nvim', {'branch': 'release'}

            "Formatter
            Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

            "lightline
            Plug 'itchyny/lightline.vim'

            " Directory tree
            Plug 'scrooloose/nerdtree'

            " Syntax highlight
            Plug 'sheerun/vim-polyglot'

            " Supertab
            Plug 'ervandew/supertab'

            " Catpuccin
            Plug 'catppuccin/vim'

            " Markdown preview
            Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

            Plug 'lervag/vimtex'

            " Vim-Copilot
            Plug 'github/copilot.vim'

        call plug#end()
"Theme color
colorscheme catppuccin_mocha
set laststatus=2
set noshowmode

" markdown preview config
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'

"" Config of vimtex

    " This is necessary for VimTeX to load properly. The "indent" is optional.
    " Note that most plugin managers will do this automatically.
    filetype plugin indent on

    " This enables Vim's and neovim's syntax-related features. Without this, some
    " VimTeX features will not work (see ":help vimtex-requirements" for more
    " info).
    syntax enable

    "viewer method
    let g:vimtex_general_viewer = 'zathura'


" Custom mapings
nmap <leader><leader>p :MarkdownPreview<cr>
nmap <leader>t :NERDTree<cr>

    " Mapeo de teclas
    " leader + r para compilar y ejecutar dependiendo del lenguaje
    nnoremap <silent><leader>r :call CorrerOCompilar()<CR>

    function! CorrerOCompilar()
        let l:file = expand('%')
        let l:extension = expand('%:e')
        if l:ext ==# 'py'
            execute '!python3' l:file
        elseif l:ext ==# 'c'
            execute '!gcc' l:file '-o' expand('%:r') '&&' expand('%:r')
        elseif l:ext ==# 'java'
            execute '!javac' l:file '&&' '!java' expand('%:r')
        elseif l:ext ==# 'rs'
            execute 'cargo run'
        elseif l:ext ==# 'cpp'
            execute '!g++' l:file '-o' expand('%:r') '&&' expand('%:r')
        elseif l:ext ==# 'bash'
            execute '!bash' l:file
        else
            echo 'extension no configurada'
        endif
    endfunction
