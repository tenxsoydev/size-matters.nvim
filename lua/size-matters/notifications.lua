local M = {}

local ok, notify = pcall(require, "notify")
if not ok then return end

local active_notification_win_id = -1

---@param message string
---@param config NotificationOpts
function M.send(message, config)
	local notifyOpts = {
		render = "minimal",
		timeout = config.timeout,
		minimum_width = 10,
		on_open = function(win)
			if vim.api.nvim_win_is_valid(active_notification_win_id) then
				vim.api.nvim_win_close(active_notification_win_id, true)
			end
			active_notification_win_id = win
		end,
	}

	vim.defer_fn(function() notify(message, "info", notifyOpts) end, config.delay)
end

return M
