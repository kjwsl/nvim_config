local config_path = vim.fn.stdpath('config')

vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>', { silent = true, desc = 'Find Files' })
vim.keymap.set('n', '<leader>fo', '<cmd>FzfLua oldfiles<cr>', { silent = true, desc = 'Find Old Files' })
vim.keymap.set('n', '<leader>fq', '<cmd>FzfLua quickfix<cr>', { silent = true, desc = 'Quickfix List' })
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<cr>', { silent = true, desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua live_grep<cr>', { silent = true, desc = 'Live Grep' })
vim.keymap.set('n', '<leader>flc', '<cmd>FzfLua lgrep_curbuf<cr>', { silent = true, desc = 'Live Grep Current Buffer' })
vim.keymap.set('n', '<leader>fc', '<cmd>FzfLua files cwd=' .. config_path .. '<cr>', { silent = true, desc = 'Find Config Directory' })
vim.keymap.set('n', '<leader>fh', '<cmd>FzfLua helptags<cr>', { silent = true, desc = 'Find Helptags' })
vim.keymap.set('n', '<leader>f:', '<cmd>FzfLua commands<cr>', { silent = true, desc = 'Find Commands' })
vim.keymap.set('n', '<leader>fj', '<cmd>FzfLua jumps<cr>', { silent = true, desc = 'Find Jumps' })
vim.keymap.set('n', '<leader>fm', '<cmd>FzfLua marks<cr>', { silent = true, desc = 'Find Marks' })
vim.keymap.set('n', '<leader>ft', '<cmd>FzfLua colorschemes<cr>', { silent = true, desc = 'Find Themes' })
vim.keymap.set('n', '<leader>gc', '<cmd>FzfLua live_grep cwd=' .. config_path .. '<cr>', { silent = true, desc = 'Grep Config' })

vim.keymap.set('n', '<leader>fld', '<cmd>FzfLua lsp_document_diagnostics<cr>', { silent = true, desc = 'Find Diagnostics' })
