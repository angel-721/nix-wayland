{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/nvim/nvim.nix
	./modules/alacritty/alacritty.nix
  ];

  home.username = "angel";
  home.homeDirectory = "/home/angel";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
	fastfetch
	wlr-randr
	nushell
	ouch
	networkmanagerapplet
	starship
  ];


  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  home.file = {
  };

  home.sessionVariables = {
     EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
