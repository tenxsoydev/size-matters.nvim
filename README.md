# size-matters.nvim

Soydev plugin series. 

Lua plugin that adds dynamic font scaling to modern neovim GUI clients like [neovide][1] or [goneovim][2].

| **Keymaps**           |                            |
| --------------------- | -------------------------- |
| Increase font size    | `Ctrl++` / `Ctrl+ScrollUp`   |
| Decrease font size    | `Ctrl+-` / `Ctrl+ScrollDown` |
| Reset font to default | `Atl+Ctrl+=`                  |

## Installation

Simplest way to install it is via ia a plugin manager. E.g., [packer.nvim][3]

```lua
use "tenxsoydev/size-matters.nvim"
```

### Requirements

nvim >= v0.7. As the vim.api that was introduced with v0.7 is used.<br>
Being the latest stable release, we'll recommend upgrading your application and config when possible.

## Outlook

- [ ] Pop-up indicator for current font-size when switching
- [ ] Export options. E.g., for custom mappings / Pop-up visibility
- [ ] Branch with support for versions \< 0.7 (if there is a commuinty need for it)

[1]: https://github.com/neovide/neovide
[2]: https://github.com/akiyosi/goneovim
[3]: https://github.com/wbthomason/packer.nvim
