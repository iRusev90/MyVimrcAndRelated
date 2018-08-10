" example vim settings from tutorial

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Mar 25
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
"
if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit









"  MY ADDITIONS

" sets indexes  to files and directories
set number
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

"  VUNDLE

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'valloric/youcompleteme'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/emmet-vim'
Plugin 'brookhong/cscope.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'marijnh/tern_for_vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'ornicar/vim-mru'
Plugin 'majutsushi/tagbar'

call vundle#end()            

filetype plugin indent on    " required!

" END VUNDLE 


" UltiSnips
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
"let g:UltiSnipsJumpBackwardTrigger="<c-e>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 3
set rtp+=~/.vim/ultisnips_rep
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsSnippetsDir="~/.vim/ultisnips_rep/UltiSnips"
" END UltiSnips

map <Up> :echo 'pressed Up' <cr>
map <Down> :echo 'pressed Down' <cr>
map <Left> :echo 'pressed left' <cr>
map <Right> :echo 'pressed right' <cr>

"C-D is later remapped to be used by multiple cursor
noremap <S-J> <C-D>  
noremap <S-k> <C-U>

map <c-n> :NERDTreeToggle <CR>

" depricated
map <F2> :lnext <CR>
map <F3> :lprev <CR>
" /depricated

" toggle invisible characters
" set list
 set listchars=tab:>-,trail:.,space:.
 set showbreak=↪

" Syntastic settings
"let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_checkers = ['jshint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = { 'mode': 'passive'} 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_typescript_tsc_args = '--target ES5'
" END syntastic

" vim-javascript settings
let g:javascript_plugin_jsdoc = 1

" END vim-javascript

" emmet settings
let g:user_emmet_install_global = 0
autocmd FileType html,css,xml EmmetInstall
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_leader_key='<c-y>'
" END emmet

" jsbeautify settings
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>
" END jsbeautify

" vim-airline settings
set laststatus=2
let g:airline#extensions#whitespace#checks = ['trailing', 'long']
let g:airline_theme='luna'
" END vim-airline

" vim multiple cursor settings
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" END multicursor settings

" typescript show compilation erros"
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
" END typescript settings

set smartindent
set tabstop=4
set shiftwidth=4
" set expandtab

" macros
let @c = '"+y'
let @v = '"+p'
let @r = ':e!'
let @s = 'ggVG'
let @d = '@sd'
" end macros


" save vim session 
map <F4> :mksession! ~/.vim/backup/vim_session <cr> " Quick write session with F4
map <F5> :source ~/.vim/backup/vim_session <cr>     " And load session with F5

" end save vim session

" Allow saving of files as sudo when I forget to start vim using sudo.
 cmap W! w !sudo tee > /dev/null %


" chage the directory in which all backup files are stored
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/
set udir=~/.vim/backup/

" color scheme
colorscheme monokai

" set vi term colors - without this tmux will lose vim's themes
" set term=screen-256color - breaks split resizing on ubuntu 18.04

"brackets matching 
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

"makes ctrlp and native finds ignore files in the node modules dir.
"NerdTree still shows the folder. Its property is NerdTreeIgnore. 
set wildignore+=**/target/**,**/bower_components/**,**/node_modules/**,**/samples/**

"closes buffers after they've been used
autocmd CompleteDone * pclose

"self explanitory
set relativenumber

let g:netrw_cygwin=0

"without this mouse split resizing in tmux doesn't work
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif
