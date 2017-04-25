
" Vundle setup
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'               " Fuzzy file search
Plugin 'elixir-lang/vim-elixir'           " Elixir support
Plugin 'jceb/vim-orgmode'                 " Org mode
Plugin 'ludovicchabant/vim-gutentags'     " Automatic ctags generation
Plugin 'mileszs/ack.vim'                  " Use Ag for search
Plugin 'mortice/pbcopy.vim'               " Easy copy paste in terminal vim
Plugin 'nanotech/jellybeans.vim'          " Jellybeans color scheme
Plugin 'rizzatti/dash.vim'                " Documentation lookup using Dash.app
Plugin 'terryma/vim-multiple-cursors'     " Sublime text style multiple cursors
Plugin 'Townk/vim-autoclose'              " Insert matching pair () {} []
Plugin 'tpope/vim-commentary'             " Toggle comments easily
Plugin 'tpope/vim-fugitive'               " Git wrapper
Plugin 'tpope/vim-rails'                  " Rails support
Plugin 'tpope/vim-surround'               " Easily change quotes/bracket pairs
Plugin 'tpope/vim-speeddating'            " Inc/decrement dates - Needed by vim-orgmode
Plugin 'tpope/vim-unimpaired'             " Misc mappings like ]<space> or ]c
Plugin 'vim-ruby/vim-ruby'                " Ruby support

call vundle#end()

filetype plugin indent on
" End of Vundle setup

syntax on

colorscheme jellybeans

set autoindent                  " Indent: Copy indent from current line when starting new line
set expandtab                   " Tab settings - Use spaces to insert a tab
set backupdir=~/.tmp            " Don't clutter my dirs with swp/tmp files
set colorcolumn=80              " Show vertical bar to indicate 80 chars
set directory=~/.tmp            " Don't clutter my dirs with swp/tmp files
set hlsearch                    " Search: Highlight results
set ignorecase smartcase        " Search: ignore case, unless uppercase chars given
set incsearch                   " Search: Show results as you type
set laststatus=2                " Always show status line
set list                        " Show tabs and trailing whitespace
set listchars=tab:>-,trail:·    " Set chars to show for tabs or trailing whitespace
set relativenumber number       " Line numbers: Show current #, but use relative #s elsewhere
set shiftround                  " Indentation: When at 3 spaces, >> takes to 4, not 5
set shiftwidth=2                " Tab settings - Use 2 spaces for each indent level
set softtabstop=2               " Tab settings - Count 2 spaces in editing operations
set splitbelow                  " Open new split panes below
set splitright                  " Open new split panes to the right
set wildmode=list:longest       " Command mode tab completion - complete upto ambiguity


" Status line configuration
set statusline=%m\ %f
set statusline+=\ %{fugitive#statusline()}
set statusline+=%=%l/%L\ [%P]\ C:%c

highlight StatusLine ctermfg=white ctermbg=blue


" Enable extended matching with %
runtime macros/matchit.vim


" Use ag for text search
let g:ackprg = 'ag --vimgrep'

" CtrlP customization
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0

" Don't pollute all projects with tags file. Put them all on one place
let g:gutentags_cache_dir = '~/.tags_cache'


" Create a directory for the current file if it does not exist.
augroup Mkdir
  autocmd!
  autocmd BufWritePre *
    \ if !isdirectory(expand("<afile>:p:h")) |
        \ call mkdir(expand("<afile>:p:h"), "p") |
    \ endif
augroup END


function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

" Leader key settings

let mapleader = ","

nmap <leader>bi   :source ~/.vimrc<cr>:PluginInstall<cr>
map  <leader>dd   :Dash<cr>
map  <leader>f    :Ack<space>
map  <leader>gs   :Gstatus<cr>
map  <leader>mv   :call RenameFile()<cr>
map  <leader>n    :nohl<cr>
map  <leader>q    :bd<cr>
map  <leader>gg   :tabe ~/Dropbox/org/main.org<cr>
map  <leader>rc   :Econtroller
map  <leader>rm   :!rm %
map  <leader>rv   :Eview
map  <leader>s    :A<cr>
map  <leader>vi   :tabe ~/.vimrc<cr>
map  <leader>vs   :vsplit<cr>
map  <leader>vn   :vnew<cr>:CtrlP<cr>

map K   <nop>
map Q   @q

vmap <F2> :w !pbcopy<CR><CR>
map  <F3> :r !pbpaste<CR>

nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

map  <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Disable arrow keys
map  <up>    <nop>
imap <up>    <nop>
map  <down>  <nop>
imap <down>  <nop>
map  <left>  <nop>
imap <left>  <nop>
map  <right> <nop>
imap <right> <nop>

" I often mistype Q and Wq
command! Q  q
command! Wq wq
