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
set tabstop=2
set shiftwidth=2
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

" ----- Plugin settings / keymaps ---------------------------------------------

"ctrlp

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

  "airline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
