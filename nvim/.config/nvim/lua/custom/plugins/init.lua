return {
  -- indentation
  {
    'nmac427/guess-indent.nvim',
    opts = {},
  },
  -- markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    config = function()
      vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<CR>', { desc = '[M]arkdown [P]review' })
    end,
  },
  -- documentation generator
  {
    'kkoomen/vim-doge',
    config = function()
      vim.call 'doge#install'
      vim.g.doge_enable_mappings = 0
      -- Generate comment for current line
      vim.keymap.set('n', '<Leader>dg', '<Plug>(doge-generate)', { desc = '[D]ocumentation [G]enerate' })
      -- Interactive mode comment todo-jumping
      vim.keymap.set('n', '<TAB>', '<Plug>(doge-comment-jump-forward)')
      vim.keymap.set('n', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
      vim.keymap.set('i', '<TAB>', '<Plug>(doge-comment-jump-forward)')
      vim.keymap.set('i', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
      vim.keymap.set('x', '<TAB>', '<Plug>(doge-comment-jump-forward)')
      vim.keymap.set('x', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
    end,
  },
  -- file renaming with lsps
  {
    {
      'antosha417/nvim-lsp-file-operations',
      dependencies = {
        'nvim-lua/plenary.nvim',
        -- Uncomment whichever supported plugin(s) you use
        -- "nvim-tree/nvim-tree.lua",
        'nvim-neo-tree/neo-tree.nvim',
        -- "simonmclean/triptych.nvim"
      },
      config = function()
        require('lsp-file-operations').setup()
      end,
    },
  },
  -- codesnap
  {
    'mistricky/codesnap.nvim',
    build = 'make',
    keys = {
      { '<leader>cc', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
      { '<leader>cs', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = 'Save selected code snapshot in ~/Pictures' },
    },
    opts = {
      save_path = '~/Pictures',
      has_breadcrumbs = true,
      bg_theme = 'bamboo',
      watermark = '',
    },
  },
  -- copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        auto_trigger = true,
      },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    keys = {
      { '<leader>cp', ':CopilotChatToggle<CR>', desc = 'Toggle Copilot Chat' },
    },
  },
}
