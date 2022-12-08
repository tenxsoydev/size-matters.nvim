local sm = require "size-matters"

describe("Test size-matters.nvim", function()
	before_each(function()
		vim.opt.guifont = "SomeNerdFont:h12"
		sm.setup(require("size-matters.config").defaults)
	end)

	it("can increase the guifont's size", function()
		-- test default
		sm.update_font "grow"
		assert.equals("SomeNerdFont:h13", vim.api.nvim_get_option "guifont")

		-- test custom
		sm.setup { step_size = 0.5 }
		sm.update_font "grow"
		assert.equals("SomeNerdFont:h13.5", vim.api.nvim_get_option "guifont")
	end)

	it("can decrease the guifont's size", function()
		-- test default
		sm.update_font "shrink"
		assert.equals("SomeNerdFont:h11", vim.api.nvim_get_option "guifont")

		-- test custom
		sm.setup { step_size = 1.5 }
		sm.update_font "shrink"
		assert.equals("SomeNerdFont:h9.5", vim.api.nvim_get_option "guifont")
	end)

	it("can reset the guifont", function()
		-- test default
		sm.update_font "grow"
		sm.reset_font()
		assert.equals("SomeNerdFont:h12", vim.api.nvim_get_option "guifont")

		-- test custom
		sm.setup { reset_font = "JetBrainsMono Nerd Font Mono:h12.5" }
		sm.reset_font()
		assert.equals("JetBrainsMono Nerd Font Mono:h12.5", vim.api.nvim_get_option "guifont")
	end)
end)
