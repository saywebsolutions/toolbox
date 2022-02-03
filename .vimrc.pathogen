" .vimrc kjones

" ----- Initiate Pathogen -----------------------------------------------------
execute pathogen#infect()

" ----- General settings ------------------------------------------------------
set backspace=indent,eol,start
set number
set showcmd
set incsearch
set hlsearch

" ----- Tabs vs. Spaces -------------------------------------------------------
set tabstop=4
set shiftwidth=4
set expandtab

syntax on               " syntax highlighting
colorscheme desert      " set colorscheme
set t_Co=256
set background=dark
"colorscheme solarized

set nocompatible        " use Vim defaults
set shortmess+=I        " disable the welcome screen
"set complete+=k         " enable dictionary completion
"set completeopt+=longest
set backspace=2         " full backspacing capabilities
set history=100         " 100 lines of command line history
set laststatus=2
"set showmode            " show mode at bottom of screen
set noshowmode          " Disable show mode info
"set ruler               " ruler display in status line
set cmdheight=2         " set the command height
set showmatch           " show matching brackets (),{},[]
set mat=5               " show matching brackets for 0.5 seconds
set ff=unix             " unix line endings
set autoindent
set smartindent

filetype plugin on
"set omnifunc=syntaxcomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

set completeopt=longest,menuone

" ----- supertab settings -----------------------------------------------------

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabCrMapping = 1

" ----- supertab settings end -------------------------------------------------


" ----- lightline settings ----------------------------------------------------

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ } 

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }

"set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

" ----- lightline settings ----------------------------------------------------


set directory=~/.vim/swapfiles//
set backupdir=~/.vim/swapfiles//

au BufNewFile,BufRead *.liquid setlocal ft=html

let g:mapleader = "\<Space>" " remap <leader> key to space

"shortcut to turn off search highlights
map <leader>h :noh<CR>

map <leader>p :set paste!<CR>

function! ToggleLineNumber()
  if v:version > 703
"    set norelativenumber!
  endif
  set nonumber!
endfunction

nnoremap <leader>l :call ToggleLineNumber()<CR>

" ----- gutentags settings ----------------------------------------------------

let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*', '*node_modules*']

" ----- gutentags settings end ------------------------------------------------


" ----- tagbar settings -------------------------------------------------------

"toggle tagbar
nnoremap <leader>t :TagbarToggle<CR>

"autofocus on tagbar window when opened
let g:tagbar_autofocus = 1

"get rid of help boilerplate at top of window
let g:tagbar_compact = 1

let g:tagbar_indent = 1

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
  let g:rooter_patterns = ['.git/']

if executable('fzf')

"fzf

"  set rtp+=~/gocode/fzf
"  set rtp+=~/.fzf/bin/fzf
  set rtp+=~/.fzf

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

  command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})
  " }}}

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


"vim-php-cs-fixer

  " If php-cs-fixer is in $PATH, you don't need to define line below
  " couldn't get the plugin to work without defining this explicitly, even though path was setup correctly
  let g:php_cs_fixer_path = "~/.composer/vendor/bin/php-cs-fixer" " define the path to the php-cs-fixer.phar
  
  " If you use php-cs-fixer version 2.x
"  let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
  let g:php_cs_fixer_rules = "@Symfony"          " options: --rules (default:@PSR2)
  "let g:php_cs_fixer_cache = "~/.php_cs.cache" " options: --cache-file
  "let g:php_cs_fixer_config_file = '.php_cs' " options: --config
  " End of php-cs-fixer version 2 config params
  
  "let g:php_cs_fixer_php_path = "php"               " Path to PHP
  let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
  let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
  let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.


"ultisnips custom snippets dir

  let g:UltiSnipsSnippetDirectories = ["UltiSnips", "my-snippets/UltiSnips"]

autocmd BufNewFile,BufRead *.blade.php set ft=html | set ft=phtml | set ft=blade " Fix blade auto-indent

"from :help php-indent - classic indentation for case/default in switch statements
:let g:PHP_vintage_case_default_indent = 1
