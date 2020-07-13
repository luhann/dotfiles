" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Nvim-R editor plugin for neovim
Plug 'jalvesaq/Nvim-R'

" fzf for files searching in vim
Plug 'junegunn/fzf'

" Asynchronous linting
Plug 'w0rp/ale'

" vimtex for neovim
Plug 'lervag/vimtex'

" Plugin to highlight statusline based on current mode
Plug 'itchyny/lightline.vim'

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" Set nvr to allow vimtex to work for Neovim 
let g:vimtex_compiler_progname = 'nvr'

command RStart let oldft=&ft | set ft=r | exe 'set ft='.oldft | let b:IsInRCode = function("DefaultIsInRCode") | normal <LocalLeader>rf

" Initialize pdlugin system
call plug#end()

" Show matching brackets
set showmatch
" Show line number
set number relativenumber
set spell
set spell spelllang=en_gb

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


" Make tab use spaces
set expandtab
" Set tab to use 2 spaces 
set tabstop=2
" Make vim reload file if it detects changes from outside of vim
set autoread
" Remap normal mode command to semi-colon
nnoremap ; :

" Disable line number in terminal window
augroup TerminalStuff
   au! 
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

syntax on

