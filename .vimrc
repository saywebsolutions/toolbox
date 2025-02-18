" .vimrc kjones

set nocompatible        " use Vim defaults

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'github/copilot.vim'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'junegunn/seoul256.vim'

if v:version >= 703
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
endif

Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

Plug 'itchyny/lightline.vim'

Plug 'ludovicchabant/vim-gutentags'

Plug 'wincent/ferret'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'tpope/vim-surround'

"Plug 'ycm-core/YouCompleteMe'

"Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['php', 'javascript', 'markdown', 'go', 'html', 'css', 'json', 'yaml', 'python', 'typescript', 'vim', 'bash', 'sh', 'dockerfile', 'perl', 'sql', 'toml', 'vue', 'xml']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jwalton512/vim-blade', { 'for': 'blade' }

"Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
"Plug 'stephpy/vim-php-cs-fixer', { 'for': 'php' }
"Plug 'friendsofphp/php-cs-fixer', { 'for': 'php' }

"Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }

"Plug 'neoclide/vim-jsx-improve', { 'for': 'javascript' }
"Plug 'neoclide/vim-jsx-improve'
Plug 'pangloss/vim-javascript', { 'for': [ 'javascript', 'svelte' ] }

"
"Plug 'evanleck/vim-svelte', { 'for': 'svelte' }
"Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" trying polyglot instead of individual plugins
"
"Plug 'sheerun/vim-polyglot'
" https://github.com/sheerun/vim-polyglot#autoindent
"let g:polyglot_disabled = ['autoindent', 'php']

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }

Plug 'Keithbsmiley/investigate.vim'

Plug 'ap/vim-css-color'

" Colors
"Plug 'tomasr/molokai'
"Plug 'chriskempson/vim-tomorrow-theme'
"Plug 'morhetz/gruvbox'
"  let g:gruvbox_contrast_dark = 'soft'
"Plug 'yuttie/hydrangea-vim'
"Plug 'tyrannicaltoucan/vim-deep-space'
"Plug 'AlessandroYorba/Despacio'
"Plug 'cocopon/iceberg.vim'
"Plug 'w0ng/vim-hybrid'
"Plug 'nightsense/snow'
"Plug 'nightsense/stellarized'
"Plug 'arcticicestudio/nord-vim'
"Plug 'nightsense/cosmic_latte'

Plug 'vim-vdebug/vdebug', { 'for': 'php' }

call plug#end()

" ----- General settings ------------------------------------------------------
set backspace=indent,eol,start
set number
set showcmd
set incsearch
set hlsearch

" ----- Tabs vs. Spaces -------------------------------------------------------
set expandtab       " Expand TABs to spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4   " Sets the number of columns for a TAB


syntax on               " syntax highlighting

" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
"let g:seoul256_background = 233
colo seoul256
"colo seoul256-light

set updatetime=250
set hidden
set shortmess+=I        " disable the welcome screen
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
"nnoremap <silent> K :call ShowDocumentation()<CR>

"function! ShowDocumentation()
"  if CocAction('hasProvider', 'hover')
"    call CocActionAsync('doHover')
"  else
"    call feedkeys('K', 'in')
"  endif
"endfunction

"set complete+=k         " enable dictionary completion
"set completeopt+=longest
set backspace=2         " full backspacing capabilities
set history=100         " 100 lines of command line history
set laststatus=2
"set showmode            " show mode at bottom of screen
set noshowmode          " Disable show mode info (lightline shows it)
"set ruler               " ruler display in status line
set cmdheight=2         " set the command height
set showmatch           " show matching brackets (),{},[]
set mat=5               " show matching brackets for 0.5 seconds
set ff=unix             " unix line endings
set autoindent
"set smartindent

set switchbuf+=usetab,newtab

filetype plugin on
"set omnifunc=syntaxcomplete#Complete
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP

autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascriptreact setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType typescriptreact setlocal tabstop=2 shiftwidth=2 softtabstop=2

"set completeopt=longest,menuone

" ----- supertab settings -----------------------------------------------------

"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabCrMapping = 1

" ----- supertab settings end -------------------------------------------------

" ----- vdebug settings -------------------------------------------------------

let g:vdebug_options = {
  \  'path_maps': {
  \  '/var/www': '/home/xan/repos/rxdeals',
  \}}

" ----- vdebug settings end ---------------------------------------------------

" ----- lightline settings ----------------------------------------------------

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename',
      \ },
      \ } 

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

"set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

" ----- lightline settings ----------------------------------------------------


set directory=~/.vim/swapfiles//
set backupdir=~/.vim/swapfiles//

au BufNewFile,BufRead *.liquid setlocal ft=html

"let g:mapleader = "\<Space>" " remap <leader> key to space
let g:mapleader = ";" " remap <leader> key to ;

"shortcut to turn off search highlights
map <leader>h :noh<CR>

map <leader>sd :colorscheme seoul256<CR>
map <leader>sl :colorscheme seoul256-light<CR>

map <leader>p :set paste!<CR>

function! ToggleLineNumber()
  if v:version > 703
"    set norelativenumber!
  endif
  set nonumber!
endfunction

map <leader>l :call ToggleLineNumber()<CR>

function! PromptList(prompt, list)
    let l:copy = copy(a:list)
    for i in range(len(l:copy))
        let l:copy[i] = (i + 1) . '. ' . l:copy[i]
    endfor
    let l:ret = inputlist([a:prompt] + l:copy)
    if l:ret > 0 && l:ret < len(a:list)
        return a:list[l:ret - 1]
    else
        return ''
    endif
endfunction

function! ChangeColorscheme()
    " Get a sorted list with the available color schemes.
    let l:list = sort(map(
                \ split(globpath(&runtimepath, 'colors/*.vim'), '\n'),
                \ 'fnamemodify(v:val, ":t:r")'))

    let l:prompt = 'Current color scheme is ' . g:colors_name
    let l:color = PromptList(l:prompt, l:list)
    if l:color != ''
        exec 'colorscheme' l:color
    endif
endfunction

map <leader>cc :call ChangeColorscheme()<CR>

" ----- gutentags settings ----------------------------------------------------
let g:gutentags_ctags_extra_args = ['--php-kinds=cfit']

let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*', '*node_modules*',
                            \ '.vapor/*']

" ----- gutentags settings end ------------------------------------------------


" ----- tagbar settings -------------------------------------------------------

"toggle tagbar
map <leader>t :TagbarToggle<CR>

"autofocus on tagbar window when opened
let g:tagbar_autofocus = 1

"get rid of help boilerplate at top of window
let g:tagbar_compact = 1

let g:tagbar_indent = 1

let g:tagbar_sort = 0

" ----- tagbar settings end ---------------------------------------------------


"set cursorline         " underline current line

" ----- netrw settings --------------------------------------------------------
" absolute width of netrw window
let g:netrw_winsize = -28

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" open file in a new tab
let g:netrw_browse_split = 3

" ----- Plugin settings / keymaps ---------------------------------------------

"vim-rooter
"  let g:rooter_patterns = ['.git/']

if executable('fzf')

"fzf

"  set rtp+=~/gocode/fzf
  set rtp+=~/.fzf/bin/fzf
"  set rtp+=~/.fzf

  " FZF {{{
  " <S-p> to search files
  nnoremap <silent> <S-p> :FZF -m<cr>

  " <M-p> for open buffers
  nnoremap <silent> <M-p> :Buffers<cr>

  " <M-S-p> for MRU
  nnoremap <silent> <M-S-p> :History<cr>

  " Use fuzzy completion relative filepaths across directory
  imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

  " Better command history with q:
  command! CmdHist call fzf#vim#command_history({'right': '40'})
  nnoremap q: :CmdHist<CR>

  " Better search history
  command! QHist call fzf#vim#search_history({'right': '40'})
  nnoremap q/ :QHist<CR>

"  command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': '--no-color'})

  " Default options are --nogroup --column --color
"  let s:ag_options = ' --one-device --skip-vcs-ignores --smart-case '
"  let s:ag_options = ' --nogroup --column --color '

"  command! -bang -nargs=* Ack
"        \ call fzf#vim#ag(
"        \   <q-args>,
"        \   s:ag_options,
"        \  <bang>0 ? fzf#vim#with_preview('up:60%')
"        \        : fzf#vim#with_preview('right:50%:hidden', '?'),
"        \   <bang>0
"        \ )

command! -bang -nargs=* Ack
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

else

" CtrlP fallback

  "let g:ctrlp_map = '<c-p>'
  let g:ctrlp_map = '<S-p>'
  let g:ctrlp_cmd = 'CtrlP'

  "exclude certain files from lookup
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"  let g:ctrlp_custom_ignore = {
"    \ 'dir':  '\v[\/]\.(git|hg|svn)$,node_modules',
"    \ 'file': '\v\.(exe|so|dll)$',
"    \ 'link': 'some_bad_symbolic_links',
"    \ }
  let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

  "default to open in a new vim tab
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

end

"neomake for linting https://github.com/neomake/neomake
"  call neomake#configure#automake('nrwi', 500)

"airline

"  let g:airline#extensions#tabline#enabled = 1
"  let g:airline_powerline_fonts = 1
"  let g:airline_theme='understated'

"ultisnips custom snippets dir

  let g:UltiSnipsSnippetDirectories = ["UltiSnips", "my-snippets/UltiSnips"]

"autocmd BufNewFile,BufRead *.blade.php set ft=html | set ft=phtml | set ft=blade " Fix blade auto-indent

"from :help php-indent - classic indentation for case/default in switch statements
:let g:PHP_vintage_case_default_indent = 1

" ----------------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------------
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -n -e TODO 2> /dev/null',
            \ 'grep -rn -e TODO * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()

let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-blade', 'coc-html', 'coc-phpls', 'coc-snippets', 'coc-go', 'coc-php-cs-fixer', 'coc-tsserver', 'coc-eslint', 'coc-deno']

imap <silent><script><expr> <C-P> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

"https://www.sinisterstuf.org/blog/1065/slugify-text-in-vim
command! Slugify call setline('.', join(split(tolower(substitute(iconv(getline('.'), 'utf8', 'ascii//TRANSLIT'), "[\"']", '', 'g')), '\W\+'), '-'))

" URL encode/decode selection
vnoremap <leader>en :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <leader>de :!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>

" remap arrows to resize viewport
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
nnoremap <Up> :resize -5<CR>
nnoremap <Down> :resize +5<CR>

" show documentation in preview window
map <leader>d :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! ScrollPopup(nlines)
    let winids = popup_list()
    if len(winids) == 0
        return
    endif

    " Ignore hidden popups
    let prop = popup_getpos(winids[0])
    if prop.visible != 1
        return
    endif

    let firstline = prop.firstline + a:nlines
    let buf_lastline = str2nr(trim(win_execute(winids[0], "echo line('$')")))
    if firstline < 1
        let firstline = 1
    elseif prop.lastline + a:nlines > buf_lastline
        let firstline = buf_lastline + prop.firstline - prop.lastline
    endif

    call popup_setoptions(winids[0], {'firstline': firstline})
endfunction

nnoremap <C-j> :call ScrollPopup(3)<CR>
nnoremap <C-k> :call ScrollPopup(-3)<CR>

"function! IPhpInsertUse()
"    call PhpInsertUse()
"    call feedkeys('a',  'n')
"endfunction
"autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
"autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

"autocmd FileType php inoremap <C-s> <Esc>:call PhpSortUse()<CR>
"autocmd FileType php noremap <C-s> :call PhpSortUse()<CR>
"let g:php_namespace_sort_after_insert = 1

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
