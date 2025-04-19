# 🧩 Tailwind LSP Bridge for Dart

**Bring TailwindCSS class autocomplete into Dart files—using regex-based LSP forwarding.**

This project sets up a dual LSP configuration in Neovim that:

- Parses Dart files
- Matches `class: "..."` or similar strings using regex including string arrays
- Forwards those matches to the TailwindCSS LSP
- Returns real-time autocomplete inside strings and inline css implementation 

### 🧠 Why?

Tailwind autocomplete doesn't work inside Dart files out of the box. 
But what if your UI is dynamically generating class names? This bridge gives you Tailwind IntelliSense anywhere—without rewriting your toolchain.


### 🚀 Demo

![example.gif](doc/example.gif)

> Shown: Dart file with Tailwind class autocomplete from the Tailwind LSP

### 🔧 How it works

1. **Dart file** is parsed by the Dart LSP (for normal completions)
2. **Regex** finds potential Tailwind class strings (like `class: "btn btn-primary"`)
3. **Tailwind LSP** is triggered manually or auto-forwarded just for that string
4. **Completion items** are shown right inside Dart files, from the Tailwind LSP

This is made possible by Neovim's flexible LSP architecture and a custom Lua config.

### ⚙️ Prerequisites

- Neovim `>=0.8`
- `nvim-lspconfig`
- Tailwind LSP
- Dart SDK + Dart LSP
- Lua-based regex match logic (included)
- tailwind.config.js in root of project directory

### 🛠️ Manual Setup

```lua
-- inside your LSP config
  require('lspconfig').tailwindcss.setup {
        capabilities = capabilities, -- Use shared capabilities
        -- on_attach is handled by the LspAttach autocommand group
        filetypes = {
          'dart',
          'html',
          'css',
          'javascript',
          'typescript',
          'javascriptreact',
          'typescriptreact',
          'vue',
          'svelte',
          'rust',
          'elixir',
          'heex',
          'astro',
          'glimmer',
          'handlebars',
          'php',
          'erb',
        }, -- Include dart and others
        root_dir = require('lspconfig').util.root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', 'package.json', 'pubspec.yaml'),
        settings = {
          tailwindCSS = {
            includeLanguages = { dart = 'html' },
            classAttributes = { 'class', 'className', 'style' },
            experimental = {
              classRegex = { -- Your regex for Dart/Jaspr style classes
                {
                  'classes\\s*:\\s*\\[([^\\]]*)\\]\\s*\\.join\\(\\s*[\'"][^\'"]*[\'"]\\s*\\)',
                  '[\'"]([^\'"]+)[\'"]',
                },
                "classes\\s*:\\s*'([^']*)'",
                'classes\\s*:\\s*"([^"]*)"',
                -- Add standard class attribute regex if needed
                'class\\s*=\\s*"([^"]*)"',
                "class\\s*=\\s*'([^']*)'",
                'className\\s*=\\s*"([^"]*)"',
                "className\\s*=\\s*'([^']*)'",
              },
            },
            validate = true,
          },
        },
      }
    end, -- End of lspconfig config function
  },

