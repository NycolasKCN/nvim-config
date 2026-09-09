local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local dap_utils = require("dap.utils")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")
local wk = require("which-key")

-- Virtual text
dap_virtual_text.setup()

-- Mason
mason_dap.setup({
	ensure_installed = { "python", "js-debug-adapter", "javadbg", "javatest" },
	automatic_installation = true,
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})

-- Adapters
dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = {
			vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}
dap.adapters["pwa-chrome"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = {
			vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}

-- Configurations
local exts = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"vue",
	"svelte",
}
for i, ext in ipairs(exts) do
	dap.configurations[ext] = {
		{
			type = "pwa-chrome",
			request = "launch",
			name = 'Launch Chrome with "localhost"',
			url = function()
				local co = coroutine.running()
				return coroutine.create(function()
					vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:5173" }, function(url)
						if url == nil or url == "" then
							return
						else
							coroutine.resume(co, url)
						end
					end)
				end)
			end,
			webRoot = "${workspaceFolder}",
			protocol = "inspector",
			sourceMaps = true,
			userDataDir = false,
			skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
			resolveSourceMapLocations = {
				"${webRoot}/*",
				"${webRoot}/apps/**/**",
				"${workspaceFolder}/apps/**/**",
				"${webRoot}/packages/**/**",
				"${workspaceFolder}/packages/**/**",
				"${workspaceFolder}/*",
				"!**/node_modules/**",
			},
		},
		{
			name = "Next.js: debug server-side (pwa-node)",
			type = "pwa-node",
			request = "attach",
			port = 9231,
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node)",
			cwd = vim.fn.getcwd(),
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
			runtimeExecutable = "npm",
			runtimeArgs = {
				"run-script",
				"dev",
			},
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node with ts-node)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "--loader", "ts-node/esm" },
			runtimeExecutable = "node",
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with jest)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
			runtimeExecutable = "node",
			args = { "${file}", "--coverage", "false" },
			rootPath = "${workspaceFolder}",
			sourceMaps = true,
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with vitest)",
			cwd = vim.fn.getcwd(),
			program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
			args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
			autoAttachChildProcesses = true,
			smartStep = true,
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with deno)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
			runtimeExecutable = "deno",
			attachSimplePort = 9229,
		},
		{
			type = "pwa-chrome",
			request = "attach",
			name = "Attach Program (pwa-chrome, select port)",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			port = function()
				return vim.fn.input("Select port: ", 9222)
			end,
			webRoot = "${workspaceFolder}",
			skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
			resolveSourceMapLocations = {
				"${webRoot}/*",
				"${webRoot}/apps/**/**",
				"${workspaceFolder}/apps/**/**",
				"${webRoot}/packages/**/**",
				"${workspaceFolder}/packages/**/**",
				"${workspaceFolder}/*",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach Program (pwa-node, select pid)",
			cwd = vim.fn.getcwd(),
			processId = dap_utils.pick_process,
			skipFiles = { "<node_internals>/**" },
		},
	}
end

-- dap signs
vim.fn.sign_define("DapBreakpoint", { text = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "" })
vim.fn.sign_define("DapLogPoint", { text = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "" })
vim.fn.sign_define("DapStopped", { text = "" })

-- Ui
ui.setup()

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end

-- keymaps
wk.add({
	{ "<leader>d", group = "Debug Adapter" },
	{
		"<leader>dr",
		function()
			dap.run()
		end,
		desc = "Run debug",
		mode = "n",
	},
	{
		"<leader>dc",
		function()
			dap.continue()
		end,
		desc = "Continue",
		mode = "n",
	},
	{
		"<leader>db",
		function()
			dap.toggle_breakpoint()
		end,
		desc = "Toggle Breakpoint",
		mode = "n",
	},
	{
		"<leader>dl",
		function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end,
		desc = "Add Loging point",
		mode = "n",
	},
	{
		"<leader>dC",
		function()
			dap.run_to_cursor()
		end,
		desc = "Run to Cursor",
		mode = "n",
	},
	{
		"<leader>dT",
		function()
			dap.terminate()
		end,
		desc = "Terminate",
		mode = "n",
	},
	{
		"<leader>du",
		function()
			ui.toggle()
		end,
		desc = "Dap UI",
		mode = "n",
	},
})
