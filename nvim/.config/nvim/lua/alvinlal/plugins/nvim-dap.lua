local js_based_languages = {
	"typescript",
	"javascript",
	"typescriptreact",
	"javascriptreact",
	"vue",
}

return {
	{ "nvim-neotest/nvim-nio" },
	{ "rcarriga/nvim-dap-ui" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			require("nvim-dap-virtual-text").setup()

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>dgb", dap.run_to_cursor)

			-- Eval var under cursor
			vim.keymap.set("n", "<leader>d?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			vim.keymap.set("n", "<leader>da", function()
				if vim.fn.filereadable(".vscode/launch.json") then
					local dap_vscode = require("dap.ext.vscode")
					dap_vscode.load_launchjs(nil, {
						["pwa-node"] = js_based_languages,
						["node"] = js_based_languages,
						["chrome"] = js_based_languages,
						["pwa-chrome"] = js_based_languages,
					})
				end
				require("dap").continue()
			end, {
				desc = "Run with Args",
			})

			vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
			vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapLogPoint",
				{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)

			vim.keymap.set("n", "<leader>dc", dap.continue)
			vim.keymap.set("n", "<leader>di", dap.step_into)
			vim.keymap.set("n", "<leader>do", dap.step_over)
			vim.keymap.set("n", "<leader>dO", dap.step_out)
			vim.keymap.set("n", "<leader>dsb", dap.step_back)
			vim.keymap.set("n", "<leader>dsr", dap.restart)
			vim.keymap.set("n", "<leader>dt", dap.terminate)

			vim.keymap.set("n", "<leader>dui", ui.toggle)

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

			for _, language in ipairs(js_based_languages) do
				dap.configurations[language] = {
					-- Debug single nodejs files
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
					},
					-- Auto attach to nodejs processes
					{
						type = "pwa-node",
						request = "attach",
						name = "Auto Attach",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						protocol = "inspector",
					},
					-- Debug nodejs processes (make sure to add --inspect when you run the process)
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
					},
					-- Debug web applications (client side)
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch & Debug Chrome",
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input({
									prompt = "Enter URL: ",
									default = "http://localhost:3000",
								}, function(url)
									if url == nil or url == "" then
										return
									else
										coroutine.resume(co, url)
									end
								end)
							end)
						end,
						webRoot = vim.fn.getcwd(),
						protocol = "inspector",
						sourceMaps = true,
						userDataDir = false,
					},
					-- Divider for the launch.json derived configs
					{
						name = "----- ↓ launch.json configs ↓ -----",
						type = "",
						request = "launch",
					},
				}
			end
		end,
		-- keys = {
		-- 	{
		-- 		"<leader>dO",
		-- 		function()
		-- 			require("dap").step_out()
		-- 		end,
		-- 		desc = "Step Out",
		-- 	},
		-- 	{
		-- 		"<leader>do",
		-- 		function()
		-- 			require("dap").step_over()
		-- 		end,
		-- 		desc = "Step Over",
		-- 	},
		-- 	{
		-- 		"<leader>da",
		-- 		function()
		-- 			if vim.fn.filereadable(".vscode/launch.json") then
		-- 				local dap_vscode = require("dap.ext.vscode")
		-- 				dap_vscode.load_launchjs(nil, {
		-- 					["pwa-node"] = js_based_languages,
		-- 					["node"] = js_based_languages,
		-- 					["chrome"] = js_based_languages,
		-- 					["pwa-chrome"] = js_based_languages,
		-- 				})
		-- 			end
		-- 			require("dap").continue()
		-- 		end,
		-- 		desc = "Run with Args",
		-- 	},
		-- },
		dependencies = {
			-- Install the vscode-js-debug adapter
			{
				"microsoft/vscode-js-debug",
				-- After install, build it and rename the dist directory to out
				build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
				version = "1.*",
			},
			{
				"mxsdev/nvim-dap-vscode-js",
				config = function()
					---@diagnostic disable-next-line: missing-fields
					require("dap-vscode-js").setup({
						-- Path of node executable. Defaults to $NODE_PATH, and then "node"
						-- node_path = "node",

						-- Path to vscode-js-debug installation.
						debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

						-- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
						-- debugger_cmd = { "js-debug-adapter" },

						-- which adapters to register in nvim-dap
						adapters = {
							"chrome",
							"pwa-node",
							"pwa-chrome",
							"pwa-msedge",
							"pwa-extensionHost",
							"node-terminal",
						},

						-- Path for file logging
						-- log_file_path = "(stdpath cache)/dap_vscode_js.log",

						-- Logging level for output to file. Set to false to disable logging.
						-- log_file_level = false,

						-- Logging level for output to console. Set to false to disable console output.
						-- log_console_level = vim.log.levels.ERROR,
					})
				end,
			},
			{
				"Joakker/lua-json5",
				build = "./install.sh",
			},
		},
	},
}
