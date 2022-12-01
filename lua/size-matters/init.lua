local M = {}

local notifications = require "size-matters.notifications"
local config = require("size-matters.config").defaults

---@param user_config? Config
function M.setup(user_config) config = vim.tbl_deep_extend("keep", user_config or {}, config) end

---@type string?
local guifont

---@type { name: string, size: string|number }
local curr_font = {}

local function get_font()
	guifont = vim.api.nvim_get_option "guifont"
	curr_font.name = guifont:gsub("(.*)%:.*$", "%1")
	curr_font.size = guifont:gsub(".*:h", "")
end

---@param modification "grow"|"shrink"
---@param amount number?
function M.update_font(modification, amount)
	get_font()

	amount = type(amount) == "string" and tonumber(amount) or config.step_size
	curr_font.size = type(curr_font.size) == "string" and tonumber(curr_font.size) or curr_font.size

	if modification == "grow" then
		guifont = curr_font.name .. ":h" .. tostring(curr_font.size + amount)

		if not config.notifications or not config.notifications.enable then
			goto continue
		end

		notifications.send(" FontSize " .. curr_font.size + amount, config.notifications)
	elseif modification == "shrink" then
		guifont = curr_font.name .. ":h" .. tostring(curr_font.size - amount)

		if not config.notifications or not config.notifications.enable then
			goto continue
		end
		notifications.send(" FontSize " .. curr_font.size - amount, config.notifications)
	end

	::continue::
	vim.opt.guifont = guifont
end

function M.reset_font()
	vim.opt.guifont = config.reset_font

	if not config.notifications or not config.notifications.enable then return end
	notifications.send(" " .. config.reset_font, config.notifications)
end

local cmd = vim.api.nvim_create_user_command
cmd("FontSizeUp", function(num) M.update_font("grow", num.args) end, { nargs = 1 })
cmd("FontSizeDown", function(num) M.update_font("shrink", num.args) end, { nargs = 1 })
cmd("FontReset", function() M.reset_font() end, {})

if config.default_mappings then
	local map = vim.keymap.set
	map("n", "<C-+>", function() M.update_font "grow" end, { desc = "Increase font size" })
	map("n", "<C-S-+>", function() M.update_font "grow" end, { desc = "Increase font size" })
	map("n", "<C-->", function() M.update_font "shrink" end, { desc = "Decrease font size" })
	map("n", "<C-ScrollWheelUp>", function() M.update_font "grow" end, { desc = "Increase font size" })
	map("n", "<C-ScrollWheelDown>", function() M.update_font "shrink" end, { desc = "Decrease font size" })
	map("n", "<A-C-=>", M.reset_font, { desc = "Reset to default font" })
end

return M
