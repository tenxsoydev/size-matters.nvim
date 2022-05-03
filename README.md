# size-matters.nvim

<sub>☕ Soydev plugin series.<sub>

Lua plugin that adds dynamic font scaling to modern neovim GUI clients like [neovide][1] or [goneovim][2].

|                       | **Keymaps**                  | **Commands**   |
| --------------------- | ---------------------------- | -------------- |
| Increase font size    | `Ctrl++` / `Ctrl+ScrollUp`   | `FontSizeUp`   |
| Decrease font size    | `Ctrl+-` / `Ctrl+ScrollDown` | `FontSizeDown` |
| Reset font to default | `Atl+Ctrl+=`                 | `FontDefault`  |

## Installation

A simple way to install the plugin is via a plugin manager. E.g., [packer.nvim][3]

```lua
use {
  "tenxsoydev/size-matters.nvim",
  requires = {
    'rcarriga/nvim-notify'
  }
}
```

### Requirements

nvim >= v0.7. As the vim.api that was introduced with v0.7 is used.<br>
Being the latest stable release, we'll recommend upgrading your application and config when possible.

## Outlook

- [x] Improve notification for updating the font-size
- [ ] Export options. E.g., for custom mappings / notification visibility
- [ ] Branch with support for versions \< 0.7 (if there is a commuinty need for it)

[1]: https://github.com/neovide/neovide
[2]: https://github.com/akiyosi/goneovim
[3]: https://github.com/wbthomason/packer.nvim
