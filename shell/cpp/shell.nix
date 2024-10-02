let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  clang = pkgs.clang; # Adjust the version number as needed
in pkgs.mkShell {
  packages = [
    pkgs.gnumake
    pkgs.gdb
    pkgs.clang-tools
    pkgs.libclang
	pkgs.libcxx
  ];

  shellHook = ''
    echo "You have entered the C++ environment."
    export PS1="\[[\e[0;32m\]C++:\[\e[0m\]\w \$] "

    # Set CPATH
    export CPATH=${lib.makeSearchPathOutput "dev" "include" [pkgs.libcxx]}:${lib.makeSearchPath "resource-root/include" [clang]}
	export PATH=${clang}/bin:$PATH

  '';
}
