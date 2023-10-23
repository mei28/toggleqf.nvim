# toggleqf

Easily toggle the visibility of Neovim's quickfix and location list windows.

<!-- ![toggleqf demo](path-to-your-gif-or-image-demo.gif)   -->
<!-- *Above: A quick demonstration of `toggleqf` in action* -->

## Features

- Toggle the visibility of the quickfix window.
- Toggle the visibility of the location list window.
- Cycle through possible states of the quickfix and location windows.
- Check the state and contents of these windows using provided functions.

## Installation

Using `Lazy`:

```lua
return {
    'mei28/toggleqf.nvim',
    config = function() require('toggleqf').setup() end,
    event = 'VeryLazy'
}
```

Or using any other plugin manager of your choice.

## Usage

### Keybindings

- Toggle quickfix window: `<Leader>qt`
- Toggle location list window: `<Leader>lt`
- Cycle through states: `<C-g><C-o>`

### API

You can use the provided functions in your scripts or custom commands:

```lua
local tqf = require'toggleqf'
tqf.toggle_quickfix()
tqf.toggle_location()
```

## Configuration

You can customize the default keybindings:

```lua
require'toggleqf'.setup({
    keymap = {
        quickfix_loop = '<C-g><C-o>',
        quickfix_toggle = '<Leader>qt',
        location_toggle = '<Leader>lt'
    }
})
```

## License

This plugin is provided under the MIT license. See `LICENSE` for details.
