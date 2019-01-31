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
set nocompatible        " use Vim defaults
set shortmess+=I        " disable the welcome screen
set complete+=k         " enable dictionary completion
set completeopt+=longest
set backspace=2         " full backspacing capabilities
set history=100         " 100 lines of command line history
set laststatus=2
set ruler               " ruler display in status line
set showmode            " show mode at bottom of screen
set cmdheight=2         " set the command height
set showmatch           " show matching brackets (),{},[]
set mat=5               " show matching brackets for 0.5 seconds
set ff=unix             " unix line endings
set autoindent
set smartindent

set directory=~/.vim/swapfiles//
set backupdir=~/.vim/swapfiles//

au BufNewFile,BufRead *.liquid setlocal ft=html

:let g:mapleader = "\<Space>" " remap <leader> key to space

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

  set rtp+=~/gocode/fzf

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

" Better indent support for PHP by making it possible to indent HTML sections
" as well.
"if exists("b:did_indent")
"  finish
"endif
"" This script pulls in the default indent/php.vim with the :runtime command
"" which could re-run this script recursively unless we catch that:
"if exists('s:doing_indent_inits')
"  finish
"endif
"let s:doing_indent_inits = 1
"runtime! indent/html.vim
"unlet b:did_indent
"runtime! indent/php.vim
"unlet s:doing_indent_inits
"function! GetPhpHtmlIndent(lnum)
"  if exists('*HtmlIndent')
"    let html_ind = HtmlIndent()
"  else
"    let html_ind = HtmlIndentGet(a:lnum)
"  endif
"  let php_ind = GetPhpIndent()
"  " priority one for php indent script
"  if php_ind > -1
"    return php_ind
"  endif
"  if html_ind > -1
"    if getline(a:lnum) =~ "^<?" && (0< searchpair('<?', '', '?>', 'nWb')
"          \ || 0 < searchpair('<?', '', '?>', 'nW'))
"      return -1
"    endif
"    return html_ind
"  endif
"  return -1
"endfunction
"setlocal indentexpr=GetPhpHtmlIndent(v:lnum)
"setlocal indentkeys+=<>>
