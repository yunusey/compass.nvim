# compass.nvim 🧭
Quickly iterate through your pages using hints provided. 😎



https://user-images.githubusercontent.com/107340417/225804632-f61ec0e2-a25a-4847-bde1-16431802a915.mp4

* You can go windows by typing lower-cased string!

* You can close windows by typing upper-cased string!

* You can swap two windows by selecting two windows by clicking Alt key and lower-cased string at the same time!

![Example](https://user-images.githubusercontent.com/107340417/225804688-c7c46657-1dd9-409f-9b23-34acf3858557.png)


# Setup 📦
You can setup using different package managers.

## Packer
```lua
-- In init.lua
use 'yunusey/compass.nvim'
require('compass').setup({
  	-- your config here
})
```

## Lazy 💤
```lua
-- In lua/plugins/compass.lua
local spec = {
  	"yunusey/compass.nvim",
  	configure = function ()
    	require('compass').setup({
      		-- your config here
    	})
  	end
}
return spec 
```

PS: There are also other package managers that you can use...

# Configuration ⚙️
`compass.nvim` comes with several default options:
```lua
M.def_opts = { -- Default options
	highlight_goto  = { fg = "#00ff00" },
	highlight_close = { fg = "#ff0000" },
	highlight_swap  = { fg = "#ffff00" },
	hlgoto  = "CompassGotoWindow",
	hlclose = "CompassCloseWindow",
	hlswap  = "CompassSwapWindow",

	format = "#g#c\n#s",
	selected_str = '🟢',

	precedence = { -- Sets the precedence for letters to be used
		'j', 'k', 'h',
		'l', 'a', 's',
		'd', 'f', 'g',
		'w', 'e', 'r',
		't', 'y', 'u',
		'i', 'o', 'c',
		'v', 'b', 'n',
	},

	cancel = "q", -- When clicked, closes the compass...

	window = { -- Gets the same argument as |nvim_open_win|
		width  = 5,
		height = 2,
		border = "rounded",
		style  = "minimal",
	},

	keymaps = {
		i = "",
		n = "<leader>ww",
		v = "",
	},

}
```

## Highlighting
You can change the color and the style of the highlights. Takes the same arguments with ```|vim.api.nvim_set_hl|```. You can also change the highlight-names.

* `CompassGotoWindow`: This highlight is used for highlighting the lower-cased string which is a key to go to that window.

* `CompassCloseWindow`: This highlight is used for highlighting the upper-cased string which is a key to close that window.

* `CompassSwapWindow`: This highlight is used for highlighting the `<A-{string}>` which is a key to select the window.

PS: By default;

`CompassGotoWindow` is highlighted green to show that that key is used for going that window.

`CompassCloseWindow` is highlighted red to show that key is used for closing that window

`CompassSwapWindow` is highlighted yellow to show that key is used for selecting that window.

## Format

Format is the format string of the hint windows. You can use '\n' chars for starting new lines.

* `#g` for go-string.

* `#c` for close-string.

* `#s` for swap-string.

One example is given below:

```lua
format = "#g\n#c\n#s"
```

This should give you a hint-window like this:

![Format](https://user-images.githubusercontent.com/107340417/225805119-f0601668-0943-4731-8b69-e3ace162a0a6.png)


## Selected String
The buffer's text will change to `selected_str` when that window is selected. 

## Precedence
You can set your ```precedence```. While creating hints, compass iterates through all the ```precedence``` table. Say you have three windows open, and your precedence table is the following:
```lua
precedence = {"j", "k", "l", "h", --[[other strs...]]}
```

`compass.nvim` assigns the first element (`j`) to the first window. Second element (`k`) to the second window. Third element (`l`) to the last window. Since all the windows have their own element assigned, iteration will end...
 
## Cancel
You can cancel the operation by pressing 'q' by default. If you want to set anoter key, you need to change `cancel` key of `opts`.

## Window
You can change the width and the height of the hint-windows. Also, you can change the border & style. For more info, see ```|vim.api.nvim_open_win|```

## Keymaps
`compass.nvim` comes with some default keymaps. You can either override, or delete them.

### For deleting keymaps:

```lua
local compass = require('compass')
compass.setup({
	-- Your other configs
	keymaps = {}, -- Assign it to an empty table
	-- Your other configs
})
```

### For overriding keymaps:

```lua
local compass = require('compass')
compass.setup({
	-- Your other configs
	keymaps = {
		n = "<C-w",
		-- From now on, whenever you type 'Control-W' in normal mode, compass will be executed...
		i = ",w",
		-- From now on, whenever you type ',w' in insert mode, compass will be executed
		v = "<leader>ww",
		-- From now on, whenever you type '<leader>ww' in visual mode, compass will be executed
	}, -- Assign it to an empty table
	-- Your other configs
})
```

PS: You do not necessarily need to fill for every mode. When you do not put a mode as a key, it'll not set a keymap for that mode.

# Contribution ✨
All the contributions are highly appreciated. Please, make sure that you are creating issues about the bugs and enhancements you found. For questions about the plugin, please reach me out.

# TODOs ⚡
* Create ```docs/```
* Get tabline in the game (such hard thing 😐🥲)

# Closing Words 📝
This plugin is actively getting updates, make sure to update your plugin very often.

Thank you for visiting compass.nvim! Make sure to leave a star 😏
