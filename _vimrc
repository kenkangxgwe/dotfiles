set nocompatible

" Vundle
" ================================================================
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$VIMRUNTIME/bundle/Vundle.vim/
call vundle#begin('$VIMRUNTIME/bundle/')
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'unblevable/quick-scope'
Plugin 'vim-latex/vim-latex'
Plugin 'rsmenon/vim-mathematica'
Plugin 'mattn/emmet-vim'
Plugin 'chriskempson/base16-vim'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'sheerun/vim-polyglot'
Plugin 'lilydjwg/colorizer'
Plugin 'itchyny/thumbnail.vim'
Plugin 'vim-scripts/loremipsum'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" Plugin 'Valloric/YouCompleteMe'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this linesource $VIMRUNTIME/vimrc_example.vim
" =========================================================

filetype on
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin
" let $TMP="C:\Program Files (x86)\Vim\vim74\tmp"

" 使用中文帮助文档
set helplang=cn

" Set mapleader 
let mapleader = "," 
let g:mapleader = ","

" Set undofile
set noundofile

" 显示行号 
set nu

" 设置光标坐标
set cul

" 打开语法高亮 
syntax on

" 设置Tab宽度
set softtabstop=4 
set shiftwidth=4
set noet!

" 关闭自动备份 
set nobackup

" 自动缩进设置 
filetype indent on
set cindent 
set smartindent 
set incsearch 
set autoindent

" 配色
colorscheme koehler

" 字体
set guifont=Source_Code_Pro:h12

" 提示音
set noeb

" Show matching bracets 
set showmatch

" Get out of VI's compatible mode 
set nocompatible

" Have the mouse enabled all the time 
" set mouse=a

" Set to auto read when a file is changed from the outside 
set autoread

" Enable filetype plugin 
filetype plugin on 

" 设置搜索结果高亮显示 
" set hlsearch

" 设置记录的历史操作列表 
set history=50

" 设置折叠 
set foldcolumn=0 
set foldmethod=marker

" quick-scope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" 显示特殊符号
" set list
" set listchars=tab:\|\ ,extends:>,precedes:<

" LaTeX
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
" set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:
let g:Tex_DefaultTargetFormat='pdf'
" let g:Tex_CompileRule_pdf = 'pdflatex --synctex=-1 -src-specials -interaction=nonstopmode $*'
" let g:Tex_CompileRule_pdf = 'xelatex --synctex=-1 -src-specials -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'lualatex --synctex=-1 -src-specials -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'sumatrapdf -reuse-instance -inverse-search "gvim -c \":RemoteOpen +\%l \%f\"" '

" Diff============================================================================
" set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction



" Aspell
map  :w!<CR>:!aspell check %<CR>:e! %<CR>


" AutoCommand===================================================================== 
" 新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.[ch],*.sh,*.java exec ":call SetTitle()" 
" 新建文件后，自动定位到文件末尾 
autocmd BufNewFile * normal G

" 设置程序的运行和调试的快捷键F5和Ctrl-F5 
map <F5> :call CompileRun()<CR> 
map <C-F5> :call Debug()<CR>

" 使用<leader>e打开当前文件同目录中的文件 
if has("unix") 
map ,e :e <C-R>=expand("%:p:h") . "\" <CR> 
else 
map ,e :e <C-R>=expand("%:p:h") . "\" <CR> 
endif

" 定义CompileRun函数，用来调用进行编译和运行 
func CompileRun() 
exec "w" 
" C程序 
if &filetype == 'c' 
exec "!gcc -Wall % -g -o %<.exe"
exec "!%<" 
" C++程序
elseif &filetype == 'cpp'
exec ":!g++ -Wall % -g -o %<.exe"
exec "!%<" 
" Python 程序
elseif &filetype == 'python'
exec ":!python %"
endif
endfunc 
" 结束定义CompileRun 

" 定义Debug函数，用来调试程序 
func Debug() 
exec "w" 
" C程序 
if &filetype == 'c'
exec "!gcc % -g -o %<" 
" C++程序
elseif &filetype == 'cpp'
exec ":!g++ % -g -o %<.exe"
endif
exec "!gdb %<"  
endfunc 
" 结束定义Debug
