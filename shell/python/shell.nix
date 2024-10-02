let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  packages = [
    pkgs.pyright #lsp
	pkgs.ruff #formatter
    (pkgs.python3.withPackages (python-pkgs: [
		# Later set this up to read from reqs.txt
    ]))
  ];

  shellHook = ''
    echo "You have entered the Python environment."

    # Change the shell prompt to display "python"
    export PS1="\[[\e[0;32m\]Python:\[\e[0m\]\w \$] "
  '';
}
