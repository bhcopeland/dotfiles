" Initialize plugin system with vim-plug
call plug#begin('~/.config/nvim/plugged')

" Essential Plugins
Plug 'preservim/nerdtree'              " File tree explorer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Syntax highlighting
Plug 'neovim/nvim-lspconfig'            " LSP configuration
Plug 'hrsh7th/nvim-cmp'                 " Autocompletion framework
Plug 'hrsh7th/cmp-nvim-lsp'             " LSP source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'                 " Snippet engine
Plug 'saadparwaiz1/cmp_luasnip'         " Snippet integration with completion
Plug 'morhetz/gruvbox'                  " Gruvbox color scheme
Plug 'tpope/vim-commentary'             " Commenting utility
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder
Plug 'junegunn/fzf.vim'                 " Fuzzy finder integration for Vim
Plug 'airblade/vim-gitgutter'           " Git gutter support
Plug 'vim-airline/vim-airline'          " Statusline
Plug 'vim-airline/vim-airline-themes'   " Statusline themes
Plug 'dense-analysis/ale' " vim-airlien requirement

call plug#end()

" General settings
syntax enable
set number                      " Show line numbers
set relativenumber              " Show relative line numbers
set tabstop=4                   " Set tab width
set shiftwidth=4                " Set indentation width
set expandtab                   " Use spaces instead of tabs
set smartindent                 " Smart indentation
set background=dark             " Use dark background
colorscheme gruvbox             " Set color scheme to Gruvbox

" Remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" commit length
autocmd FileType gitcommit setlocal textwidth=72 colorcolumn=73


" Remember last position in file
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
endif

" Airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" NERDTree toggle keybinding
nnoremap <C-n> :NERDTreeToggle<CR>

" Configure nvim-cmp for autocompletion
lua <<EOF
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
  })
EOF

" LSP configuration using 'lspconfig'
lua <<EOF
  local lspconfig = require('lspconfig')

  -- Define on_attach function for LSP key mappings
  local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    -- LSP key mappings
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  end

  -- Configure LSP servers
  lspconfig.pyright.setup { on_attach = on_attach }   -- Python LSP
  lspconfig.ts_ls.setup { on_attach = on_attach }     -- JavaScript/TypeScript LSP
  lspconfig.gopls.setup { on_attach = on_attach }     -- Go LSP
EOF

" Git integration with GitGutter
set updatetime=100

lua <<EOF
  local lspconfig = require('lspconfig')

  -- Define on_attach function for LSP key mappings
  local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    -- LSP key mappings
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  end

  -- Configure LSP servers
  lspconfig.pyright.setup {
    on_attach = on_attach,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",  -- Disable type checking
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticSeverityOverrides = {
            reportMissingImports = "none",  -- Disable "import could not resolve" warnings
            reportGeneralTypeIssues = "none",  -- Disable general type issues
          }
        }
      }
    }
  }

  lspconfig.ts_ls.setup { on_attach = on_attach }     -- JavaScript/TypeScript LSP
  lspconfig.gopls.setup { on_attach = on_attach }     -- Go LSP
EOF

