let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  packages = with pkgs; [
  	zig
  ];

  shellHook = ''
    echo "You have entered the Zig environment."
    export PS1="\[\e[0;32m\]Zig\[\e[0m\] \W \$ "
  '';
}
