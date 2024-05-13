return {
	"mhartington/formatter.nvim",
	opts = {},
	config = function()
		local mason_bin = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/"

		local function googleJavaFormat()
			return {
				exe = mason_bin .. "google-java-format",
				args = { "-" },
				stdin = true,
			}
		end

		local function zprint()
			return {
				exe = "zprint",
				args = { "'{:style :respect-nl}'" },
				stdin = true,
			}
		end

		local function cljfmt()
			return {
				exe = "cljfmt",
				args = { "fix -" },
				stdin = true,
			}
		end

		local function cljstyle()
			return {
				exe = "cljstyle",
				args = { "pipe" },
				stdin = true,
			}
		end

		local function fantomas()
			return {
				exe = "fantomas",
				args = { "-" },
				stdin = true,
			}
		end

		local function hindent()
			return {
				exe = "hindent",
				args = { "--indent-size=2" },
				stdin = true,
			}
		end

		local function ocamlformat()
			local filename = vim.fn.expand("%:t")
			return {
				exe = "ocamlformat",
				args = {
					"-",
					"--name=" .. filename,
					"--enable-outside-detected-project",
				},
				stdin = true,
			}
		end

		local function ormolu()
			return {
				exe = "ormolu",
				args = { "--stdin-input-file=/home/vincebae/.cabal" },
				stdin = true,
			}
		end

		local function scalafmt()
			return {
				exe = "scalafmt",
				args = { "--stdin" },
				stdin = true,
			}
		end

		local function xmlformat()
			return {
				exe = "xmlformat",
				args = { "-" },
				stdin = true,
			}
		end

		local opts = {
			filetype = {
				clojure = cljfmt,
				haskell = ormolu,
				fsharp = fantomas,
				java = googleJavaFormat,
				lua = require("formatter.filetypes.lua").stylua,
				sbt = scalafmt,
				scala = scalafmt,
				ocaml = ocamlformat,
				xml = xmlformat,
			},
		}

		require("formatter").setup(opts)
	end,
}
