return {
  -- {
  --   'folke/trouble.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   opts = { use_diagnostic_signs = true },
  --   keys = {
  --     { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Toggle Trouble' },
  --   },
  -- },
  {
    'nvim-tree/nvim-web-devicons',
    opts = {
      -- Optional: Customize icons or settings
      default = true, -- Enable default icon fallback
      override = {
        txt = { icon = '📄', color = '#ffffff', name = 'Text' },
      },
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2', -- for the new version (requires >= Neovim 0.9)
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup()

      -- optional keybindings
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set('n', '<C-h>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-t>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-n>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-s>', function()
        harpoon:list():select(4)
      end)
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {
        disable_filetype = { 'TelescopePromt', 'vim' },
        enable_check_bracket_line = true,
        map_cr = true,
      }
      local cmp_status, cmp = pcall(require, 'cmp')
      if cmp_status then
        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
    'andymass/vim-matchup',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
}
