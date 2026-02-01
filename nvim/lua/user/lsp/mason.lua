local servers = {
	"lua_ls",
	"pylsp",
	-- "jsonls",
  "clangd"
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  -- NEW API: Define the LSP config
  vim.lsp.config[server] = {
    cmd = opts.cmd,  -- Command to start the server
    filetypes = opts.filetypes,
    root_dir = opts.root_dir or vim.fs.root(0, {'.git'}),
    capabilities = opts.capabilities,
    settings = opts.settings,
  }

  -- NEW API: Enable the LSP for the filetypes
  if opts.filetypes then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = opts.filetypes,
      callback = function()
        vim.lsp.enable(server)
        if opts.on_attach then
          opts.on_attach(vim.lsp.get_client_by_id(vim.lsp.get_clients()[1].id), vim.api.nvim_get_current_buf())
        end
      end,
    })
  end
end

