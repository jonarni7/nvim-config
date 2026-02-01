local status_ok, avante = pcall(require, "avante")
if not status_ok then
  return
end

require("avante_lib").load()


require('avante').setup({
  -- Provider configuration
  provider = "claude", -- Use Claude as the AI provider
  auto_suggestions_provider = "claude", -- Provider for inline suggestions

  
  -- Claude-specific settings
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-sonnet-4-20250514", -- Latest Sonnet model
    temperature = 0,
    max_tokens = 4096,
    api_key_name = "ANTHROPIC_API_KEY", -- Reads from environment variable
  },

  -- Behavior settings
  behaviour = {
    auto_suggestions = false, -- Disable automatic inline suggestions (can be distracting)
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false, -- Don't auto-apply changes, review first
    support_paste_from_clipboard = false,
  },

  -- Keymappings
  mappings = {
    --- Diff/conflict resolution mappings
    diff = {
      ours = "co",      -- Choose our changes
      theirs = "ct",    -- Choose their (AI) changes
      all_theirs = "ca", -- Accept all AI changes
      both = "cb",      -- Keep both versions
      cursor = "cc",    -- Choose change at cursor
      next = "]x",      -- Jump to next conflict
      prev = "[x",      -- Jump to previous conflict
    },
    --- Suggestion mappings (for inline suggestions)
    suggestion = {
      accept = "<M-l>",   -- Accept suggestion (Alt+l)
      next = "<M-]>",     -- Next suggestion
      prev = "<M-[>",     -- Previous suggestion
      dismiss = "<C-]>",  -- Dismiss suggestion
    },
    --- Jump between code blocks
    jump = {
      next = "]]",
      prev = "[[",
    },
    --- Submit prompts
    submit = {
      normal = "<CR>",  -- Enter in normal mode
      insert = "<C-s>", -- Ctrl+s in insert mode
    },
  },
  
  -- Hints (inline virtual text hints)
  hints = {
    enabled = true,
  },
  
  -- Window configuration
  windows = {
    position = "right", -- "right", "left", "top", "bottom"
    wrap = true,        -- Wrap text in avante window
    width = 30,         -- Width percentage (30% of screen)
    sidebar_header = {
      align = "center", -- "left", "center", "right"
      rounded = true,
    },
  },
  
  -- Highlighting
  highlights = {
    diff = {
      current = "DiffText",
      incoming = "DiffAdd",
    },
  },

  
})

