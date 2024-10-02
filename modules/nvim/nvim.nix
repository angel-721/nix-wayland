{ config, pkgs, ... }:


{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    
    # Plugin dependencies
    extraPackages = with pkgs; [
      ripgrep
      nil # nix langserver
	  alejandra
	  xclip # for copy to clipboard
	  codespell
    ];

    plugins = with pkgs.vimPlugins; [
      neodev-nvim
      telescope-fzf-native-nvim
	  #copilot-vim
	  tokyonight-nvim

      cmp_luasnip
      cmp-nvim-lsp
	  cmp-path
	  cmp-cmdline
	  cmp-git
	  nvim-surround

      luasnip
      friendly-snippets
	  gitgutter
      lualine-nvim
      nvim-web-devicons
	  vim-commentary

	  nvim-autopairs
	  alpha-nvim

	  {
	    plugin = conform-nvim ; 
		type = "lua";
		config = builtins.readFile(./plugins/conform.lua);
	  }
	  {
	    plugin = nvim-tree-lua; 
		type = "lua";
		config = builtins.readFile(./plugins/nvim-tree.lua);
	  }

      {
        plugin = nvim-lspconfig;
		type = "lua";
		config = builtins.readFile(./plugins/lsp.lua);
      }

      {
        plugin = nvim-cmp;
		type = "lua";
		config = builtins.readFile(./plugins/cmp.lua);
      }
      {
        plugin = telescope-nvim;
		type = "lua";
		config = builtins.readFile(./plugins/telescope.lua);
      }
      

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-python
          p.tree-sitter-json
	      p.tree-sitter-cpp
	      p.tree-sitter-c
          p.tree-sitter-css
          p.tree-sitter-lua
          p.tree-sitter-html
          p.tree-sitter-javascript
          p.tree-sitter-markdown
          p.tree-sitter-svelte
          p.tree-sitter-nim
          p.tree-sitter-astro
          p.tree-sitter-rust
          p.tree-sitter-zig
        ]));
		type = "lua";
        config = builtins.readFile(./plugins/treesitter.lua);
      }

    ];

    extraLuaConfig = builtins.readFile(./init.lua);
  };

}

