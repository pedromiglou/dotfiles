{ config, lib, pkgs, unstable, nixGL, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    autenticacao-gov-pt-bin
    ansible
    brave
    discord
    fastfetch
    gimp
    gamemode
    gamescope
    (heroic.override {
      extraPkgs = pkgs': with pkgs'; [
        gamescope
        gamemode
      ];
    })
    hyprpolkitagent
    hyprshot
    librewolf
    nerd-fonts.ubuntu-mono  # Monospaced (Ideal for terminal / text editor)
    nerd-fonts.ubuntu       # Proportional (Original Ubuntu interface font)
    nerd-fonts.ubuntu-sans  # Refreshed Ubuntu Sans version
    unstable.noctalia-shell
    obsidian
    onlyoffice-desktopeditors
    spotify
    steam
    supertux
    terminator
    terraform
    # tokyo-night-gtk
    tree
    vlc
    vscode
    wget
  ];

  programs.git.enable = true;
  programs.java.enable = true;
  programs.starship.enable = true;

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
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
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
  };
}