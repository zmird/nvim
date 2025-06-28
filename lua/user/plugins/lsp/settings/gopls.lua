return {
	settings = {
	  gopls = {
      lintTool = "golangci-lint",
      formatTool = "gofumpt",
      semanticTokens = true,
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        unusedwrite = true,
        unusedvariable = true,
      },
      formatting = {
        gofumpt = true
      },
      ui = {
        diagnostic = {
          staticcheck = true
        }
      }
    }
	},
}
