{ config, pkgs, lib, inputs, unstable, nixGL, ... }:

{
  home.packages = [
    (config.lib.nixGL.wrap pkgs.terminator)
    unstable.noctalia-shell
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
  
  # Swaylock is installed with apt
  xdg.configFile."swaylock".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/swaylock";

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  #   config = {
  #     common = {
  #       default = [ "hyprland" "gtk" ];
  #     };
  #   };
  # };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme.name = "Tokyonight-Dark";
    theme.package = pkgs.tokyonight-gtk-theme;
    iconTheme.name = "Reversal-blue-dark";
    iconTheme.package = pkgs.reversal-icon-theme.override {
      colorVariants = [ "blue" ];
    };
    font = {
      name = "Ubuntu";
      size = 10;
    };
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors; # Replace with your preferred cursor package
    name = "Bibata-Modern-Classic"; # Exact theme folder name
    size = 24;
  };

  # Ensures Fontconfig indexes the fonts
  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      sansSerif = [ "Ubuntu" ];
      serif = [ "Ubuntu" ];
      monospace = [ "Ubuntu Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # Cinnamon Settings
  dconf.settings = {
    "org/cinnamon/desktop/interface" = {
      gtk-theme = "Tokyonight-Dark";
      icon-theme = "Reversal-blue-dark";
      cursor-theme = "Bibata-Modern-Classic";
      font-name = "Ubuntu 10";
    };

    "org/cinnamon/theme" = {
      name = "Tokyonight-Dark";
    };

    "org/cinnamon/desktop/background" = {
      picture-uri = "file://${config.home.homeDirectory}/.wallpaper";
      picture-options = "stretch";
      primary-color = "#1a1b26";
    };
  };
}