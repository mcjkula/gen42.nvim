# Gen42.nvim

Gen42.nvim is a Neovim plugin that integrates with the Gen42 AI API to provide intelligent code completion and assistance directly within your Neovim environment.

## Features

- Seamless integration with Neovim's workflow
- AI-powered code completion
- Context-aware code suggestions
- Interactive question-answering about selected code

## Requirements

- Neovim
- Gen42 API key

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return {
  "mcjkula/gen42.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("gen42").setup({
      api_key = "YOUR_API_KEY_HERE",
    })
  end,
}
```

## Usage

1. Select code in visual mode
2. Run the command `:Gen42Question`
3. Enter your question about the selected code
4. View the AI-generated response in a new buffer

## Commands

- `:Gen42Question`: Ask a question about the selected code

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Gen42 AI](https://www.gen42.ai/) for providing the AI API
