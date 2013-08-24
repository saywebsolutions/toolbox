" .vimrc kjones

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
set ruler               " ruler display in status line
set showmode            " show mode at bottom of screen
set cmdheight=2         " set the command height
set showmatch           " show matching brackets (),{},[]
set mat=5               " show matching brackets for 0.5 seconds
set ff=unix             " unix line endings
