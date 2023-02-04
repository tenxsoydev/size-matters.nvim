local M = {}

local notifier_ok = pcall(require, "notifier")
local notify_ok, notify = pcall(require, "notify")
local active_notify_msg_win_id = -1

---@param message string
---@param config NotificationOpts
function M.send(message, config)
	if not notify_ok then
		vim.defer_fn(function()
			if notifier_ok then
				local sm_notifications = 0
				local notifier_status = require "notifier.status"
				for _, notification in ipairs(notifier_status.active.nvim) do
					if notification.mandat:match "FontSize" then sm_notifications = sm_notifications + 1 end
				end
				if sm_notifications > 1 then notifier_status.pop "nvim" end
			end
			vim.notify(message)
		end, config.delay)
		return
	end

	local notifyOpts = {
		render = "minimal",
		timeout = config.timeout,
		minimum_width = 10,
		on_open = function(win)
			if vim.api.nvim_win_is_valid(active_notify_msg_win_id) then
				vim.api.nvim_win_close(active_notify_msg_win_id, true)
			end
			active_notify_msg_win_id = win
		end,
	}

	vim.defer_fn(function() notify(message, "info", notifyOpts) end, config.delay)
end

return M
