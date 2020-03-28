execute pathogen#infect()
call pathogen#helptags() 

filetype plugin indent on    " required
set mouse=a

"highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$/

" enable statusbar
set laststatus=2

set tags=tags;/
set ruler
set number

syntax on
"set background=dark

" silence!
set noerrorbells
set novisualbell

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
"set nocompatible
"set smartindent
"set tabstop=4
"set smarttab

" Change tabs on the fly
:nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
:nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
:nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
:nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set showmatch "brace matching
set incsearch "incremental search as you type
set vb t_vb= "stop annoying beep
set tm=500
set hid "change buffer without saving
set cscopetag
"set backspace=2
"set nohls "don't highlight search matches

" d, u : go down and up other window
nmap ,d <C-W>W<C-D><C-W>W
nmap ,u <C-W>W<C-U><C-W>W

" changes directory to that your editing auto
" set autochdir 

" Use GIT for backups
set nobackup
set nowb
set noswapfile

if has ("autocmd")
    augroup default
    "autocmd BufEnter * set textwidth=72 ai formatoptions=tcqn
    augroup END

    " Only turn on C-indenting on C type files
    augroup cprog
      " Remove all cprog autocommands
      " au!
      autocmd FileType c,cpp au! default

      " When starting to edit a file:
      "   For C and C++ files set formatting of comments and set C-indenting on.
      "   For other files switch it off.
      "   Don't change the order, it's important that the line with *
      "     comes first.
      "autocmd FileType *      set formatoptions=tcql nocindent comments&
      "autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
      "autocmd FileType c,cpp  set textwidth=80 ai formatoptions=tcrql
      autocmd FileType c,cpp,  set expandtab
    augroup END
else
    set textwidth=72
endif
"set cinoptions=>1s,e0,n0,f0,{0,}0,^0,:s,=s,l0,gs,hs,ps,t0,+s,c1,C0,(s,u0,U0,w0,m0,j0,)20,*30

" XXX read about Quickfix, speeds up compile edit cycles
if has("quickfix")
  " To disable, use :au! CursorHold
  " au! CursorHold *.[ch] nested call PreviewWord()
  func PreviewWord()
    if &previewwindow           " don't do this in the preview window
      return
    endif
    let w = expand("<cword>")       " get the word under cursor
    if w != ""              " if there is one ":ptag" to it

      " Delete any existing highlight before showing another tag
      silent! wincmd P          " jump to preview window
      if &previewwindow         " if we really get there...
        match none          " delete existing highlight
        wincmd p            " back to old window
      endif

      " Try displaying a matching tag for the word under the cursor
      let v:errmsg = ""
      exe "silent! ptag " . w
      if v:errmsg =~ "tag not found"
        return
      endif

      silent! wincmd P          " jump to preview window
      if &previewwindow     " if we really get there...
     if has("folding")
       silent! .foldopen        " don't want a closed fold
     endif
     call search("$", "b")      " to end of previous line
     let w = substitute(w, '\\', '\\\\', "")
     call search('\<\V' . w . '\>') " position cursor on match
     " Add a match highlight to the word at this position
        hi previewWord term=bold
     exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
        wincmd p            " back to old window
      endif
    endif
  endfun
endif

if has("insert_expand")
  function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
    else
      return "\<C-N>"
  endfunction
  "inoremap <Tab> <C-R>=CleverTab()<CR>
endif

"highlight Search cterm=underline ctermfg=magenta ctermbg=black
"set hlsearch

"if exists("syntax_on")
"  highlight Comment term=bold ctermfg=6
"  let c_space_errors=1
"  let c_ansi_typedefs=1
"  let c_ansi_constants=1
"endif

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
:endfunction
