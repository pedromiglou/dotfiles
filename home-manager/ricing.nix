{ config, pkgs, lib, inputs, nixGL, ... }:

{
  # Ensures Fontconfig indexes the fonts
  fonts.fontconfig.enable = true;

  home.packages = [
    (config.lib.nixGL.wrap pkgs.terminator)
    pkgs.noctalia-shell
    pkgs.fastfetch
    pkgs.wl-clipboard
    pkgs.slurp
    pkgs.grim
    pkgs.nerd-fonts.ubuntu-mono  # Monospaced (Ideal for terminal / text editor)
    pkgs.nerd-fonts.ubuntu       # Proportional (Original Ubuntu interface font)
    pkgs.nerd-fonts.ubuntu-sans  # Refreshed Ubuntu Sans version
  ];

  programs.starship.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.hyprland;
    configType = "lua";
    extraConfig = builtins.readFile ./hyprland.lua;
    systemd.enable = true;
    systemd.variables = ["--all"];
  };
  xdg.configFile."hypr/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/hypr";
  xdg.configFile."noctalia".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/noctalia";
  xdg.configFile."terminator".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/terminator";

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  #   config = {
  #     common = {
  #       default = [ "hyprland" "gtk" ];
  #     };
  #   };
  # };

  # gtk = {
  #   enable = true;
  #   theme.name = "Tokyonight-Dark-Moon";
  #   theme.package = pkgs.tokyonight-gtk-theme;
  #   iconTheme.name = "Reversal Icons";
  #   iconTheme.package = pkgs.reversal-icon-theme;
  # };
}