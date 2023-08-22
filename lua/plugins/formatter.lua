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

        local function cljstyle()
            return {
                exe = "cljstyle",
                args = { "pipe" },
                stdin = true,
            }
        end

        local opts = {
            filetype = {
                clojure = cljstyle,
                java = googleJavaFormat,
                lua =  require("formatter.filetypes.lua").stylua,
            },
        }

        require("formatter").setup(opts)
    end,
}
