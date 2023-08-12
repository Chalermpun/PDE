local wilder = require("wilder")

local gradient = {
	"#f4468f",
	"#fd4a85",
	"#ff507a",
	"#ff566f",
	"#ff5e63",
	"#ff6658",
	"#ff704e",
	"#ff7a45",
	"#ff843d",
	"#ff9036",
	"#f89b31",
	"#efa72f",
	"#e6b32e",
	"#dcbe30",
	"#d2c934",
	"#c8d43a",
	"#bfde43",
	"#b6e84e",
	"#aff05b",
}

for i, fg in ipairs(gradient) do
	gradient[i] = wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
end

wilder.setup({ modes = { ":", "/", "?" } })

wilder.set_option("pipeline", {
	wilder.branch(
		wilder.python_file_finder_pipeline({
			file_command = { "fd", "-tf" },
			dir_command = { "fd", "-td" },
			filters = { "fuzzy_filter", "difflib_sorter" },
		}),
		wilder.substitute_pipeline({
			pipeline = wilder.python_search_pipeline({
				skip_cmdtype_check = 1,
				pattern = wilder.python_fuzzy_pattern({
					start_at_boundary = 0,
				}),
			}),
		}),
		wilder.cmdline_pipeline({
			fuzzy = 2,
			fuzzy_filter = wilder.lua_fzy_filter(),
		}),
		{
			wilder.check(function(ctx, x)
				return x == ""
			end),
			wilder.history(),
		},
		wilder.python_search_pipeline({
			pattern = wilder.python_fuzzy_pattern({
				start_at_boundary = 0,
			}),
		})
	),
})

local highlighters = {
	wilder.pcre2_highlighter(),
	wilder.highlighter_with_gradient({
		wilder.basic_highlighter(),
	}),
}

local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
	border = "rounded",
	empty_message = wilder.popupmenu_empty_message_with_spinner(),
	highlighter = highlighters,
	highlights = {
		gradient = gradient, -- must be set
	},
	left = {
		" ",
		wilder.popupmenu_devicons(),
		wilder.popupmenu_buffer_flags({
			flags = " a + ",
			icons = { ["+"] = "", a = "", h = "󰈤" },
		}),
	},
	right = {
		" ",
		wilder.popupmenu_scrollbar(),
	},
}))

local wildmenu_renderer = wilder.wildmenu_renderer({
	highlighter = highlighters,
	highlights = {
		gradient = gradient, -- must be set
	},
	separator = " · ",
	left = { " ", wilder.wildmenu_spinner(), " " },
	right = { " ", wilder.wildmenu_index() },
})

wilder.set_option(
	"renderer",
	wilder.renderer_mux({
		[":"] = popupmenu_renderer,
		["/"] = wildmenu_renderer,
		substitute = wildmenu_renderer,
	})
)
