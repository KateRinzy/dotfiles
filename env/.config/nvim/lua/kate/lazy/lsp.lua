---@diagnostic disable: undefined-global
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim"
  },

  config = function()
    require("conform").setup({
      formatters_by_ft = {}
    })
    local cmp = require('cmp')
    -- local cmp_lsp = require("cmp_nvim_lsp")
    -- local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
    --     cmp_lsp.default_capabilities())

    local cmp_enabled = true
    vim.keymap.set("n", "<leader>tc", function()
      cmp_enabled = not cmp_enabled
      cmp.setup({
        enabled = function()
          return cmp_enabled
        end,
      })
      print("nvim-cmp " .. (cmp_enabled and "enabled" or "disabled"))
    end, { desc = "Toggle autocompletion" })

    require("fidget").setup({})
    require("mason").setup({})
    require("kate.lsp.lsp")

    local cmp_select = {
      behavior = cmp.SelectBehavior.Select
    }

    cmp.setup({
      experimental = {
        ghost_text = false
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ["<C-l>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort()
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'supermaven' }
      }, { { name = 'buffer' } })
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
      }
    })
  end
}
