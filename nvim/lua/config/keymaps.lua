-- Move rows command
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "K", ":m '<-2<CR>gv=gv")