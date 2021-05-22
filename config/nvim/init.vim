let mapleader=','

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" plugins
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'luochen1990/rainbow'
Plug 'Luxed/ayu-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'psliwka/vim-smoothie'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdcommenter'

call plug#end()

" automatically install missing plugins on startup
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | q
            \| endif

" colors and theming
syntax on
set termguicolors
set t_Co=256
set background=dark
let ayucolor="mirage"
colorscheme ayu

hi Comment gui=italic cterm=italic
hi CursorLineNr gui=bold
hi DiffAdd guibg=NONE
hi DiffChange guibg=NONE
hi DiffDelete guibg=NONE
hi SignColumn guibg=NONE

" general configs
set noerrorbells
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set expandtab smarttab autoindent
set number relativenumber
set nowrap
set noswapfile nobackup nowritebackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch ignorecase smartcase hlsearch
set mouse=a
set scrolloff=3 sidescrolloff=15 sidescroll=1
set encoding=utf-8
set emoji
set title
set noshowcmd
"set cursorline
set whichwrap+=<,>,[,],h,l
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set modeline

" perfomance tweaks
set lazyredraw
set re=1
set redrawtime=10000
set scrolljump=5
set synmaxcol=180

" disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set formatoptions-=cro

" use system clipboard
set clipboard+=unnamedplus

nnoremap c "_c
nnoremap d "_d
nnoremap x "_x
vnoremap c "_c
vnoremap d "_d
vnoremap p "_dP

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" custom mappings
nmap <leader>q :bd<CR>
nmap <leader>r :so ~/.config/nvim/init.vim<CR>
nmap <leader>w :w<CR>
nmap <leader>x :noa w<CR>
nmap <leader>z :noa q!<CR>
nmap <S-Tab> :bprevious<CR>
nmap <Tab> :bnext<CR>
noremap <expr> <Down> (v:count == 0 ? 'gj' : 'j')
noremap <expr> <Up> (v:count == 0 ? 'gk' : 'k')
vmap <leader>s :sort iu<CR>
nnoremap ; :
vnoremap ; :

" airline
let g:airline_theme='ayu'
let g:airline_skip_empty_sections = 1
let g:airline_section_warning = ''
let g:airline_section_x=''
let g:airline_section_z = airline#section#create(['%3p%% ', 'linenr', ':%c'])
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let airline#extensions#coc#error_symbol = '✘:'
let airline#extensions#coc#warning_symbol = '⚠:'

" color highligher
lua require'colorizer'.setup()

" semshi
let g:semshi#error_sign	= v:false

" rainbow parantheses
let g:rainbow_active = 1

" disable netrw
let loaded_netrw = 0

" fzf (kanged from Blacksuan19/init.nvim)
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }
let g:fzf_tags_command = 'ctags -R'

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea'"

" fzf if passed argument is a folder
augroup folderarg
    " change working directory to passed directory
    autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | execute 'cd' fnameescape(argv()[0])  | endif

    " start fzf on passed directory
    autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | execute 'Files ' fnameescape(argv()[0]) | endif
augroup END

" files in fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

" advanced grep
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" advanced grep(faster with preview)
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" fzf mappings
nmap <leader>/ :Rg<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>c :Commands<CR>
nmap <leader>gc :Commits<CR>
nmap <leader>gs :GFiles?<CR>
nmap <leader>sh :History/<CR>
nmap <leader>t :BTags<CR>
nnoremap <silent> <leader>f :Files<CR>

" show mapping on all modes with F1
imap <F1> <plug>(fzf-maps-i)
nmap <F1> <plug>(fzf-maps-n)
vmap <F1> <plug>(fzf-maps-x)

" clear highlights with 2 esc presses
noremap <silent><esc><esc> :noh<CR><esc>

" trim whitespaces
au BufWritePre * :%s/\s\+$//e
nnoremap <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" return to last edit position when opening files
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" if you think you can graduate from dis school
" without succing my coc, hehe, you are dead wrong
let g:coc_global_extensions = [
            \'coc-clangd',
            \'coc-css',
            \'coc-git',
            \'coc-html',
            \'coc-json',
            \'coc-lists',
            \'coc-pairs',
            \'coc-prettier',
            \'coc-pyright',
            \'coc-sh',
            \'coc-snippets',
            \'coc-syntax',
            \'coc-xml',
            \'coc-yaml',
            \'coc-yank',
            \]

" close autocomplete popup after autocomplete
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" use K to show documentation in preview window
nnoremap <silent>K :call <SID>show_documentation()<CR>

" apply AutoFix to problem on the current line
nmap <leader>qf <Plug>(coc-fix-current)

" add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" add `:Organize` command for organize imports of the current buffer.
command! -nargs=0 Organize :call CocAction('runCommand', 'editor.action.organizeImport')

" add neovim's native statusline support
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" python renaming
autocmd FileType python nnoremap <leader>rn :Semshi rename <CR>

" functions
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

autocmd filetype c nnoremap <F9> :w <CR> :!gcc % -o %< && clear; ./%< <CR>
autocmd filetype python nnoremap <F9> :w <CR> :!python3 %<CR>

" custom rules for projects and certain filetypes
autocmd BufRead,BufNewFile *.md set wrap lbr
autocmd BufRead,BufNewFile /home/kenhv/projects/mirrorbot/** au! BufWritePre
autocmd BufRead,BufNewFile /mnt/hdd/kernel/** au! BufWritePre
autocmd BufRead,BufNewFile /mnt/hdd/kernel/** set noexpandtab
autocmd BufRead,BufNewFile,BufAdd /mnt/hdd/kernel/** let b:coc_enabled=0
"autocmd BufRead,BufNewFile,BufAdd /home/kenhv/univ/sotc/** let b:coc_enabled=0

" BG Transparency
hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=none
set t_8f=\[[38;2;%lu;%lu;%lum
set t_8b=\[[48;2;%lu;%lu;%lum
hi airline_c ctermbg=NONE guibg=NONE
hi airline_tabfill ctermbg=NONE guibg=NONE
highlight clear LineNr
