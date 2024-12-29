# x509 nvim

A basic neovim plugin for getting information

TODO: put animation here

# Dependencies

- openssl

Ubuntu: ```sudo apt install openssl```

Arch Linux: ```sudo pacman -S openssl```

Others: check your package manager

# Installation

Lazy.nvim:

```lua
{
    "johannww/x509.nvim",
    cmd = { "ViewCert", "ViewCertVisual", "ViewCertAsn1", "ViewCertAsn1Visual" },
    config = function() require("x509-nvim").setup() end,
}```

# Configuration

TODO

# Usage

TODO
