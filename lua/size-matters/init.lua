local initFont = vim.api.nvim_get_option("guifont")
local currFont, currFontName, currFontSize
local notifications = true

local notify_ok, notify = pcall(require, "notify")
if not notify_ok then
	notifications = false
end
local notifyOpts = { render = "minimal", timeout = 150, minimum_width = 10 }

local function get_font()
	currFont = vim.api.nvim_get_option("guifont")
	currFontName = currFont:gsub("(.*)%:.*$", "%1")
	currFontSize = currFont:gsub(".*:h", "")
end

local function update_font(size)
	get_font()
	if size == 'grow' then
		currFont = currFontName .. ':h' .. tostring(tonumber(currFontSize) + 1)
		if notifications then notify(" FontSize " .. tonumber(currFontSize) + 1, "info", notifyOpts) end
	elseif size == 'shrink' then
		currFont = currFontName .. ':h' .. tostring(tonumber(currFontSize) - 1)
		if notifications then notify(" FontSize " .. tonumber(currFontSize) - 1, "info", notifyOpts) end
	end
	vim.opt.guifont = currFont
end

local function reset_font()
	vim.opt.guifont = initFont
	if notifications then notify(" " .. initFont, "info", notifyOpts) end
end

local command = vim.api.nvim_create_user_command
command('FontSizeUp', function() update_font('grow') end, { desc = 'Increase font size' })
command('FontSizeDown', function() update_font('shrink') end, { desc = 'Decrease font size' })
command('FontDefault', function() reset_font() end, { desc = 'Reset to default font' })

local map = vim.keymap.set
map('n', '<C-+>', function() update_font('grow') end, { desc = 'Increase font size' })
map('n', '<C-S-+>', function() update_font('grow') end, { desc = 'Increase font size' })
map('n', '<C-->', function() update_font('shrink') end, { desc = 'Decrease font size' })
map('n', '<C-ScrollWheelUp>', function() update_font('grow') end, { desc = 'Increase font size' })
map('n', '<C-ScrollWheelDown>', function() update_font('shrink') end, { desc = 'Decrease font size' })
map('n', '<A-C-=>', reset_font, { desc = 'Reset to default font' })

return {
	update_font = update_font,
	reset_font = reset_font
}

