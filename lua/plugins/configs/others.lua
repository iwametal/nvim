local M = {}

M.autopairs = function()
  local present1, autopairs = pcall(require, "nvim-autopairs")
  local present2, autopairs_completion = pcall(require, "nvim-autopairs.completion.cmp")

  if not (present1 or present2) then
    return
  end

  autopairs.setup()
  autopairs_completion.setup {
    map_complete = true, -- insert () func completion
    map_cr = true,
  }
end

M.autosave = function()
  -- autosave.nvim plugin is disabled by default
  local present, autosave = pcall(require, "autosave")
  if not present then
    return
  end

  autosave.setup {
    enabled = vim.g.auto_save or false, -- takes boolean value from init.lua
    execution_message = "autosaved at : " .. vim.fn.strftime "%H:%M:%S",
    events = { "InsertLeave", "TextChanged" },
    conditions = {
      exists = true,
      filetype_is_not = {},
      modifiable = true,
    },
    clean_command_line_interval = 2500,
    on_off_commands = true,
    write_all_buffers = false,
  }
end

M.better_escape = function()
  local config = require("core.utils").load_config()
  vim.g.better_escape_interval = config.options.plugin.esc_insertmode_timeout or 300
end

M.blankline = function()
  vim.g.indentLine_enabled = 1
  vim.g.indent_blankline_char = "▏"

  vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "packer" }
  vim.g.indent_blankline_buftype_exclude = { "terminal" }

  vim.g.indent_blankline_show_trailing_blankline_indent = false
  vim.g.indent_blankline_show_first_indent_level = false
end

M.hexokinase = function()
  local present, hexokinase = pcall(require, "vim-hexokinase")
  if not present then
    return
  end
end

-- M.colorizer = function()
--   local present, colorizer = pcall(require, "colorizer")
--   if present then
--     colorizer.setup()
--     vim.cmd "ColorizerReloadAllBuffers"
--   end
-- end

M.comment = function()
  local present, nvim_comment = pcall(require, "nvim_comment")
  if present then
    nvim_comment.setup()
  end
end

-- M.ultisnips = function()
--   local present, ultisnips = pcall(require, "ultisnips")
--   if not present then
--     return
--   end
--   vim.cmd([[ set runtimepath+="$HOME/.config/nvim/lua/plugins/snippets" ]])
-- end

M.luasnip = function()
  local present, luasnip = pcall(require, "luasnip")
  if not present then
    return
  end

  luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }
  vim.o.runtimepath = vim.o.runtimepath .. ',/$HOME/.config/nvim/snippets,'
  require("luasnip/loaders/from_vscode").load()
end

M.lspkind = function()
  local present, lspkind = pcall(require, "lspkind")
  if present then
    lspkind.init()
  end
end

M.neoscroll = function()
  pcall(function()
    require("neoscroll").setup()
  end)
end

M.signature = function()
  local present, lspsignature = pcall(require, "lsp_signature")
  if present then
    lspsignature.setup {
      bind = true,
      doc_lines = 2,
      floating_window = true,
      fix_pos = true,
      hint_enable = true,
      hint_prefix = " ",
      hint_scheme = "String",
      use_lspsaga = false,
      hi_parameter = "Search",
      max_height = 22,
      max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "single", -- double, single, shadow, none
      },
      zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
      padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
    }
  end
end

return M