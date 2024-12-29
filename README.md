# x509 nvim

A basic neovim plugin for getting information

TODO: put animation here

https://github.com/user-attachments/assets/d4cb47f9-3db2-433d-b521-e0165c41a259

# Dependencies

- openssl

Ubuntu: ```sudo apt install openssl```

Arch Linux: ```sudo pacman -S openssl```

Others: check your package manager

# Features

- View certificate in a new buffer
- View certificate ASN.1 information in a new buffer

# Installation

Lazy.nvim:

```lua
{
    "johannww/x509.nvim",
    cmd = { "ViewCert", "ViewCertVisual", "ViewCertAsn1", "ViewCertAsn1Visual" },
    keys = {
        { "<leader>xc", "<cmd>ViewCert<cr>" },
        { "<leader>xc", "<cmd>ViewCertVisual<cr>", mode = "v" },
        { "<leader>xa", "<cmd>ViewCertAsn1<cr>" },
        { "<leader>xc", "<cmd>ViewCertAsn1Visual<cr>", mode = "v" },
    },
    config = function() require("x509-nvim").setup() end,
},
```

# Configuration

TODO

# Usage

TODO
