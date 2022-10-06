local M = {}

local notify_status, notify = pcall(require, "notify")
local notifyOpts = { render = "minimal", timeout = 150, minimum_width = 10 }

---@class SizeMattersConfig
---@field default_mappings boolean
---@field step_size number
---@field notifications boolean
---@field reset_font string
local config = {
	default_mappings = true,
	step_size = 1,
	notifications = notify_status,
	reset_font = vim.api.nvim_get_option("guifont")
}

---@param opts SizeMattersConfig
function M.setup(opts) config = vim.tbl_deep_extend("keep", opts, config) end

local currFont, currFontName, currFontSize

local function get_font()
	currFont = vim.api.nvim_get_option("guifont")
	currFontName = currFont:gsub("(.*)%:.*$", "%1")
	currFontSize = currFont:gsub(".*:h", "")
end

---@param modification string '"grow" | "shrink"'
---@param amount number?
function M.update_font(modification, amount)
	get_font()
	amount = type(amount) == "string" and tonumber(amount) or config.step_size
	if modification == "grow" then
		currFont = currFontName .. ":h" .. tostring(tonumber(currFontSize) + amount)
		if config.notifications then
			vim.loop.new_timer():start(200, 0, vim.schedule_wrap(function()
				notify.dismiss()
				notify(" FontSize " .. tonumber(currFontSize) + amount, "info", notifyOpts)
			end))
		end
	elseif modification == "shrink" then
		currFont = currFontName .. ":h" .. tostring(tonumber(currFontSize) - amount)
		if config.notifications then
			vim.loop.new_timer():start(200, 0, vim.schedule_wrap(function()
				notify.dismiss()
				notify(" FontSize " .. tonumber(currFontSize) - amount, "info", notifyOpts)
			end))
		end
	end
	vim.opt.guifont = currFont
end

function M.reset_font()
	vim.opt.guifont = config.reset_font
	if config.notifications then notify(" " .. config.reset_font, "info", notifyOpts) end
end

local cmd = vim.api.nvim_create_user_command
cmd("FontSizeUp", function(num) M.update_font("grow", num.args) end, { nargs = 1 })
cmd("FontSizeDown", function(num) M.update_font("shrink", num.args) end, { nargs = 1 })
cmd("FontReset", function() M.reset_font() end, {})

if config.default_mappings then
	local map = vim.keymap.set
	map("n", "<C-+>", function() M.update_font("grow") end, { desc = "Increase font size" })
	map("n", "<C-S-+>", function() M.update_font("grow") end, { desc = "Increase font size" })
	map("n", "<C-->", function() M.update_font("shrink") end, { desc = "Decrease font size" })
	map("n", "<C-ScrollWheelUp>", function() M.update_font("grow") end, { desc = "Increase font size" })
	map("n", "<C-ScrollWheelDown>", function() M.update_font("shrink") end, { desc = "Decrease font size" })
	map("n", "<A-C-=>", M.reset_font, { desc = "Reset to default font" })
end

return M
