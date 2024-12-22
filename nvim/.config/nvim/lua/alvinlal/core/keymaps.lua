-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- View Explorer
keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- use jk to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- use cmd s to save
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- open git messenger
keymap.set("n", "<leader>gm", "<cmd>GitMessenger<CR>", { desc = "Open git messenger" }) -- open new tab

-- show type definition
-- keymap.set(
-- 	"n",
-- 	"<leader>kk",
-- 	"<cmd>lua vim.lsp.buf.hover()<cr>",
-- 	{ noremap = true, silent = true, desc = "Show info about variable under cursor" }
-- )

-- move block of code
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block of code up", noremap = true, silent = true })
keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move block of code down", noremap = true, silent = true })

-- put dd  and d into black hole register
-- keymap.set("n", "dd", '"_dd', { noremap = true, silent = true })
-- keymap.set("x", "d", '"_d', { noremap = true, silent = true })
keymap.set("n", "d", '"_d', { noremap = true })
keymap.set("v", "d", '"_d', { noremap = true })
keymap.set("n", "c", '"_c', { noremap = true })
keymap.set("x", "c", '"_c', { noremap = true })
