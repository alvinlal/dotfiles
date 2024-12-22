return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			offsets = {
				{
					filetype = "NvimTree",
					text = "Nvim Tree",
					separator = true,
					text_align = "left",
				},
			},
			mode = "tabs",
			separator_style = "slant",
		},
	},
}
