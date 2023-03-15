# compass.nvim
Quickly iterate through your pages using hitns provided. :sunglasses:

![Example](https://user-images.githubusercontent.com/107340417/225203822-956b351c-5c3e-492e-b22d-4b1f226d969a.png)

https://user-images.githubusercontent.com/107340417/225202546-4e4cb239-5f6f-47bd-bdbf-b0668749f012.mp4

# Setup
You can setup using different package managers.

## Packer
```lua
use 'yunusey/compass.nvim'
require('compass').setup({
  -- your config here
})
```

## Lazy
```lua
-- In lua/plugins/
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

# Configuration
`compass.nvim` comes with several default options:
```lua
M.def_opts = { -- Default options
	highlight = { fg = "#00ff00" },
	hlname = "CompassHintWindow",
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
	}
}

```
You can change the color and the style of the highlight. Takes the same arguments with ```|vim.api.nvim_set_hl|```. You can also change the command-prompt by changing ```hlname```. 

You can set your precedence. While creating hints, compass iterates through all the precedence.

You can change the width and the height of the hint-windows. Also, you can change the border & style. For more info, see ```|vim.api.nvim_open_win|```

# Contribution
All the contributions are highly appreciated. Please, make sure that you are creating issues about the bugs and enhancements you found. For questions about the plugin, please reach me out.

# TODOs
* Create ```docs/```
* Make a better documentation for github
* Get tabline in the game (such hard thing 😐🥲)

Thank you for visiting compass.nvim! Make sure to leave a star :smirk: 
