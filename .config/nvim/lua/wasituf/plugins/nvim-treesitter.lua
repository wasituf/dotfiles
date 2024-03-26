return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'windwp/nvim-ts-autotag',
    },
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function () 
        local configs = require("nvim-treesitter.configs")

        require('nvim-ts-autotag').setup()

        configs.setup({
            ensure_installed = { 
                "c", 
                "lua", 
                "vimdoc", 
                "query", 
                "javascript", 
                "typescript", 
                "html", 
                "css", 
                "scss", 
                "graphql", 
                "gdscript",
                "go",
                "svelte", 
                "python", 
                "vim", 
                "regex", 
                "bash", 
                "markdown", 
                "markdown_inline", 
            },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },  
            autotag = { 
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
            },
        })
    end
}
