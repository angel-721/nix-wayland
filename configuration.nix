{ config, pkgs, lib, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/NewYork";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  security.doas.enable = true;
  security.sudo.enable = false;

  security.doas.extraRules = [{
  users = ["angel"];
  keepEnv = true; 
  persist = true; 
}];


  services.xserver.enable = true;

  users.users.angel = {
    isNormalUser = true;
    description = "Angel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
	  feh
	  brightnessctl
	  pciutils
	  google-chrome
	  gcc
	  openconnect
	  yazi
	  discord
	  spotify
	  betterdiscord-installer
	  betterdiscordctl
	  ueberzugpp
	  home-manager
	  pciutils
	  kitty
	  rofi-wayland
	  grim slurp waybar dunst wl-clipboard swaynotificationcenter

	  # Communication and social
      slack zoom-us
    ];
  };
  programs.hyprland.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  fonts.packages = with pkgs; [
    noto-fonts-emoji
    roboto
    noto-fonts-cjk
    font-awesome
    material-icons
	nerdfonts
  ];
xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };



#  services.xserver.windowManager.dwm.enable = true;
#  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
#    src = /home/angel/.config/dwm;
#  };
#
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    git
	pulseaudio
  ];

  #enable sound
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
  };


  system.stateVersion = "23.11"; # Did you read the comment?
  services.thermald.enable = true;
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
};

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
