# compass.nvim 🧭
Quickly iterate through your pages using hints provided. 😎

**PS: There is a new feature uploaded, which basically closes the windows. If this note is not deleted, it means that I did not change the video and the image yet! Please check Configuration**

**NEW FEATURES UPCOMING**

![](https://user-images.githubusercontent.com/107340417/225203822-956b351c-5c3e-492e-b22d-4b1f226d969a.png)

https://user-images.githubusercontent.com/107340417/225202546-4e4cb239-5f6f-47bd-bdbf-b0668749f012.mp4

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
	highlight_goto = { fg = "#00ff00" },
	highlight_close = { fg = "#ff0000" },
	hlgoto  = "CompassGotoWindow",
	hlclose = "CompassCloseWindow",
	precedence = { -- Sets the precedence for letters to be used
		'j', 'k', 'h',
		'l', 'a', 's',
		'd', 'f', 'g',
		'w', 'e', 'r',
		't', 'y', 'u',
		'i', 'o', 'c',
		'v', 'b', 'n',
	},
	window = { -- Gets the same argument as |nvim_open_win|
		width  = 2,
		height = 1,
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

PS: By default, `CompassGotoWindow` is highlighted green to show that that key is used for going that window while `CompassCloseWindow` is highlighted red to show that key is used for closing that window. 

## Precedence
You can set your ```precedence```. While creating hints, compass iterates through all the ```precedence``` table. Say you have three windows open, and your precedence table is the following:
```lua
precedence = {"j", "k", "l", "h", --[[other strs...]]}
```

`compass.nvim` assigns the first element (`j`) to the first window. Second element (`k`) to the second window. Third element (`l`) to the last window. Since all the windows have their own element assigned, iteration will end...

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

# Closing Words
This plugin is actively getting updates, make sure to update your plugin very often.

Thank you for visiting compass.nvim! Make sure to leave a star 😏
