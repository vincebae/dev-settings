-- Scala specific Snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("scala", {
	s("shebang", {
		-- t({"#!/usr/bin/env amm", ""}),
		t({ "#!/usr/bin/env -S scala-cli shebang -S 3 --bloop-version 1.5.12-sc-1", "" }),
	}),
}, { key = "scala" })
