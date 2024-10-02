let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  packages = with pkgs; [
  	nim2
	nimlsp

  ];

  shellHook = ''
    echo "You have entered the Nim environment."

    # Change the shell prompt to display "node" (optional)
    export PS1="\[\e[0;32m\]Nim\[\e[0m\] \W \$ "
  '';
}
