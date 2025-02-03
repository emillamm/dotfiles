return {
    setup = function(add)
	add('echasnovski/mini.base16')
	add('shaunsingh/nord.nvim')
	add('slugbyte/lackluster.nvim')
	add('bettervim/yugen.nvim')

--local lackluster = require("lackluster")
--
--lackluster.setup({
--  tweak_color = {
--    -- Lighten the main "lack" and "luster" colors for better readability
--    lack   = "#c2c9d1",  -- was "#708090"; softer/lighter gray-blue
--    luster = "#f1f3f3",  -- was "#deeeed"; a brighter near-white
--
--    -- Softer (more pastel) accents:
--    orange = "#ffc2ab",  -- was "#ffaa88"
--    yellow = "#ddddaa",  -- was "#abab77"
--    green  = "#a2c9a2",  -- was "#789978"
--    blue   = "#a0bade",  -- was "#7788AA"
--    red    = "#ff8a8a",  -- was "#D70000"
--
--    -- Increase gray scale brightness so text stands out on black
--    -- ("black" is used in certain UI elements as well)
--    --black = "#0e0e0e",   -- was "#000000"
--    gray1 = "#1a1a1a",   -- was "#080808"
--    gray2 = "#2a2a2a",   -- was "#191919"
--    gray3 = "#3b3b3b",   -- was "#2a2a2a"
--    gray4 = "#585858",   -- was "#444444"
--    gray5 = "#6a6a6a",   -- was "#555555"
--    gray6 = "#9a9a9a",   -- was "#7a7a7a"
--    gray7 = "#cccccc",   -- was "#aaaaaa"
--    gray8 = "#dddddd",   -- was "#cccccc"
--    gray9 = "#f0f0f0",   -- was "#DDDDDD"
--  },
--})

	vim.cmd[[colorscheme nord]]
	--vim.cmd[[colorscheme lackluster]]
	--vim.cmd[[colorscheme yugen]]

    end
}
