local M = {}

---@class Config
---@field default_mappings boolean
---@field step_size number
---@field notifications NotificationOpts
---@field reset_font string

---@class NotificationOpts
---@field enable boolean
---@field delay number
---@field timeout number

---@type Config
M.defaults = {
	default_mappings = true,
	step_size = 1,
	notifications = {
		enable = require("size-matters.notifications").notify_status,
		delay = 200,
		timeout = 150,
	},
	reset_font = vim.api.nvim_get_option "guifont",
}

return M
