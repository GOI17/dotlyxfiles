local map = function(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

local nmap = function(l, r, opts)
  map('n', l, r, opts)
end

local imap = function(l, r, opts)
  map('i', l, r, opts)
end

local vmap = function(l, r, opts)
  map('v', l, r, opts)
end

local vimap = function(l, r, opts)
  map({ 'i', 'v' }, l, r, opts)
end

-- nmap('H', function() require('vscode').action("workbench.action.previousEditor") end, { desc = "Next editor tab" })
-- nmap('L', function() require('vscode').action("workbench.action.nextEditor") end, { desc = "Next editor tab" })
-- nmap('˙', function() require('vscode').action("workbench.action.moveEditorLeftInGroup") end,
--   { desc = "Swap with previous tab" })
-- nmap('¬', function() require('vscode').action("workbench.action.moveEditorRightInGroup") end,
--   { desc = "Swap with next tab" })
-- map({ 'n', 'v', 'i' }, '∆', function() require('vscode').action("editor.action.moveLinesDownAction") end,
--   { desc = "Move selection down" })
-- map({ 'n', 'v', 'i' }, '˚', function() require('vscode').action("editor.action.moveLinesUpAction") end,
--   { desc = "Move selection up" })
-- nmap(':', function() require('vscode').action("workbench.action.showCommands") end, { desc = "Display all commands" })
-- nmap('<C-h>', function() require('vscode').action("workbench.action.focusLeftGroup") end, { desc = "" })
-- nmap('<C-j>', function() require('vscode').action("workbench.action.focusBelowGroup") end, { desc = "" })
-- nmap('<C-k>', function() require('vscode').action("workbench.action.focusAboveGroup") end, { desc = "" })
-- nmap('<C-l>', function() require('vscode').action("workbench.action.focusRightGroup") end, { desc = "" })
-- nmap('u', function() require('vscode').action("undo") end, { desc = "" })
-- nmap('<C-r>', function() require('vscode').action("redo") end, { desc = "" })

-- vim.notify('Keymaps loaded')

-- return {
--   'tpope/vim-commentary',
--   'voldikss/vim-floaterm',
--   'echasnovski/mini.surround',
-- }
