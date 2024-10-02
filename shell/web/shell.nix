let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  packages = with pkgs; [
    nodejs
	vscode-langservers-extracted
	prettierd

	(with nodePackages;[
	  svelte-language-server
	  typescript-language-server
	])

  ];

  shellHook = ''
    echo "You have entered the Node.js environment."

    # Change the shell prompt to display "node" (optional)
    export PS1="\[\e[0;32m\]Node\[\e[0m\] \W \$ "
  '';
}
