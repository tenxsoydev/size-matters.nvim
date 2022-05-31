# size-matters.nvim

<sub>☕ Soydev plugin series.<sub>

Lua plugin that adds dynamic font scaling to modern neovim GUI clients like [neovide][1] or [goneovim][2].

|                       | **Keymaps**                                                          | **Commands**   |
| --------------------- | -------------------------------------------------------------------- | -------------- |
| Increase font size    | <kbd>Ctrl</kbd>+<kbd>+</kbd> / <kbd>Ctrl</kbd>+<kbd>ScrollUp</kbd>   | `FontSizeUp`   |
| Decrease font size    | <kbd>Ctrl</kbd>+<kbd>-</kbd> / <kbd>Ctrl</kbd>+<kbd>ScrollDown</kbd> | `FontSizeDown` |
| Reset font to default | <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>=</kbd>                          | `FontDefault`  |

## Installation

A simple way to install the plugin is via a plugin manager. E.g., [packer.nvim][3]

```lua
use "tenxsoydev/size-matters.nvim"
```

Then just load it like any other plugin. Additionally, you can wrap it in a condition to only be loaded when using a GUI client. E.g.,

```lua
if vim.g.neovide or vim.g.goneovim or vim.g.nvui or vim.g.gnvim then
	require("size-matters")
end
```

### Requirements

nvim >= v0.7. As the vim.api that was introduced with v0.7 is used.<br>
This also being the latest stable release, we'll recommend upgrading your application and config when possible.

## Outlook

-  [x] Notifications when changing the font-size
-  [x] User settings. E.g., to disable default mappings / notification visibility
-  [ ] Send custom size values via commands
-  ~~Branch with support for versions \< 0.7 (if there is a community need for it)~~

[1]: https://github.com/neovide/neovide
[2]: https://github.com/akiyosi/goneovim
[3]: https://github.com/wbthomason/packer.nvim
