
if has('python3')
  silent! python3 1
endif


" COMMENTING MULTIPLE LINES the old way
" ctrl-V to enter Visual mode, use arrow keys or j/k to select lines
" press I to go into insert mode
" Type commend character to put at the beginning of the line. Press ESC
""
" UNCOMMENTING
" ESC to command mode
" press ctrl-v to enter visual mode
" use arrow keys or j/k to select lines
" press x to delete comments

set nocompatible              " be iMproved, required
filetype off                  " required

" VimPlug walk :-)
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-emoji'
call plug#end()


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'w0rp/ale'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'tomasr/molokai'
Bundle 'wakatime/vim-wakatime'
Plugin 'google/yapf'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'terryma/vim-multiple-cursors'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""" PATHOGEN """""
"""""""""""""""""""
execute pathogen#infect()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           reset vimrc augroup                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
  autocmd!
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""
"" NERDTREE
"""""""""""""""""
"""" NERDTREE open it when opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Map toggling the tree using CTRL + n
map <C-n> :NERDTreeToggle<CR>
" Show hidden files by default: dont use (i)
let NERDTreeShowHidden=1

" open nerd tree automagically when vim starts
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

if isdirectory(expand("~/.vim/plugged/nerdtree/"))

  let NERDTreeIgnore = ['\~$', '\.sw.$', '\.pyc$', '.DS_Store']

  " NERDTree's File highlighting
  function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
  endfunction

  autocmd VimEnter * call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
  autocmd VimEnter * call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868',
  '#151515')
endif

"""""""""""""""""""""""""
"" YOUCOMPLETEME
"""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion=1

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
" YCM should use python 3 for autocompletions
let g:ycm_python_binary_path = 'python3'

" Remap the f5 key to be used for recompiling ycm when needed
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

"""""""""""""""""""""""""
"" GOOGLE FORMATTER
"""""""""""""""""""""""""
"" Format python code to be pep8ed
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr><C-q>
let g:yapf_style = "pep8"

""""""""""""""""""""""""
""" GIT GUTTER symbols
""""""""""""""""""""""""
let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
let g:gitgutter_sign_modified_removed = emoji#for('collision')


" Emoji completion
set completefunc=emoji#complete


""""""" CONTROLP""""""""""""""""
" IGNORE SOME FILES WHEN SEARCHING
"""""""""""""""""""""""""""""""""""
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']

""""""""""""""""""""""""""""""""
""" PYTHON
""""""""""""""""""""""""""""""""
"python with virtualenv support
:py3 << EOF
import os
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin', 'activate_this.py')
  if os.path.exists(activate_this):
    exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'), dict(__file__=activate_this))
EOF

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JS, CSS, HTML
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = { 'javascript': ['eslint'], }

" Automatically fix code on save
let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_use_global = 1

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline and airline theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if isdirectory(expand("~/.vim/plugged/vim-airline/"))
  if isdirectory(expand("~/.vim/plugged/vim-airline-themes/"))
    let g:airline_theme="molokai"
  endif

  let g:airline_powerline_fonts = 1
  let g:airline#extensions#branch#enabled = 1
  " Automatically display all buffers when there's only one tab open
  let g:airline#extensions#syntastic#enabled = 1

  "" Improve the contract for inactive statusline
  let g:airline_base16_improved_contrast = 1

  let g:airline_molokai_bright = 1

  " Airline-tabline
  "
  "Enable enhanced tabline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_close_button = 1    " default 1
  let g:airline#extensions#tabline#close_symbol = 'X'
endif

function! RefreshUI()
  if exists(':AirlineRefresh')
    AirlineRefresh
  else
    redraw!
    redrawstatus!
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme hybrid
set background=dark
set scrolloff=2        " 2 lines above/below cursor when scolling
set showmatch          " show matching bracket
set matchtime=2        " reduce matching parenthesis blink time from the 5[00]ms default
set showmode           " show mode in status bar (insert/replace/...)
set showcmd            " show typed command in status bar
set ruler              " show cursor position in status bar
set title              " show file in titlebar
set undofile           " store undo state even when hte files are closed (in undodir)
set cursorline         " highlights the current line
set winaltkeys=no      " turns of the Alt key bindings to gui menu
set wildmenu           " completion with menu

" When you type first tab, it will complete as much as possible,
" Second tab will provide a list and third tab and others will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set completeopt=menu,menuone,longest
set switchbuf=useopen,usetab
set listchars=tab:▸\ ,eol:¬

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editor settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase              " case insensitive searching
set smartcase               " be case sensitive if you type uppercase characters
set autoindent              " on new lines, match indent of previous line
set copyindent              " copy the previous indentation on autoindenting
set cindent                 " smart indenting for c-like code
set smartindent             " smart auto indenting .might cause problems with some filetypes
set cino=b1,g0,N-s,t0,(0,W4 " see h: cinoptions-values
set smarttab                " smart tab handling for indenting
set magic                   " change the way backlashes are used in regex search patterns
set bs=indent,eol,start     " allow backspacing over everything in insert mode
set nobackup                " no backup~ files

set tabstop=2           " number of spaces a tab counts for
set shiftwidth=2        " spaces for autoindents
set softtabstop=2
set shiftround

set laststatus=2            " always show the statusline
set expandtab               " turn tab into spaces
" configure standard 4 spaces for tabs
" ensure line length doesn't go beyond 80 characters
" and store file in a unix format to prevent conversion issues on github
au BufNewFile,BufRead *.py
    \ set tabstop=4     |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set textwidth=80  |
    \ set expandtab     |
    \ set autoindent    |
    \ set fileformat=unix


" Set tab space to 2 for js html and css files
au BufNewFile,BufRead *.js, *.html, *.css
     \ set tabstop=2     |
     \ set softtabstop=2 |
     \ set shiftwidth=2

" Highlight Class and Function names
function! s:HighlightFunctionsAndClasses()
  syn match cCustomFunc      "\w\+\s*\((\)\@="
  syn match cCustomClass     "\w\+\s*\(::\)\@="

  hi def link cCustomFunc      Function
  hi def link cCustomClass     Function
endfunction

" Highlight Class and Function names, D specific
function! s:HighlightDFunctionsAndClasses()
  syn match cCustomDFunc     "\w\+\s*\(!.\{-}(\)\@="
  syn match cCustomDFuncUFCS ".\w\+\s*\(!.\{-}\)\@="

  hi def link cCustomDFunc     Function
  hi def link cCustomDFuncUFCS Function
endfunction

" TODO: this should:
" a) not be called for every filetype
" b) be in a separate plugin
au vimrc Syntax * call s:HighlightFunctionsAndClasses()
au vimrc Syntax d call s:HighlightDFunctionsAndClasses()


set noshowmode  " dont show the mode ("-- INSERT --") at the bottom

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set fileformat=unix          " file mode is unix
set fileformats=unix,dos,mac " detect unix. dos, mac file formats in that order
set mouse=a                  " enable mouse in all modes
set history=1000             " remember more commands and search history
set autoread                 " auto read when a file is changed from the outside
set foldlevelstart=99        " all folds open by default

" toggle vim paste mode; turning it on prevents insertion of extra whitespace
set pastetoggle=<F7>
set mousemodel=popup_setpos  " right-click on selection should bring up a menu
syntax on                    " enable syntax highlighting
let g:is_posix = 1           " highlight shell scripts as bash scripts, not sh scripts

set shortmess=a              " avoid annoying 'hit enter to continue' messages
set cmdheight=2              " number of screen lines to use for the command-line
set whichwrap+=<,>h,l        " allow backspace and cursor keys to cross line boundaries
set hlsearch               " don't highlight searched-for phrases
set incsearch                " but do highlight as I type the search string
set gdefault                 " make search/replace global by default
set textwidth=80             " enforce line-length
set colorcolumn=+1           " makes the color after the textwidth column highlighted
" turns off all error bells, even visual
set noerrorbells visualbell t_vb=
" autocmd vimrc GUIEnter * set visualbell t_vb=

if v:version >= 704
  " The new Vim regex engine is currently slooooow as hell which makes syntax
  " highlighting slow, which introduces typing latency.
  " Consider removing this in the future when the new regex engine becomes
  " faster.
  set regexpengine=1
endif

" By default, Vim will not use the system clipboard when yanking/pasting to
" the default register. This option makes Vim use the system default
" clipboard.
if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  " Use the OS clipboard by default (on versions compiled with `+clipboard`)
  set clipboard+=unnamed
endif

" .pdsc files are JSON
autocmd vimrc BufEnter *.pdsc setf json

" .conf files are conf
autocmd vimrc BufEnter *.conf setf conf

" .acl files are YAML
autocmd vimrc BufEnter *.acl setf yaml

"""""""""""""""""""""""""""""""
" More tweaks
""""""""""""""""""""""""""""""

" Unicode support (taken from http://vim.wikia.com/wiki/Working_with_Unicode)
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

augroup vimrc
  " Automatically delete trailing DOS-returns and whitespace on file open and
  " write.
  autocmd BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//
augroup END

" Enhance command-line completion
set wildmenu

" Allow cursor keys in insert mode
set esckeys

" Optimize for fast terminal connections
set ttyfast

" Don’t add empty newlines at the end of files
set binary
set noeol

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Allow backspace in insert mode
set backspace=indent,eol,start

" Respect modeline in files
set modeline
set modelines=4

" Use system clipboard to copy
map <C-c> "+y<CR>

" Don't redraw while executing macros (good performance config)
set lazyredraw

" How many tenths of a second to blink when matching brackets
set mat=2

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" :w!! sudo saves the file
" This command will allow us to save a file we don't have permission to save
" *after* we have already opened it. Super useful.
cnoremap w!! w !sudo tee % >/dev/null

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Enable line numbers
set number

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linebreak
set lbr
set tw=99

set wrap "Wrap lines

" Fold methods
set foldmethod=indent

" Enable folding with the spacebar
nnoremap <space> za

" Don’t reset cursor to start of line when moving around.
set nostartofline


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
nnoremap <leader>w :w!<cr>

" this makes vim's regex engine "not stupid"
" see :h magic
nnoremap / /\v
vnoremap / /\v

" Source $MYVIMRC reloads the saved $MYVIMRC
nmap <silent> <Leader>S :source $MYVIMRC<CR>:call RefreshUI()<CR>

" With this map, we can select some text in visual mode and by invoking the map,
" have the selection automatically filled in as the search text and the cursor
" placed in the position for typing the replacement text. Also, this will ask
" for confirmation before it replaces any instance of the search text in the
" file.
" NOTE: We're using %S here instead of %s; the capital S version comes from the
" eregex.vim plugin and uses Perl-style regular expressions.
vnoremap <C-r> "hy:%S/<C-r>h//c<left><left>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Using '<' and '>' in visual mode to shift code by a tab-width left/right by
" default exits visual mode. With this mapping we remain in visual mode after
" such an operation.
vnoremap < <gv
vnoremap > >gv

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nowb
set noswapfile

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

""""""""""""""""""""""""""""""
" Visual mode search selection
""""""""""""""""""""""""""""""
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        execute "Ack " . l:pattern . ' %'
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"Basically you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>