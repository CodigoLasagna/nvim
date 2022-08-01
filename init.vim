"""Load and install Plugins"""
call plug#begin()
	Plug 'preservim/nerdtree' |
		\ Plug 'Xuyuanp/nerdtree-git-plugin' |
		\ Plug 'ryanoasis/vim-devicons'
	Plug 'vimsence/vimsence'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
	Plug 'lambdalisue/suda.vim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'norcalli/nvim-colorizer.lua'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'stevearc/vim-arduino'
	Plug 'Raimondi/delimitMate'
	Plug 'junegunn/limelight.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'tpope/vim-repeat'
	Plug 'bfrg/vim-cpp-modern'
	Plug 'wfxr/minimap.vim'
	Plug 'pacha/vem-tabline'
	Plug 'honza/vim-snippets'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	"" Plugins for writing
	Plug 'dpelle/vim-LanguageTool'
	Plug 'lervag/vimtex'
call plug#end()

"""Plugin Options"""
""Vimsence""
let g:vimsence_client_id = '439476230543245312'
let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'
let g:vimsence_editing_details = 'Editing: {}'
let g:vimsence_editing_state = 'Working on: {}'
let g:vimsence_file_explorer_text = 'In NERDTree'
let g:vimsence_file_explorer_details = 'Looking for files'
""Nerd Tree"
let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
autocmd VimEnter * NERDTree
autocmd VimEnter * NERDTree /home/ynwrdcreso/fractalis/work/
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeGitStatusUseNerdFonts = 1
set updatetime=100
""Minimap""
let g:minimap_width = 10
let g:minimap_auto_start_win_enter = 1
let g:minimap_highlight_range = 1
let g:minimap_git_colors = 1
"IconsPadding"
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
"gitgutter"
let g:gitgutter_highlight_linenrs = 1
"LanguageTool"
let g:languagetool_cmd='java -jar $HOME/fractalis/programs/software/LanguageTool-5.7/languagetool-commandline.jar'
set spelllang=es
"VimTex"
let g:vimtex_view_method = 'zathura'
"""Custom Funcions"""
"Meow"
function Meow()
	echo "Meow!"
endfunction

"Distraction free mode"
let g:focused = 0
function! Focus()
	let g:focused = 1 - g:focused
	
	if g:focused == 1
		:Goyo 80
		:Limelight
		
		set nocursorline
		set noshowmode
		set relativenumber
		set number
		
		nmap G Gzz
		noremap k jzz
		noremap l kzz
		
		:silent !xdotool key --repeat 2 Ctrl+plus
	else
		:Goyo!
		:Limelight!
		set cursorline
		set showmode
		
		noremap k j
		noremap l k
		unmap G
		
		:silent !xdotool key --repeat 2 Ctrl+minus
		:silent !xdotool key Ctrl+equal
	endif
endfunction
let g:writing = 0
function! Writing()
	let g:focused = 1 - g:focused
	
	if g:focused == 1
		:Goyo 80
		:Limelight
		
		set nocursorline
		set noshowmode
		nmap G Gzz
		noremap k jzz
		noremap l kzz
		
		silent !bash plusfont.sh
	else
		:Goyo!
		:Limelight!
		
		set cursorline
		set showmode
		
		noremap k j
		noremap l k
		unmap G
		
		:silent !bash minusfont.sh
	endif
endfunction

function Compile()
	:w
	:let file_d=expand('%:p')
	:let line=getline(1)
	if &filetype ==# 'python'
		if line ==# '# i'
			:make
			:echo 'Interactive Mode'
			:vs|term python -i %
		else
			:make
			:echo 'Normal mode'
			:vs|:term python %
		endif
	elseif &filetype ==# 'c' || &filetype ==# 'cpp'
		if line ==# '//nr'
			:e ../main.cpp
			:make
			:make cleanO
			:execute 'e' fnameescape(file_d)
			:vs|:term '../main'
		elseif line ==# '//nr 1'
			:e ../../main.cpp
			:make
			:make cleanO
			:execute 'e' fnameescape(file_d)
			:vs|:term '../../main'
		else
			:make
			:vs|:term ./main
		endif
	elseif &filetype ==# 'javascript'
		if line ==# '//nodejs'
			:sp|:resize 15|:term node %
		elseif line ==# '//nodejs dm'
			:sp|:resize 15|:term npm start
		endif
	elseif &filetype ==# 'tex'
		:silent !zathura *.pdf & disown
	elseif &filetype ==# 'html'
		:!qutebrowser % &
	elseif &filetype ==# 'java'
		:w
		:vs|term java %
	endif
	:NERDTreeRefreshRoot
	:normal a
endfunction

function CloseWin()
	:b#
	:bd#
endfunction

"""Basic configs"""
set list lcs=tab:\│\ ,space:.
set fillchars=eob:\ ,fold:\ ,vert:\│
set guicursor=a:blinkon100
set autochdir
set splitright              " new panes to de right
set splitbelow              " new panes go down
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set hlsearch                " highlight search 
set incsearch               " incremental search
if &filetype ==# 'python'
	set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
	set expandtab               " converts tabs to white space
endif
set tabstop=4               " number of columns occupied by a tab 
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set relativenumber
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set laststatus=3
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"""KeyBindings"""
"Movement"
"normal"
nnoremap h ;
nnoremap j h
nnoremap k j
nnoremap l k
nnoremap ; l

"visual"
vnoremap h ;
vnoremap j h
vnoremap k j
vnoremap l k
vnoremap ; l
"move between panes"
nnoremap <A-j> <C-w>h
nnoremap <A-k> <C-w>j
nnoremap <A-l> <C-w>k
nnoremap <A-;> <C-w>l
"Exit insert mode"
"inoremap ii <Esc>
inoremap jk <Esc>
tnoremap jk <C-\><C-n>
"inoremap kj <Esc>
"vnoremap kj <Esc>
"panels/buffers"
nnoremap <C-w> :call CloseWin()<CR>
nnoremap <A-v> <C-w>v
nnoremap <A-s> <C-w>s
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
"Resize Panels"
nnoremap <A-a>j :vertical resize +5<CR>
nnoremap <A-a>; :vertical resize -5<CR>
nnoremap <A-a>l :resize +5<CR>
nnoremap <A-a>k :resize -5<CR>
nnoremap <A-q> :close<CR>
"exit all"
nnoremap <C-c> :wqa<CR>
tnoremap <Esc> <C-\><C-n>
"tnoremap jk <esc>
"My functions"
nnoremap <F10> :call Focus()<CR>
nnoremap <F9> :call Writing()<CR>
"NerdTree"
nnoremap <C-k><C-b> :NERDTreeToggle<CR>
let NERDTreeMapActivateNode='<space>'
"MiniMap"
nmap <C-k><C-n> :MinimapToggle<CR>
"vsnip"
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

set termguicolors
colorscheme neohub
set guicursor+=i:ver100-iCursor
set guicursor+=i:blinkon1
"""Compilers"""
imap <C-b> <C-o>:call Compile()"<CR>
nmap <C-b> :call Compile()<CR>

"""Auto completion"""
set completeopt=menu,menuone,noselect

lua require('init')
