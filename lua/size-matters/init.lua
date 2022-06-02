local M = {}

local notify_status, notify = pcall(require, 'notify')
local notifyOpts = { render = 'minimal', timeout = 150, minimum_width = 10 }

local config = {
	default_mappings = true,
	step_size = 1,
	notifications = notify_status,
	reset_font = vim.api.nvim_get_option('guifont')
}

function M.setup(opts) config = vim.tbl_deep_extend('keep', opts, config) end

local currFont, currFontName, currFontSize

local function get_font()
	currFont = vim.api.nvim_get_option('guifont')
	currFontName = currFont:gsub('(.*)%:.*$', '%1')
	currFontSize = currFont:gsub('.*:h', '')
end

function M.update_font(direct, num)
	get_font()
	num = type(num) == 'string' and tonumber(num) or config.step_size
	if direct == 'grow' then
		currFont = currFontName .. ':h' .. tostring(tonumber(currFontSize) + num)
		if config.notifications then notify(' FontSize ' .. tonumber(currFontSize) + num, 'info', notifyOpts) end
	elseif direct == 'shrink' then
		currFont = currFontName .. ':h' .. tostring(tonumber(currFontSize) - num)
		if config.notifications then notify(' FontSize ' .. tonumber(currFontSize) - num, 'info', notifyOpts) end
	end
	vim.opt.guifont = currFont
end

function M.reset_font()
	vim.opt.guifont = config.reset_font
	if config.notifications then notify(" " .. config.reset_font, "info", notifyOpts) end
end

local cmd = vim.api.nvim_create_user_command
cmd('FontSizeUp', function(num) M.update_font('grow', num.args) end, { desc = 'Increase font size', nargs = 1 })
cmd('FontSizeDown', function(num) M.update_font('shrink', num.args) end, { desc = 'Decrease font size', nargs = 1 })
cmd('FontReset', function() M.reset_font() end, { desc = 'Reset to default font' })

if config.default_mappings then
	local map = vim.keymap.set
	map('n', '<C-+>', function() M.update_font('grow') end, { desc = 'Increase font size' })
	map('n', '<C-S-+>', function() M.update_font('grow') end, { desc = 'Increase font size' })
	map('n', '<C-->', function() M.update_font('shrink') end, { desc = 'Decrease font size' })
	map('n', '<C-ScrollWheelUp>', function() M.update_font('grow') end, { desc = 'Increase font size' })
	map('n', '<C-ScrollWheelDown>', function() M.update_font('shrink') end, { desc = 'Decrease font size' })
	map('n', '<A-C-=>', M.reset_font, { desc = 'Reset to default font' })
end

return M
