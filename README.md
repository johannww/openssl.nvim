# openssl nvim

A basic neovim plugin for showing information on **certificates, crls, csrs, and keys** with openssl

https://github.com/user-attachments/assets/d4cb47f9-3db2-433d-b521-e0165c41a259

# Dependencies

- openssl

Ubuntu: ```sudo apt install openssl```

Arch Linux: ```sudo pacman -S openssl```

Others: check your package manager

# Features

- View certificates, crls, csrs, and keys in a new buffer
- View certificates, crls, csrs, and keys ASN.1 information in a new buffer

# Installation

Lazy.nvim:

```lua
{
    "johannww/openssl.nvim",
    cmd = { "OpensslView", "OpensslViewVisual", "OpensslViewAsn1", "OpensslViewAsn1Visual" },
    keys = {
        { "<leader>xc", "<cmd>OpensslView<cr>" },
        { "<leader>xc", "<cmd>OpensslViewVisual<cr>", mode = "v" },
        { "<leader>xa", "<cmd>OpensslViewAsn1<cr>" },
        { "<leader>xa", "<cmd>OpensslViewAsn1Visual<cr>", mode = "v" },
    },
    config = function() require("openssl-nvim").setup() end,
},
```

# Configuration

TODO

# DISCLAIMER

This project has no relations with the [OpenSSL Project](https://github.com/openssl/openssl). 
