" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" NERDTree file icon
Plug 'ryanoasis/vim-devicons'

" Vim Satus line
"Airline and airline themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Vim Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'benmills/vimux'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" Git supports for vim
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Syntax checker
Plug 'w0rp/ale'

"Vim commenter
Plug 'scrooloose/nerdcommenter'

"All language syntax highlighting
Plug 'sheerun/vim-polyglot'

call plug#end()
